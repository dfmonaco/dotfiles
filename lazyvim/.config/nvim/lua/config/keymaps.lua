-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>j", "<cmd>w<cr><esc>", { desc = "Save File" })
vim.keymap.set("n", "<leader>k", function()
  Snacks.bufdelete()
end, { desc = "Kill Buffer" })
vim.keymap.set("n", "<leader><leader>", "<c-^>", { desc = "Last buffer" })

vim.keymap.set("n", "<C-c>", "<C-W>c", { desc = "Delete Window", remap = true })
vim.keymap.set("t", "<C-Esc>", "<C-\\><C-n>", { desc = "Escape terminal mode" })
-- Remap macros to letter 'm'
vim.keymap.set("n", "m", "q", { noremap = true, silent = true })
-- Remove mapping from letter 'q'
vim.keymap.set("n", "q", "<Nop>", { noremap = true, silent = true })
