local pickers = require("telescope.pickers")
local finders = require("telescope.finders")


local scandir = function (directory)
    local popen = io.popen
    local raw_files = popen('find' .. directory .. ' -maxdepth 1 -type d ')
    return vim.split(raw_files, '\n')
end

local directories = scandir('~/Documents/git')

local run = function(opts)
    opts = opts or {}

    local picker = pickers.new(opts, {
        prompt_title = "Project switcher",
        finder = finders.new_table({ results = directories})
    })

    return picker:find()
end

return require("telescope").register_extension({
    exports = {
        lil_project_switcher = run
    }
})
