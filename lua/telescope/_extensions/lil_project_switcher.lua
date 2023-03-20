local pickers = require("telescope.pickers")
local finders = require("telescope.finders")


local scandir = function(directory, maxdepth)
    maxdepth = maxdepth or 1
    local popen = io.popen
    local i, dirs = 0, {}
    local pfile = popen( "find " .. directory ..  " -maxdepth " .. maxdepth .. " -type d")
    for filename in pfile:lines() do
        i = i + 1
        dirs[i] = filename
    end

    return dirs
end


local run = function(opts)
    opts = opts or {}
    opts.maxdepth = opts.maxdepth or 1
    opts.directory = opts.directory or '~'

    local picker = pickers.new(opts, {
        prompt_title = "Project switcher",
        finder = finders.new_table({ results = scandir(opts.directory, opts.maxdepth)})
    })

    return picker:find()
end

return require("telescope").register_extension({
    exports = {
        lil_project_switcher = run
    }
})
