local pickers = require("telescope.pickers")

local run = function(opts)
    opts = opts or {}
    opts.cwd = "~/Documents/git"

    local picker = pickers.new(opts, {
        prompt_title = "Project switcher"
    })

    return picker:find()
end

return require("telescope").register_extension({
    exports = {
        lil_project_switcher = run
    }
})
