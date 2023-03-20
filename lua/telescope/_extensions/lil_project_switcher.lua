local pickers = require("telescope.pickers")
local finders = require("telescope.finders")

local directories = vim.split(vim.fn.glob('~/Documents/git/personal/**/*'), '\n')

local run = function(opts)
    opts = opts or {}
    opts.cwd = "~/Documents/git"

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
