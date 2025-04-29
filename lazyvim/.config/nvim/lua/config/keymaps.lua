-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Remap escape to jk
vim.keymap.set({"i"}, "jk", "<ESC>", { silent = true })
-- Closes a window but keeps the buffer
vim.keymap.set({"n", "i"}, "<C-q>", "<C-W>c", { desc = "Kill Window", remap = true })
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

vim.keymap.set({"n"}, "<leader>gs", ":Neogit cwd=%:p:h<CR>", { noremap = true, silent = true, desc = "Git Status" })

vim.keymap.set("n", "<leader>=", "gg=G", { desc = "Autoindent the whole file" })

local function confirm_and_delete_buffer()
  local confirm = vim.fn.confirm("Delete buffer and file?", "&Yes\n&No", 2)

  if confirm == 1 then
    os.remove(vim.fn.expand("%"))
    vim.api.nvim_buf_delete(0, { force = true })
  end
end

vim.keymap.set("n", "<leader>D", confirm_and_delete_buffer, { desc = "[D]elete buffer and file" })
