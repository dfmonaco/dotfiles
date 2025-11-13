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

-- Amp commands and keybindings
-- Send a quick message to the agent
vim.api.nvim_create_user_command("AmpSend", function(opts)
  local message = opts.args
  if message == "" then
    print("Please provide a message to send")
    return
  end

  local amp_message = require("amp.message")
  amp_message.send_message(message)
end, {
  nargs = "*",
  desc = "Send a message to Amp",
})

-- Send entire buffer contents
vim.api.nvim_create_user_command("AmpSendBuffer", function(opts)
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local content = table.concat(lines, "\n")

  local amp_message = require("amp.message")
  amp_message.send_message(content)
end, {
  nargs = "?",
  desc = "Send current buffer contents to Amp",
})

-- Add selected text directly to prompt
vim.api.nvim_create_user_command("AmpPromptSelection", function(opts)
  local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
  local text = table.concat(lines, "\n")

  local amp_message = require("amp.message")
  amp_message.send_to_prompt(text)
end, {
  range = true,
  desc = "Add selected text to Amp prompt",
})

-- Add file+selection reference to prompt
vim.api.nvim_create_user_command("AmpPromptRef", function(opts)
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname == "" then
    print("Current buffer has no filename")
    return
  end

  local relative_path = vim.fn.fnamemodify(bufname, ":.")
  local ref = "@" .. relative_path
  if opts.line1 ~= opts.line2 then
    ref = ref .. "#L" .. opts.line1 .. "-" .. opts.line2
  elseif opts.line1 > 1 then
    ref = ref .. "#L" .. opts.line1
  end

  local amp_message = require("amp.message")
  amp_message.send_to_prompt(ref)
end, {
  range = true,
  desc = "Add file reference (with selection) to Amp prompt",
})

-- Amp Keybindings
vim.keymap.set("n", "<leader>aS", ":AmpSend ", { desc = "Send message to Amp" })
vim.keymap.set("n", "<leader>aB", ":AmpSendBuffer<CR>", { desc = "Send buffer to Amp" })
vim.keymap.set("v", "<leader>ap", ":'<,'>AmpPromptSelection<CR>", { desc = "Add selection to Amp prompt" })
vim.keymap.set("v", "<leader>ar", ":'<,'>AmpPromptRef<CR>", { desc = "Add file ref to Amp prompt" })