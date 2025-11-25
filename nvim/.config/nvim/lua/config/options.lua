-- Core Neovim options
local opt = vim.opt

-- Line numbers
opt.number = true -- Show absolute line numbers
opt.relativenumber = true -- Show relative line numbers

-- Indentation
opt.tabstop = 2 -- Number of spaces a tab counts for
opt.shiftwidth = 2 -- Number of spaces for each indentation level
opt.expandtab = true -- Convert tabs to spaces
opt.autoindent = true -- Copy indent from current line when starting new line

-- Search
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true -- Override ignorecase if search contains uppercase
opt.hlsearch = true -- Highlight all search matches
opt.incsearch = true -- Show search matches as you type

-- Appearance
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.signcolumn = "yes" -- Always show sign column (for git, diagnostics, etc.)
opt.cursorline = true -- Highlight the line where the cursor is
opt.wrap = true -- Wrap long lines
opt.scrolloff = 10 -- Keep 10 lines visible above/below cursor when scrolling
opt.title = true -- Set terminal window title to current file

-- Behavior
opt.mouse = "a" -- Enable mouse support in all modes
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.undofile = true -- Save undo history to file
opt.backup = false -- Don't create backup files
opt.swapfile = false -- Don't create swap files
opt.autoread = true -- Automatically reload file if changed outside Neovim
opt.inccommand = "split" -- Show live preview of substitutions in split window

-- Splits
opt.splitright = true -- Open vertical splits to the right
opt.splitbelow = true -- Open horizontal splits below

-- Update time
opt.updatetime = 250 -- Faster completion and diagnostics (default is 4000ms)
opt.timeoutlen = 300 -- Time to wait for mapped sequence to complete (in ms)
