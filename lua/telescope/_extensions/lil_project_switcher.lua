local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local utils = require "telescope._extensions.utils"

local options = {}

local default_options = {
    directory = '~',
    maxdepth = 1,
}


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

    local picker = pickers.new(opts, {
        prompt_title = "Project switcher",
        finder = finders.new_table({ results = scandir(options.directory, options.maxdepth)})
    })

    return picker:find()
end

return require("telescope").register_extension({
    setup = function(ext_config, _)
        options = utils.assign({}, default_options, ext_config)
    end,
    exports = {
        lil_project_switcher = run
    }
})
