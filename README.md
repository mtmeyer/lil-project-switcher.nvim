# Lil Project Switcher

A simple little project switcher for Neovim

## Installation

With [packer.nvim](https://github.com/wbthomason/packer.nvim):

Note: Make sure you have [Telescope](https://github.com/nvim-telescope/telescope.nvim) installed

```lua
use {"mtmeyer/lil-project-switcher.nvim"}
```

## Setup and configuration

```lua
require('telescope').setup {
    -- Existing telescope configuration.......
    extensions = {
        -- Existing extension configuration.......
        lil_project_switcher = {
            directories = { -- Not required, will use your $HOME directory by default
                {
                    directory = "~/SomeAwesomeDirectory",
                    name = 'Awesome projects'
                }
            },
            maxdepth = 2 -- Not required, how many directory levels deep do you want the extension to look for
        }
    }
}

-- Make sure this load extension call is after Telescope's setup function
require("telescope").load_extension("lil_project_switcher")
```

## Usage

You can use the following command to run this extension: `:Telescope lil_project_switcher`

The extension comes with no default mappings so you'll need to set this up yourself:

```lua
vim.api.nvim_set_keymap("n", "<leader>ps", ":Telescope file_browser")
```

## Todo

- Fix multi directory searching issue
- Fix no config directory default
- Have multiple root directories so you could have different remaps for different types of projects (e.g. work vs personal projects)
- Better formatting and display of results within Telescope
