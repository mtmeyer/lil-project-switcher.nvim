local pickers = require("telescope.pickers")
local finders = require("telescope.finders")

local test = {
    "abc",
    "def",
}

local run = function(opts)
    opts = opts or {}
    opts.cwd = "~/Documents/git"

    local picker = pickers.new(opts, {
        prompt_title = "Project switcher",
        finder = finders.new_table({ results = test})
    })

    return picker:find()
end

return require("telescope").register_extension({
    exports = {
        lil_project_switcher = run
    }
})
