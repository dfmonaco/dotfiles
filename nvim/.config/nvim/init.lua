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
 {desc = 'Edit [i]nit.lua'}
)

vim.keymap.set('n', '<leader>ez', '<cmd>e $HOME/.zshrc<cr>',
 {desc = 'Edit [z]shrc'}
)

vim.keymap.set('n', '<leader>er', '<cmd>e $HOME/.config/rubocop/config.yml<cr>',
 {desc = 'Edit [r]ubocop'}
)

vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>',
 {desc = 'Select entire buffer'}
)

vim.keymap.set('n', '<leader>q', '<cmd>q<cr>',
 {desc = '[q]uit'}
)

vim.keymap.set('n', '<leader>x', '<cmd>q!<cr>',
 {desc = 'Quit without saving'}
)

vim.keymap.set('n', '<leader>d', '<cmd>bdelete<cr>',
 {desc = 'Buffer [d]elete'}
)

vim.keymap.set('n', '<leader>w', '<cmd>write<cr>',
 {desc = '[w]rite file'}
)

vim.keymap.set('n', '<leader><leader>', '<c-^>',
 {desc = 'Last buffer'}
)

vim.keymap.set('n', '<leader>=', 'gg=G',
 {desc = 'Autoindent the whole file'}
)

local function confirm_and_delete_buffer()
  local confirm = vim.fn.confirm("Delete buffer and file?", "&Yes\n&No", 2)

  if confirm == 1 then
    os.remove(vim.fn.expand "%")
    vim.api.nvim_buf_delete(0, { force = true })
  end
end

vim.keymap.set('n', '<leader>D', confirm_and_delete_buffer,
  {desc = '[D]elete buffer and file'}
)

-- PLUGINS
-- Telescope
vim.keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>',
  {desc = 'Find [r]ecently opened files'}
)

vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>',
  {desc = 'Find current [b]uffers'}
)

vim.keymap.set('n', '<leader>fa', '<cmd>Telescope git_files<cr>',
  {desc = 'Find [a]ll files'}
)

vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>',
  {desc = 'Find git [f]iles'}
)

vim.keymap.set('n', '<leader>fs', '<cmd>Telescope live_grep<cr>',
  {desc = 'Find [s]tring in files'}
)

vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>',
  {desc = 'Find [d]iagnostics'}
)

vim.keymap.set('n', '<leader>fh', '<cmd>Telescope current_buffer_fuzzy_find<cr>',
  {desc = 'Find string [h]ere'}
)


-- Neotest 
vim.keymap.set('n', '<leader>tt',
  function () require('neotest').run.run() end,
  {desc = 'Run nearest [t]est'}
)

vim.keymap.set('n', '<leader>tf',
  function () require('neotest').run.run(vim.fn.expand('%')) end,
  {desc = 'Run [f]ile'}
)

vim.keymap.set('n', '<leader>to',
  function () require('neotest').output.open({enter = true}) end,
  {desc = 'Open test [o]utput'}
)

vim.keymap.set('n', '<leader>ts',
  function () require('neotest').summary.toggle() end,
  {desc = 'Toggle test [s]ummary'}
)

vim.keymap.set('n', '<leader>tp',
  function () require('neotest').output_panel.toggle() end,
  {desc = 'Toggle test output [p]anel'}
)

-- Search/replace
vim.keymap.set('v', '<C-r>', '<CMD>SearchReplaceSingleBufferVisualSelection<CR>',
  { desc = 'Visual search/replace in buffer' }
)

vim.keymap.set("v", "<C-s>", "<CMD>SearchReplaceWithinVisualSelection<CR>",
  { desc = "Search/replace within visual selection" }
)

vim.keymap.set('n', '<leader>rw', '<CMD>SearchReplaceSingleBufferCWord<CR>',
  { desc = 'Search/replace in buffer for [w]ord' }
)

vim.keymap.set('n', '<leader>rW', '<CMD>SearchReplaceSingleBufferCWORD<CR>',
  { desc = 'Search/replace in buffer for [W]WORD' }
)

-- Spectre
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Search/Replace [p]anel",
})

vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = "Search current [w]ord on all files"
})

vim.keymap.set('n', '<leader>sb', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = "Search current word on current [b]uffer"
})

