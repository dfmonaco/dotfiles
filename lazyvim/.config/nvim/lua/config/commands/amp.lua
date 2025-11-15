local utils = require("config.commands.utils")

-- ============================================================================
-- Amp Commands - Send content to Amp AI agent
-- ============================================================================

-- :AmpSend [message]
-- Sends a custom text message to Amp
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

-- :AmpSendBuffer
-- Sends the entire current buffer contents to Amp
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

-- :AmpPromptSelection (visual mode)
-- Sends selected text to Amp's message prompt
vim.api.nvim_create_user_command("AmpPromptSelection", function(opts)
  local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
  local text = table.concat(lines, "\n")

  local amp_message = require("amp.message")
  amp_message.send_to_prompt(text)
end, {
  range = true,
  desc = "Add selected text to Amp prompt",
})

-- :AmpPromptRef (visual mode)
-- Sends a file reference (with optional line selection) to Amp's message prompt
-- Format: @file/path#L<start>-<end>
vim.api.nvim_create_user_command("AmpPromptRef", function(opts)
  local ref = utils.build_file_reference(opts)
  if not ref then
    print("Current buffer has no filename")
    return
  end

  local amp_message = require("amp.message")
  amp_message.send_to_prompt(ref)
end, {
  range = true,
  desc = "Add file reference (with selection) to Amp prompt",
})
