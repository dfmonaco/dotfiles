-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>h", "<C-W>c", { desc = "Delete Window", remap = true })
vim.keymap.set("n", "<leader>j", "<cmd>w<cr><esc>", { desc = "Save File" })
vim.keymap.set("n", "<leader>k", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader><leader>", "<c-^>", { desc = "Last buffer" })
