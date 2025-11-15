-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local cmd = require("config.commands")

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

vim.keymap.set("n", "<leader>D", cmd.confirm_and_delete_buffer, { desc = "[D]elete buffer and file" })

-- Amp Keybindings
vim.keymap.set("n", "<leader>am", ":AmpSend ", { desc = "Send message to Amp" })
vim.keymap.set("n", "<leader>aa", ":AmpSendBuffer<CR>", { desc = "Send buffer to Amp" })
-- vim.keymap.set("v", "<leader>ap", ":'<,'>AmpPromptSelection<CR>", { desc = "Add selection to Amp prompt" })
-- vim.keymap.set("v", "<leader>ar", ":'<,'>AmpPromptRef<CR>", { desc = "Add file ref to Amp prompt" })

-- PROMPT buffer keybindings
vim.keymap.set("n", "<leader>ap", cmd.toggle_prompt_buffer, { desc = "Toggle PROMPT buffer" })
vim.keymap.set("n", "<leader>ac", cmd.clear_prompt_buffer, { desc = "Clear PROMPT buffer" })
vim.keymap.set("n", "<leader>ar", ":PromptFileRef<CR>", { desc = "Add current file ref to PROMPT buffer" })
vim.keymap.set("v", "<leader>ar", ":'<,'>PromptRef<CR>", { desc = "Add file ref (with lines) to PROMPT buffer" })
