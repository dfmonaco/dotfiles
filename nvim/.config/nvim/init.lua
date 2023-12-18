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

-- The current mode (e.g., insert mode, normal mode) will not be displayed in the statusline.
vim.opt.showmode = false

--- Render colors more accurately and with greater precision
vim.opt.termguicolors = true

--- Show the effects of a search / replace in a live preview window
vim.o.inccommand = "split"

-- Mappings

-- Set space as the leader key
vim.g.mapleader = ' '

vim.keymap.set('n', '<tab>', ':bn<CR>',
 {desc = 'Next buffer'}
)

vim.keymap.set('n', '<C-tab>', ':bp<CR>',
 {desc = 'Previous buffer'}
)

vim.keymap.set({'n', 'x'}, 'gy', '"+y',
 {desc = 'Yank to system clipboard'}
)

vim.keymap.set({'n', 'x'}, 'gp', '"+p',
 {desc = 'Paste from system clipboard'}
)

vim.keymap.set('n', '<C-h>', '<C-w>h',
 {desc = 'Previous window'}
)

vim.keymap.set('n', '<C-j>', '<C-w>j',
 {desc = 'Next window'}
)

vim.keymap.set('n', '<C-k>', '<C-w>k',
 {desc = 'Previous window'}
)

vim.keymap.set('n', '<C-l>', '<C-w>l',
 {desc = 'Next window'}
)

vim.keymap.set('n', '<leader>ei', '<cmd>e $MYVIMRC<cr>',
 {desc = 'Edit init.lua'}
)

vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>',
 {desc = 'Select entire buffer'}
)

vim.keymap.set('n', '<leader>q', '<cmd>q<cr>',
 {desc = 'Quit'}
)

vim.keymap.set('n', '<leader>x', '<cmd>q!<cr>',
 {desc = 'Quit without saving'}
)

vim.keymap.set('n', '<leader>d', '<cmd>bdelete<cr>',
 {desc = 'Delete buffer'}
)

vim.keymap.set('n', '<leader>w', '<cmd>write<cr>',
 {desc = 'Write file'}
)

vim.keymap.set('n', '<leader><leader>', '<c-^>',
 {desc = 'Last buffer'}
)

vim.keymap.set('n', '<leader>=', 'gg=G',
 {desc = 'Autoindent the whole file'}
)

-- PLUGINS
-- Telescope
vim.keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>',
  {desc = 'Find recently opened files'}
)

vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>',
  {desc = 'Find existing buffers'}
)

vim.keymap.set('n', '<leader>fg', '<cmd>Telescope git_files<cr>',
  {desc = 'Find files in git repo'}
)

vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>',
  {desc = 'Find files'}
)

vim.keymap.set('n', '<leader>fs', '<cmd>Telescope live_grep<cr>',
  {desc = 'Find string in files'}
)

vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>',
  {desc = 'Find diagnostics'}
)

vim.keymap.set('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>',
  {desc = 'Find string in current buffer'}
)


-- Neotest 
vim.keymap.set('n', '<leader>tt',
  function () require('neotest').run.run() end,
  {desc = 'Run nearest test'}
)

vim.keymap.set('n', '<leader>tf',
  function () require('neotest').run.run(vim.fn.expand('%')) end,
  {desc = 'Run file'}
)

vim.keymap.set('n', '<leader>to',
  function () require('neotest').output.open({enter = true}) end,
  {desc = 'Open test output'}
)

vim.keymap.set('n', '<leader>ts',
  function () require('neotest').summary.toggle() end,
  {desc = 'Toggle test summary'}
)

vim.keymap.set('n', '<leader>tp',
  function () require('neotest').output_panel.toggle() end,
  {desc = 'Toggle test output panel'}
)

-- Search/replace
vim.keymap.set('v', '<C-r>', '<CMD>SearchReplaceSingleBufferVisualSelection<CR>',
  { desc = 'Visual search/replace in buffer' }
)

vim.keymap.set('v', '<C-s>', '<CMD>SearchReplaceWithinVisualSelection<CR>',
  { desc = 'Search/replace within visual selection' }
)

vim.keymap.set('v', '<C-b>', '<CMD>SearchReplaceWithinVisualSelectionCWord<CR>',
  { desc = 'Search/replace within visual selection for word' }
)

vim.keymap.set('n', '<leader>rs', '<CMD>SearchReplaceSingleBufferSelections<CR>',
  { desc = 'Search/replace in buffer' }
)

vim.keymap.set('n', '<leader>ro', '<CMD>SearchReplaceSingleBufferOpen<CR>',
  { desc = 'Search/replace in buffer open' }
)

vim.keymap.set('n', '<leader>rw', '<CMD>SearchReplaceSingleBufferCWord<CR>',
  { desc = 'Search/replace in buffer for word' }
)

vim.keymap.set('n', '<leader>rW', '<CMD>SearchReplaceSingleBufferCWORD<CR>',
  { desc = 'Search/replace in buffer for WORD' }
)

