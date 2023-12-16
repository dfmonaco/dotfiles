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


-- Function to reload init.lua file
function ReloadInit()
    vim.cmd('luafile ' .. vim.fn.stdpath('config') .. '/init.lua')
    print('Reloaded init.lua')
end

-- Register autocommand to trigger reload on BufWritePost (when saving the file)
vim.api.nvim_exec([[
    augroup AutoReloadInit
        autocmd!
        autocmd BufWritePost $MYVIMRC lua ReloadInit()
    augroup END
]], false)

