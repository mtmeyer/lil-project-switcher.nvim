local pickers = require("telescope.pickers")
local finders = require("telescope.finders")

local test = {
    "abc",
    "def",
}

local directories = vim.split(vim.fn.glob('~/Documents/git/'), '\n')

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
