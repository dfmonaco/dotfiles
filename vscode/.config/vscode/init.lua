-- Load the vscode-neovim plugin to access VS Code commands from Neovim
local vscode = require("vscode-neovim")

-- ============================================================================
-- LEADER KEY CONFIGURATION
-- ============================================================================
-- Set space as the leader key for custom keybindings
-- All keybindings starting with <leader> will use space
vim.g.mapleader = " "

-- ============================================================================
-- EDITOR SETTINGS
-- ============================================================================
-- hlsearch: Disable highlighting of search matches after search completes
-- (search results won't stay highlighted when you move cursor away)
vim.opt.hlsearch = false

-- tabstop: Number of spaces that a tab character represents when viewing files
-- (when you see a tab in the file, it takes up 2 spaces visually)
vim.opt.tabstop = 2

-- shiftwidth: Number of spaces used for each indentation level
-- (when you press >> or <<, it indents/outdents by 2 spaces)
vim.opt.shiftwidth = 2

-- expandtab: Convert tab key presses into spaces instead of actual tab characters
-- (when you press Tab, it inserts 2 spaces instead of a tab character)
vim.opt.expandtab = true

-- ============================================================================
-- CLIPBOARD OPERATIONS
-- ============================================================================
-- gy: Yank (copy) text to system clipboard
-- Works in normal mode (n) and visual mode (x)
-- The "+ register accesses the system clipboard
vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Yank to system clipboard" })

-- gp: Paste text from system clipboard
-- Works in normal mode (n) and visual mode (x)
vim.keymap.set({ "n", "x" }, "gp", '"+p', { desc = "Paste from system clipboard" })

-- ============================================================================
-- CONFIGURATION AND FILE OPERATIONS
-- ============================================================================
-- <leader>ei: Open the init.lua configuration file for editing
-- $MYVIMRC is the path to your Neovim config file
vim.keymap.set("n", "<leader>ei", "<cmd>e $MYVIMRC<cr>", { desc = "Edit [i]nit.lua" })

-- <leader>ir: Insert a Ruby debugger breakpoint (pry-byebug)
-- Creates a new line with: require 'pry-byebug'; binding.pry
-- Useful for debugging Ruby code in VS Code
vim.keymap.set(
  "n",
  "<leader>ir",
  [[:normal! orequire 'pry-byebug'; binding.pry<cr>]],
  { desc = "insert [r]uby debugger" }
)

-- ============================================================================
-- SEARCH AND FIND OPERATIONS
-- ============================================================================
-- ?: Find the word under cursor in all project files
-- Expands the word at cursor and opens VS Code's "Find in Files" with it
vim.keymap.set("n", "?", function()
  local query = vim.fn.expand("<cword>")
  vscode.action("workbench.action.findInFiles", { args = { query = query } })
end, { noremap = true, silent = true, desc = "Find word under cursor" })

-- <leader>f: Open "Find in Files" dialog (normal mode)
-- Allows you to search for text across all project files
vim.keymap.set("n", "<leader>f", function()
  vscode.action("workbench.action.findInFiles")
end, { noremap = true, silent = true, desc = "Find in files" })

-- <leader>f: Open "Find in Files" dialog with selected text (visual mode)
-- Pre-fills the search box with your selected text
vim.keymap.set("v", "<leader>f", function()
  vscode.action("workbench.action.findInFiles")
end, { noremap = true, silent = true, desc = "Find selected text in files" })

-- <leader>r: Open "Find and Replace" dialog in visual mode
-- Pre-fills with selected text, ready to replace
vim.keymap.set("v", "<leader>r", function()
  vscode.call("editor.action.startFindReplaceAction")
end, { noremap = true, silent = true, desc = "Find and replace selected text" })

-- ============================================================================
-- FILE OPERATIONS
-- ============================================================================
-- <leader>w: Save the current file
vim.keymap.set("n", "<leader>w", function()
  vscode.call("workbench.action.files.save")
end, { noremap = true, silent = true, desc = "Write (save) file" })

-- <leader>o: Open the link under the cursor
-- Useful for opening URLs or file paths in the editor
vim.keymap.set("n", "<leader>o", function()
  vscode.call("editor.action.openLink")
end, { noremap = true, silent = true, desc = "Open link" })

-- ============================================================================
-- CODE NAVIGATION
-- ============================================================================
-- gd: Jump to the definition of the symbol under the cursor
-- Takes you to where a function, class, or variable is defined
vim.keymap.set("n", "gd", function()
  vscode.action("editor.action.revealDefinition")
end, { desc = "Go to definition" })

-- gr: Find all references to the symbol under the cursor
-- Shows where a function, class, or variable is used
vim.keymap.set("n", "gr", function()
  vscode.action("editor.action.goToReferences")
end, { desc = "Go to references" })

-- K: Show hover information (documentation/type info)
-- Displays the type signature and docstring for the symbol under cursor
vim.keymap.set("n", "K", function()
  vscode.action("editor.action.showHover")
end, { desc = "Show hover" })

-- ============================================================================
-- CODE ACTIONS AND DIAGNOSTICS
-- ============================================================================
-- <leader>ca: Show quick fix suggestions
-- Displays code actions (auto-fixes) for errors/warnings under cursor
vim.keymap.set("n", "<leader>ca", function()
  vscode.action("editor.action.quickFix")
end, { desc = "[C]ode [a]ction" })

-- <leader>d: Jump to next diagnostic error/warning
-- Navigates through compilation errors, linting warnings, etc.
vim.keymap.set("n", "<leader>d", function()
  vscode.action("editor.action.marker.nextInFiles")
end, { desc = "[D]iagnostic next" })

-- ============================================================================
-- COMMAND PALETTE AND NAVIGATION
-- ============================================================================
-- <leader>p: Open VS Code's command palette
-- Lets you run any VS Code command by name (search/filter style)
vim.keymap.set("n", "<leader>p", function()
  vscode.action("workbench.action.quickOpen")
end, { desc = "Command [p]alette" })

-- <leader>g: Open "Go to Line" dialog
-- Jump to a specific line number in the current file
vim.keymap.set("n", "<leader>g", function()
  vscode.action("workbench.action.gotoLine")
end, { desc = "[G]o to line" })

-- ============================================================================
-- WINDOW NAVIGATION
-- ============================================================================
-- <C-h>: Focus the editor group (split panel) to the left
-- Use Ctrl+H to move focus to the left split
vim.keymap.set("n", "<C-h>", function()
  vscode.action("workbench.action.focusLeftGroup")
end, { desc = "Focus left window" })

-- <C-j>: Focus the editor group (split panel) below
-- Use Ctrl+J to move focus to the bottom split
vim.keymap.set("n", "<C-j>", function()
  vscode.action("workbench.action.focusBelowGroup")
end, { desc = "Focus below window" })

-- <C-k>: Focus the editor group (split panel) above
-- Use Ctrl+K to move focus to the top split
vim.keymap.set("n", "<C-k>", function()
  vscode.action("workbench.action.focusAboveGroup")
end, { desc = "Focus above window" })

-- <C-l>: Focus the editor group (split panel) to the right
-- Use Ctrl+L to move focus to the right split
vim.keymap.set("n", "<C-l>", function()
  vscode.action("workbench.action.focusRightGroup")
end, { desc = "Focus right window" })
