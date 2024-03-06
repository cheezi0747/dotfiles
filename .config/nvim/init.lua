-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.call('plug#begin', '~/.config/nvim/plugged')

vim.cmd([[
    Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
    Plug 'nvim-tree/nvim-web-devicons' " optional
    Plug 'nvim-tree/nvim-tree.lua'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-context'
    Plug 'echasnovski/mini.nvim'
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'itchyny/lightline.vim'
    Plug 'glepnir/dashboard-nvim'
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
]])

vim.call('plug#end')

 -- Configure Catppuccino
require("catppuccin").setup({
    flavour = "frappe", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "frappe",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        cmp = true,
        gitsigns = true,
        dashboard = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        indent_blankline = {
            enabled = true,
            scope_color = "mauve", -- catppuccin color (eg. `lavender`) Default: text
            colored_indent_levels = true
        },
        mini = {
            enabled = true
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()
require('mini.colors').setup()
require('gitsigns').setup()
require('dashboard').setup()


local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require("ibl").setup { indent = { highlight = highlight } }

-- Set cursor options
vim.o.guicursor = "a:hor30-iCursor-blinkwait300-blinkon200-blinkoff150"
vim.wo.number = true

vim.g.lightline = { colorscheme = 'catppuccin' }
 -- Load Catppuccino colorscheme
vim.cmd.colorscheme "catppuccin"
