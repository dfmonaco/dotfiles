-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --

-- Configurations

-- Show line numbers
vim.opt.number = true

-- Enable mouse support in all modes
vim.opt.mouse = 'a'

-- Ignore case when searching
vim.opt.ignorecase = true

-- Use smart case when searching
vim.opt.smartcase = true

-- Disable highlighting search matches
vim.opt.hlsearch = false

-- Enable line wrapping
vim.opt.wrap = false

-- Enable automatic indentation when starting a new line
vim.opt.breakindent = true

-- Set the number of spaces for a tab
vim.opt.tabstop = 2

-- Set the number of spaces for one level of indentation
vim.opt.shiftwidth = 2

-- Use spaces instead of tabs for indentation
vim.opt.expandtab = true

-- Display the sign column, indicating signs like breakpoints, errors, etc.
vim.opt.signcolumn = 'yes'

-- Reload the file if has been modified ouside of vim
vim.opt.autoread = true

-- utf-8 encoding for all files
vim.opt.encoding = 'utf-8'

-- Show 3 lines of context around the cursor.
vim.opt.scrolloff = 3

-- Set the terminal's title
vim.opt.title = true

-- Highlight the screen line of the cursor with CursorLine
vim.opt.cursorline = true

-- Show line numbers relative to cursor position
vim.opt.relativenumber = true

-- This means that	all matches in a line are substituted instead of one.
vim.opt.gdefault = true

-- When there is a previous search pattern, highlight all its matches.
vim.opt.hlsearch = true

-- The current mode (e.g., insert mode, normal mode) will not be displayed in the statusline.
vim.opt.showmode = false

--- Render colors more accurately and with greater precision
vim.opt.termguicolors = true

-- disable netrw 
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Mappings

-- Set space as the leader key
vim.g.mapleader = ' '

-- Edit .init.lua
vim.keymap.set('n', '<leader>ev', '<cmd>e $MYVIMRC<cr>')

-- Select entire buffer without changing the jumplist
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

-- Clear search highlight
vim.keymap.set('n', '<leader>ch', ':noh<cr>')

-- Switch between buffers with Tab
vim.keymap.set('n', '<tab>', ':bn<CR>')
vim.keymap.set('n', '<C-tab>', ':bp<CR>')

-- Close buffer
vim.keymap.set('n', '<leader>d', '<cmd>bdelete<cr>')

-- Copy selected text to system clipboard
vim.keymap.set({'n', 'x'}, 'gy', '"+y')

-- Paste from system clipboard
vim.keymap.set({'n', 'x'}, 'gp', '"+p')

-- Write changes
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>')

-- Switch between last two buffers
vim.keymap.set('n', '<leader><leader>', '<c-^>')

-- Autoindent the whole file
vim.keymap.set('n', '<leader>=', 'gg=G')

-- PLUGINS
-- Telescope
vim.keymap.set('n', '<leader>?', '<cmd>Telescope oldfiles<cr>')
vim.keymap.set('n', '<leader><space>', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>')
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>')

-- ========================================================================== --
-- ==                           USER COMMANDS                              == --
-- ========================================================================== --

local group = vim.api.nvim_create_augroup('user_cmds', {clear = true})

vim.api.nvim_create_autocmd('BufWritePost', {
  desc = 'Reload init.lua',
  group = group,
  pattern = 'init.lua',
  callback = function()
    vim.cmd('source $MYVIMRC')
    print('Reloaded init.lua')
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = group,
  callback = function()
    vim.highlight.on_yank({higroup = 'Visual', timeout = 200})
  end,
})

-- ========================================================================== --
-- ==                           PLUGINS                           == --
-- ========================================================================== --

local lazy = {}

-- Function to install lazy.nvim if it's not already installed
function lazy.install(path)
  -- Check if the path directory exists
  if not vim.loop.fs_stat(path) then
    print('Installing lazy.nvim....')
    -- Run a shell command to clone the lazy.nvim repository from GitHub
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      path,
    })
  end
end

-- Function to set up the plugins
function lazy.setup(plugins)
  -- Check if the plugins are already set up
  if vim.g.plugins_ready then
    return -- Return without doing anything
  end

  -- Install lazy.nvim if it's not already installed
  lazy.install(lazy.path)

  -- Prepend the path to the Neovim runtime path
  vim.opt.rtp:prepend(lazy.path)

  -- Set up the plugins using the lazy module
  require('lazy').setup(plugins, lazy.opts)

  -- Set the plugins_ready flag to true to indicate that the plugins are set up
  vim.g.plugins_ready = true
end

-- Set the path where lazy.nvim will be installed
lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- Empty table to store options for the lazy module
lazy.opts = {}

