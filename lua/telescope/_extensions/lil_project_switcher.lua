local pickers = require("telescope.pickers")
local finders = require("telescope.finders")


local scandir = function(directory)
    local popen = io.popen
    local i, dirs = 0, {}
    local pfile = popen( "find " .. directory ..  " -maxdepth 1 -type d")
    for filename in pfile:lines() do
        i = i + 1
        dirs[i] = filename
    end

    return dirs
end


local run = function(opts)
    opts = opts or {}

    local picker = pickers.new(opts, {
        prompt_title = "Project switcher",
        finder = finders.new_table({ results = scandir('~/Documents/git')})
    })

    return picker:find()
end

return require("telescope").register_extension({
    exports = {
        lil_project_switcher = run
    }
})