vim.keymap.set('n', '<leader>re', '<CMD>SearchReplaceSingleBufferCExpr<CR>',
  { desc = 'Search/replace in buffer for CExpr' }
)

vim.keymap.set('n', '<leader>rbs', '<CMD>SearchReplaceMultiBufferSelections<CR>',
  { desc = 'Search/replace in multiple buffers' }
)

vim.keymap.set('n', '<leader>rbo', '<CMD>SearchReplaceMultiBufferOpen<CR>',
  { desc = 'Search/replace in multiple buffers open' }
)

vim.keymap.set('n', '<leader>rbw', '<CMD>SearchReplaceMultiBufferCWord<CR>',
  { desc = 'Search/replace in multiple buffers for word' }
)

vim.keymap.set('n', '<leader>rbW', '<CMD>SearchReplaceMultiBufferCWORD<CR>',
  { desc = 'Search/replace in multiple buffers for WORD' }
)

vim.keymap.set('n', '<leader>rbe', '<CMD>SearchReplaceMultiBufferCExpr<CR>',
  { desc = 'Search/replace in multiple buffers for CExpr' }
)

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
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = group,
  callback = function()
    vim.highlight.on_yank({higroup = 'Visual', timeout = 200})
  end,
})


---
-- LSP Keybindings
---
vim.api.nvim_create_autocmd('LspAttach', {
  group = group,
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, keys, cmd, opts)
      opts.buffer = true
      vim.keymap.set(mode, keys, cmd, opts)
    end

    -- You can search each function in the help page.
    -- For example :help vim.lsp.buf.hover()

    -- It shows information about the symbol under the cursor
    bufmap('n', '<leader>li', '<cmd>lua vim.lsp.buf.hover()<cr>',
      {desc = 'Show info'}
    )

    -- It jumps to the definition of the symbol under the cursor
    bufmap('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<cr>',
      {desc = 'Go to definition'}
    )

    -- Lists all the implementations of the symbol under the cursor
    bufmap('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<cr>',
      {desc = 'List implementations'}
    )

    -- Lists all the references of the symbol under the cursor in the quickfix
    bufmap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<cr>',
      {desc = 'List references'}
    )

    -- Displays the signature of the function
    bufmap('n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<cr>',
      {desc = 'Show signature'}
    )

    -- Formats the buffer using the current language server
    bufmap({'n', 'x'}, '<leader>lf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
      {desc = 'Format buffer'}
    )

    -- Selects a code action available at the current cursor position
    bufmap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>',
      {desc = 'Select code action'}
    )
  end
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
  -- Provides syntax highlighting for Slim templates in Neovim.
  {'slim-template/vim-slim'},

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
      vim.keymap.set('i', '<C-h>', function () return vim.fn['codeium#Accept']() end, { expr = true })
      vim.keymap.set('i', '<C-j>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<C-k>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      vim.keymap.set('i', '<C-BS>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end,
  },
  -- Provides which-key integration for Neovim.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },
  -- Provides diagnostics panel
  {
    "folke/trouble.nvim",
    dependencies = {
    "nvim-tree/nvim-web-devicons",
    },
  },
  -- Provides search and replace 
  { "roobert/search-replace.nvim",},

  --
  -- LSP
  --
  {"williamboman/mason.nvim"},
  {"williamboman/mason-lspconfig.nvim"},
  {'neovim/nvim-lspconfig'},

  --
  -- FILE MANAGEMENT
  --
  -- File explorer that lets you edit your filesystem like a normal Neovim buffer.
  {'stevearc/oil.nvim'},
  -- Fuzzy finder extension for Neovim.
  {'nvim-telescope/telescope.nvim', branch = '0.1.x'},
  -- Native FZF integration for Telescope.
  {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
  -- A framework for interacting with tests within NeoVim.
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "olimorris/neotest-rspec",
    }
  },

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
  sections = {
    lualine_c = {
      {
        function()
          return vim.call('codeium#GetStatusString')
        end,
      },
    }
  }
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
-- Comment.nvim
---
require('Comment').setup({})

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


---
-- neotest
---
require("neotest").setup({
  adapters = {
    require("neotest-rspec"),
  },
})

---
-- which-key
---
-- require('which-key').setup({})
require('which-key').register({
  ['<leader>f'] = { name = '[F]ind' },
  ['<leader>e'] = { name = '[E]dit' },
  ['<leader>r'] = { name = '[R]eplace' },
  ['<leader>rb'] = { name = '[B]uffers' },
  ['<leader>t'] = { name = '[T]est' },
  ['<leader>l'] = { name = '[L]sp', _ = 'which_key_ignore' },
})

---
-- mason
---
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    "lua_ls",
    "solargraph",
  }
})

---
-- lspconfig
---

require('lspconfig').lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})


require('lspconfig').solargraph.setup({})

---
-- trouble
---
require('trouble').setup({})

---
-- search-replace.nvim
---
require('search-replace').setup({})
