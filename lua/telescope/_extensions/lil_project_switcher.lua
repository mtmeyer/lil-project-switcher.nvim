local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local get_directory_name = function(directory, filename)
	local home_dir = vim.fn.expand(directory)
	return filename:gsub(home_dir .. "/", "")
end

local scandir = function(directory, maxdepth, name)
	local popen = io.popen
	local i, dirs = 0, {}
	local pfile = popen("find " .. directory .. " -maxdepth " .. maxdepth .. " -type d")
	for filename in pfile:lines() do
		i = i + 1
		local tmp_object = { value = filename, display = name .. ": " .. get_directory_name(directory, filename) }
		dirs[i] = tmp_object
	end

	return dirs
end

local get_results_for_directory = function(directories, maxdepth)
	if type(directories) == "table" then
		local tmp_table = {}
		for _, value in ipairs(directories) do
			tmp_table = vim.tbl_deep_extend("keep", tmp_table, scandir(value.directory, maxdepth, value.name))
		end
		return tmp_table
	else
		error("Config error: directories must be a table. Refer to the readme for correct format.")
	end
end

local run = function(opts)
	opts = opts or {}
	local maxdepth = conf.maxdepth or 1
	local results = get_results_for_directory(conf.directories, maxdepth) or "~"
	local picker = pickers.new(opts, {
		prompt_title = "Project switcher",
		finder = finders.new_table({
			results = results,
			entry_maker = function(entry)
				return {
					value = entry.value,
					display = entry.display,
					ordinal = entry.display,
				}
			end,
		}),
	})

	return picker:find()
end

return require("telescope").register_extension({
	setup = function(ext_config, config)
		if ext_config.directories then
			config.directories = ext_config.directories
		end

		if ext_config.maxdepth then
			config.maxdepth = ext_config.maxdepth
		end
	end,
	exports = {
		lil_project_switcher = run,
	},
})
