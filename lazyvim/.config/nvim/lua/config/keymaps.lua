-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Remap escape to jk
vim.keymap.set({"i"}, "jk", "<ESC>", { silent = true })
-- Closes a window but keeps the buffer
vim.keymap.set({"n", "i"}, "<C-k>", "<C-W>c", { desc = "Kill Window", remap = true })
-- Delete buffer
vim.keymap.set({"n"}, "<leader>k", function()
  Snacks.bufdelete()
end, { desc = "Kill Buffer" })
-- Enter vim mode in terminal
vim.keymap.set({"t"}, "<C-Esc>", "<C-\\><C-n>", { desc = "Escape terminal mode" })
-- Save file
vim.keymap.set({"n"}, "<leader>j", "<cmd>w<cr><esc>", { desc = "Save File" })
-- Toggle last 2 buffers
vim.keymap.set({"n"}, "<leader><leader>", "<c-^>", { desc = "Last buffer" })
-- Use letter 'm' for macros instead of 'q'
vim.keymap.set({"n"}, "m", "q", { noremap = true, silent = true })
-- Remove mapping from letter 'q'
vim.keymap.set({"n"}, "q", "<Nop>", { noremap = true, silent = true })