-- Set up the plugins
lazy.setup({
  --
  -- THEMING
  --
  -- Provides the Tokyo Night theme for Neovim.
  {'folke/tokyonight.nvim'},
  -- Offers the One Dark theme for Neovim.
  {'joshdick/onedark.vim'},
  -- Implements the Monokai theme for Neovim.
  {'tanvirtin/monokai.nvim'},
  -- Presents the Dark+ theme for Neovim.
  {'lunarvim/darkplus.nvim'},
  -- Provides icons for files, directories, etc., in Neovim.
  {'kyazdani42/nvim-web-devicons'},
  -- Configurable status line for Neovim.
  {'nvim-lualine/lualine.nvim'},
  -- Enhanced buffer line (tab line) for Neovim.
  {'akinsho/bufferline.nvim'},
  -- Displays indent lines in Neovim.
  {'lukas-reineke/indent-blankline.nvim'},

  --
  -- UTILITIES
  --
  -- All-in-one Lua utility functions for Neovim. (needed by telescope)
  {'nvim-lua/plenary.nvim'},
  -- Language parsing and manipulation for Neovim.
  {'nvim-treesitter/nvim-treesitter'},
  -- Additional text objects for treesitter.
  {'nvim-treesitter/nvim-treesitter-textobjects'},
  -- Commenting plugin for Neovim.
  {'numToStr/Comment.nvim'},
  -- Adds mappings to easily manipulate surroundings.
  {'tpope/vim-surround'},
  -- Extends text objects to support additional targets.
  {'wellle/targets.vim'},
  -- Repeats supported plugin commands with '.'
  {'tpope/vim-repeat'},
  -- Provides easy toggling of terminal in Neovim.
  {'akinsho/toggleterm.nvim'},
  -- AI code completion
  {
    'Exafunction/codeium.vim', 
    event = 'BufEnter',
    config = function ()
      vim.keymap.set('i', '<Tab>', function () return vim.fn['codeium#Accept']() end, { expr = true })
      vim.keymap.set('i', '<leader>[', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<leader>]', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      vim.keymap.set('i', '<leader>-', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end,
  },

  --
  -- FILE MANAGEMENT
  --
  -- File explorer that lets you edit your filesystem like a normal Neovim buffer.
  {'stevearc/oil.nvim'},
  -- Fuzzy finder extension for Neovim.
  {'nvim-telescope/telescope.nvim', branch = '0.1.x'},
  -- Native FZF integration for Telescope.
  {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},

  --
  --- GIT
  --
  -- Git signs and hunk management for Neovim.
  {'lewis6991/gitsigns.nvim'},
  -- Git wrapper for Neovim.
  {'tpope/vim-fugitive'},
})


-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

---
-- Colorscheme
---
vim.cmd.colorscheme('darkplus')

---
-- lualine.nvim (statusline)
---
-- See :help lualine.txt
require('lualine').setup({
  options = {
    theme = 'darkplus',
    icons_enabled = true,
    component_separators = '|',
    section_separators = ''
  },
})

---
-- bufferline
---
-- See :help bufferline-settings
require('bufferline').setup({
  options = {
    mode = 'buffers',
    offsets = {
      {filetype = 'NvimTree'}
    },
  },
  -- :help bufferline-highlights
  highlights = {
    buffer_selected = {
      italic = false
    },
    indicator_selected = {
      -- Set the foreground color based on the 'Function' highlight group's foreground attribute.
      fg = {attribute = 'fg', highlight = 'Function'},
      italic = false
    }
  }
})

---
-- Indent-blankline
---
-- See :help ibl.setup()
require('ibl').setup({
  enabled = true,
  scope = {
    enabled = false,
  },
  indent = {
    char = '▏',
  }
})


---
-- oil
---
require("oil").setup({})

---
-- Telescope
---
-- See :help telescope.builtin
require('telescope').load_extension('fzf')

---
-- Gitsigns
---
-- See :help gitsigns-usage
require('gitsigns').setup({
 signs = {
    add          = { text = '+' },
    change       = { text = '#' },
    delete       = { text = '-' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
})


---
-- Treesitter
---
require('nvim-treesitter.configs').setup({

  highlight = {
    enable = true,
  },

  textobjects = {
    select = {
      -- Enable text objects selection with lookahead.
      enable = true,
      lookahead = true,
      keymaps = {
        -- Define key mappings for various text objects.
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      }
    },
  },

  ensure_installed = {
    'javascript',
    'typescript',
    'tsx',
    'lua',
    'vim',
    'vimdoc',
    'css',
    'json',
    'ruby',
  },
})

---
-- toggleterm
---
-- See :help toggleterm-roadmap
require('toggleterm').setup({
  open_mapping = '<C-g>',
  direction = 'horizontal',
  shade_terminals = true
})
