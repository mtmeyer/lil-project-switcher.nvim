local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local get_directory_name = function(directory, filename)
    local home_dir = vim.fn.expand(directory)
    return filename:gsub(home_dir .. '/', '')
end

local scandir = function(directory, maxdepth)
	local popen = io.popen
	local i, dirs = 0, {}
	local pfile = popen("find " .. directory .. " -maxdepth " .. maxdepth .. " -type d")
	for filename in pfile:lines() do
		i = i + 1
		dirs[i] = {filename, get_directory_name(directory, filename)}
	end

	return dirs
end

local run = function(opts)
	opts = opts or {}
	local directory = conf.directory or "~"
	local maxdepth = conf.maxdepth or 1
	local picker = pickers.new(opts, {
		prompt_title = "Project switcher",
		finder = finders.new_table({ 
            results = scandir(directory, maxdepth),
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry[1],
                    ordinal = entry[1]
                }
            end
        }),
	})

	return picker:find()
end

return require("telescope").register_extension({
	setup = function(ext_config, config)
		if ext_config.directory then
			config.directory = ext_config.directory
		end

		if ext_config.maxdepth then
			config.maxdepth = ext_config.maxdepth
		end
	end,
	exports = {
		lil_project_switcher = run,
	},
})
