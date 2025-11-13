local vscode = require("vscode-neovim")

-- Set space as the leader key
vim.g.mapleader = " "

-- Disable highlighting search matches
vim.opt.hlsearch = false

-- Set the number of spaces for a tab
vim.opt.tabstop = 2

-- Set the number of spaces for one level of indentation
vim.opt.shiftwidth = 2

-- Use spaces instead of tabs for indentation
vim.opt.expandtab = true

vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Yank to system clipboard" })

vim.keymap.set({ "n", "x" }, "gp", '"+p', { desc = "Paste from system clipboard" })

vim.keymap.set("n", "<leader>ei", "<cmd>e $MYVIMRC<cr>", { desc = "Edit [i]nit.lua" })

vim.keymap.set(
  "n",
  "<leader>ir",
  [[:normal! orequire 'pry-byebug'; binding.pry<cr>]],
  { desc = "insert [r]uby debugger" }
)

-- Finds the workd under the cursor in all project files
vim.keymap.set("n", "?", function()
  local query = vim.fn.expand("<cword>")
  vscode.action("workbench.action.findInFiles", { args = { query = query } })
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>f", function()
  vscode.action("workbench.action.findInFiles")
end, { noremap = true, silent = true })

vim.keymap.set("v", "<leader>f", function()
  vscode.action("workbench.action.findInFiles")
end, { noremap = true, silent = true })

vim.keymap.set("v", "<leader>r", function()
  vscode.call("editor.action.startFindReplaceAction")
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>w", function()
  vscode.call("workbench.action.files.save")
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>o", function()
  vscode.call("editor.action.openLink")
end, { noremap = true, silent = true })