-- Trouble
vim.keymap.set("n", "<leader>lp", function() require("trouble").toggle() end,
  { desc = "Toggle diagnostics [p]anel" }
)
vim.keymap.set("n", "<leader>lr", function() require("trouble").toggle("lsp_references") end,
  { desc = "Toggle LSP [r]eferences" }
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

-- Fix Telescope bug
-- https://github.com/nvim-telescope/telescope.nvim/issues/2027#issuecomment-1561836585
-- https://github.com/nvim-telescope/telescope.nvim/issues/2766
vim.api.nvim_create_autocmd("WinLeave", {
  callback = function()
    if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
    end
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
      {desc = 'Show [i]nfo'}
    )

    -- It jumps to the definition of the symbol under the cursor
    bufmap('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<cr>',
      {desc = 'Go to [d]efinition'}
    )

    -- Lists all the implementations of the symbol under the cursor
    bufmap('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<cr>',
      {desc = 'List [i]mplementations'}
    )
    -- Displays the signature of the function
    bufmap('n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<cr>',
      {desc = 'Show [s]ignature'}
    )

    -- Formats the buffer using the current language server
    bufmap({'n', 'x'}, '<leader>lf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
      {desc = 'Buffer [f]ormat'}
    )

    -- Selects a code action available at the current cursor position
    bufmap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>',
      {desc = 'Select code [a]ction'}
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
  -- Colorscheme switcher
  {'zaldih/themery.nvim'},

  --
  -- UTILITIES
  --
  -- All-in-one Lua utility functions for Neovim. (needed by telescope)
  {'nvim-lua/plenary.nvim'},
  -- Language parsing and manipulation for Neovim.
  {'nvim-treesitter/nvim-treesitter'},
  -- Additional text objects for treesitter.
  {'nvim-treesitter/nvim-treesitter-textobjects'},
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

  ---
  -- TEXT MANIPULATION
  ---
  -- Provides search and replace 
  { "roobert/search-replace.nvim",},
  -- Commenting plugin for Neovim.
  {'numToStr/Comment.nvim'},
  -- Adds mappings to easily manipulate surroundings.
  {'tpope/vim-surround'},
  -- Extends text objects to support additional targets.
  {'wellle/targets.vim'},
  -- Repeats supported plugin commands with '.'
  {'tpope/vim-repeat'},
  -- A search panel for Neovim.
  {'nvim-pack/nvim-spectre',
    dependencies = {
      "nvim-lua/plenary.nvim",
    }
  },

  --
  -- LSP
  --
  {"williamboman/mason.nvim"},
  {"williamboman/mason-lspconfig.nvim"},
  {'neovim/nvim-lspconfig'},
  -- Provides diagnostics panel
  {
    "folke/trouble.nvim",
    dependencies = {
    "nvim-tree/nvim-web-devicons",
    },
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

local select_one_or_multi = function(prompt_bufnr)
  local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
  local multi = picker:get_multi_selection()
  if not vim.tbl_isempty(multi) then
    require('telescope.actions').close(prompt_bufnr)
    for _, j in pairs(multi) do
      if j.path ~= nil then
        vim.cmd(string.format('%s %s', 'edit', j.path))
      end
    end
  else
    require('telescope.actions').select_default(prompt_bufnr)
  end
end

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<CR>'] = select_one_or_multi,
      }
    }
  }
}
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
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']h', function()
      if vim.wo.diff then return ']h' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true, desc = 'Next hunk'})

    map('n', '[h', function()
      if vim.wo.diff then return '[h' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true, desc = 'Previous hunk'})

    -- Actions
    map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end,
      {desc = 'Hunk [s]tage in selection'}
    )
    map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end,
      {desc = 'Hunk [r]eset in selection'}
    )

    map('n', '<leader>hs', gs.stage_hunk,
      {desc = 'Hunk [s]tage'}
    )
    map('n', '<leader>hr', gs.reset_hunk,
      {desc = 'Hunk [r]eset'}
    )
    map('n', '<leader>hS', gs.stage_buffer,
      {desc = 'Hunk [S]tage all in buffer'}
    )
    map('n', '<leader>hu', gs.undo_stage_hunk,
      {desc = 'Hunk [u]ndo stage'}
    )
    map('n', '<leader>hR', gs.reset_buffer,
      {desc = 'Hunk [R]eset all in buffer'}
    )
    map('n', '<leader>hp', gs.preview_hunk,
      {desc = 'Hunk [p]review'}
    )
    map('n', '<leader>hb', function() gs.blame_line{full=true} end,
      {desc = 'Line [b]lame'}
    )
    map('n', '<leader>hd', gs.diffthis,
      {desc = 'Hunk [d]iff'}
    )
    map('n', '<leader>hD', function() gs.diffthis('~') end,
      {desc = 'Hunk [D]iff all in buffer'}
    )
    map('n', '<leader>ht', gs.toggle_deleted,
      {desc = 'Hunk [t]oggle deleted'}
    )
    map('n', '<leader>ha', ':Gitsigns setloclist<CR>',
      {desc = 'Hunk show [a]ll'}
    )

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
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
  direction = 'float',
  shade_terminals = true,
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.5
    end
  end,
})

local Terminal  = require('toggleterm.terminal').Terminal

vim.keymap.set("n", "<leader>og", function()
  Terminal:new({ cmd = "lazygit", hidden = true }):toggle()
end, { noremap = true, silent = true, expr = true, desc = "[g]it" })

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
  ['<leader>f'] = { name = '[f]ind' },
  ['<leader>e'] = { name = '[e]dit' },
  ['<leader>r'] = { name = '[r]eplace' },
  ['<leader>t'] = { name = '[t]est' },
  ['<leader>s'] = { name = '[s]earch' },
  ['<leader>h'] = { name = '[h]unk', _ = 'which_key_ignore' },
  ['<leader>l'] = { name = '[l]sp', _ = 'which_key_ignore' },
  ['<leader>o'] = { name = '[o]open', _ = 'which_key_ignore' },
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


require('lspconfig').solargraph.setup({
  filetypes = { 'ruby' },
})

---
-- trouble
---
require('trouble').setup({})

---
-- search-replace.nvim
---
require('search-replace').setup({})

---
-- vim-spectre
---
require('spectre').setup({
  highlight = {
    ui = "String",
    search = "DiffChange",
    replace = "DiffDelete",
  }
})

---
-- themery
--
require('themery').setup({
  themes = {
    'tokyonight',
    'onedark',
    'monokai',
    'darkplus',
  },
  livePreview = true,
})
