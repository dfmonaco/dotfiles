-- vscode-neovim configuration
-- Loaded by the vscode-neovim extension as a standalone Neovim init file.
-- API docs: https://github.com/vscode-neovim/vscode-neovim
local vscode = require("vscode")

-- ============================================================================
-- LEADER KEY
-- ============================================================================
vim.g.mapleader = " "

-- ============================================================================
-- EDITOR SETTINGS
-- ============================================================================
vim.opt.hlsearch = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- ============================================================================
-- CLIPBOARD
-- ============================================================================
-- gy/gp: yank/paste to system clipboard (normal + visual)
vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "x" }, "gp", '"+p', { desc = "Paste from system clipboard" })

-- ============================================================================
-- FILE OPERATIONS
-- ============================================================================
-- <leader>w: save file
vim.keymap.set("n", "<leader>w", function()
  vscode.call("workbench.action.files.save")
end, { noremap = true, silent = true, desc = "Save file" })

-- <leader>o: open link under cursor
vim.keymap.set("n", "<leader>o", function()
  vscode.call("editor.action.openLink")
end, { noremap = true, silent = true, desc = "Open link" })

-- ============================================================================
-- CONFIG EDITING
-- ============================================================================
-- <leader>ei: edit this init.lua
vim.keymap.set("n", "<leader>ei", "<cmd>e $MYVIMRC<cr>", { desc = "Edit init.lua" })

-- ============================================================================
-- DEBUGGER SNIPPETS
-- ============================================================================
-- <leader>ir: insert Ruby debugger (pry-byebug)
vim.keymap.set(
  "n",
  "<leader>ir",
  [[:normal! orequire 'pry-byebug'; binding.pry<cr>]],
  { desc = "Insert Ruby debugger" }
)

-- ============================================================================
-- SEARCH
-- ============================================================================
-- ?: find word under cursor in all project files
vim.keymap.set("n", "?", function()
  local query = vim.fn.expand("<cword>")
  vscode.action("workbench.action.findInFiles", { args = { query = query } })
end, { noremap = true, silent = true, desc = "Find word under cursor in project" })

-- <leader>f: open Find in Files (normal + visual)
vim.keymap.set("n", "<leader>f", function()
  vscode.action("workbench.action.findInFiles")
end, { noremap = true, silent = true, desc = "Find in files" })

vim.keymap.set("v", "<leader>f", function()
  vscode.action("workbench.action.findInFiles")
end, { noremap = true, silent = true, desc = "Find selected text in files" })

-- <leader>r: open Find and Replace (visual)
vim.keymap.set("v", "<leader>r", function()
  vscode.call("editor.action.startFindReplaceAction")
end, { noremap = true, silent = true, desc = "Find and replace selected text" })

-- ============================================================================
-- CODE NAVIGATION
-- ============================================================================
-- gd: go to definition
vim.keymap.set("n", "gd", function()
  vscode.action("editor.action.revealDefinition")
end, { desc = "Go to definition" })

-- gr: go to references
vim.keymap.set("n", "gr", function()
  vscode.action("editor.action.goToReferences")
end, { desc = "Go to references" })

-- K: show hover (docs/type info)
vim.keymap.set("n", "K", function()
  vscode.action("editor.action.showHover")
end, { desc = "Show hover" })

-- ============================================================================
-- CODE ACTIONS & DIAGNOSTICS
-- ============================================================================
-- <leader>ca: quick fix / code actions
vim.keymap.set("n", "<leader>ca", function()
  vscode.action("editor.action.quickFix")
end, { desc = "Code action (quick fix)" })

-- <leader>d: next diagnostic in files
vim.keymap.set("n", "<leader>d", function()
  vscode.action("editor.action.marker.nextInFiles")
end, { desc = "Next diagnostic" })

-- ============================================================================
-- COMMAND PALETTE & NAVIGATION
-- ============================================================================
-- <leader>p: quick open (file picker / command palette)
vim.keymap.set("n", "<leader>p", function()
  vscode.action("workbench.action.quickOpen")
end, { desc = "Quick open" })

-- <leader>g: go to line
vim.keymap.set("n", "<leader>g", function()
  vscode.action("workbench.action.gotoLine")
end, { desc = "Go to line" })

-- ============================================================================
-- WINDOW NAVIGATION
-- ============================================================================
-- <C-h/j/k/l>: focus VS Code editor groups (splits)
-- These use VS Code commands so they work across editor groups, not just Neovim splits.
vim.keymap.set("n", "<C-h>", function()
  vscode.action("workbench.action.focusLeftGroup")
end, { desc = "Focus left window" })

vim.keymap.set("n", "<C-j>", function()
  vscode.action("workbench.action.focusBelowGroup")
end, { desc = "Focus below window" })

vim.keymap.set("n", "<C-k>", function()
  vscode.action("workbench.action.focusAboveGroup")
end, { desc = "Focus above window" })

vim.keymap.set("n", "<C-l>", function()
  vscode.action("workbench.action.focusRightGroup")
end, { desc = "Focus right window" })
