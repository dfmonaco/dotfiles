local utils = require("config.commands.utils")

local M = {}

-- ============================================================================
-- Helper functions for PROMPT buffer management
-- ============================================================================

-- Searches through all open buffers and returns the PROMPT buffer if it exists
-- Returns: buffer number or nil
local function find_prompt_buffer()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_name(buf):match("PROMPT$") then
      return buf
    end
  end
  return nil
end

-- Configures a buffer with PROMPT-specific settings:
-- - Makes it a non-file buffer (no disk writes)
-- - Enables text wrapping to window width
-- - Enables smart line breaks
local function configure_prompt_buffer(bufnr)
  vim.api.nvim_set_option_value("buftype", "nofile", { buf = bufnr })
  vim.api.nvim_set_option_value("bufhidden", "hide", { buf = bufnr })
  vim.api.nvim_set_option_value("swapfile", false, { buf = bufnr })

  local win_id = vim.api.nvim_get_current_win()
  vim.api.nvim_set_option_value("wrap", true, { win = win_id })
  vim.api.nvim_set_option_value("linebreak", true, { win = win_id })
  vim.api.nvim_set_option_value("breakindent", true, { win = win_id })
end

-- Creates a new PROMPT buffer with proper configuration
-- Returns: buffer number of the newly created buffer
local function create_prompt_buffer()
  vim.cmd("enew")
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_name(bufnr, "PROMPT")
  configure_prompt_buffer(bufnr)
  return bufnr
end

-- Finds the PROMPT buffer or creates one if it doesn't exist
-- If PROMPT buffer is created, optionally stays in it or returns to the original buffer
-- Parameters:
--   stay_in_buffer: if true, stays in PROMPT buffer after creation; if false, returns to original
-- Returns: buffer number of PROMPT buffer
local function get_or_create_prompt_buffer(stay_in_buffer)
  local prompt_bufnr = find_prompt_buffer()

  if not prompt_bufnr then
    local current_buf = vim.api.nvim_get_current_buf()
    prompt_bufnr = create_prompt_buffer()
    if not stay_in_buffer then
      vim.cmd("buffer " .. current_buf)
    end
  end

  return prompt_bufnr
end

-- Helper function to append a line of text to the PROMPT buffer
-- Creates the buffer if it doesn't exist
-- Parameters:
--   text: the text to append as a new line
function M.append_to_prompt_buffer(text)
  local prompt_bufnr = get_or_create_prompt_buffer(false)
  local lines = vim.api.nvim_buf_get_lines(prompt_bufnr, 0, -1, false)
  table.insert(lines, text)
  vim.api.nvim_buf_set_lines(prompt_bufnr, 0, -1, false, lines)
end

-- Toggles the PROMPT buffer visibility
-- If PROMPT buffer exists and is displayed, switches to it
-- If PROMPT buffer exists but is not displayed, opens it in current window
-- If PROMPT buffer doesn't exist, creates a new one and switches to it
function M.toggle_prompt_buffer()
  local prompt_bufnr = find_prompt_buffer()

  if prompt_bufnr then
    local win_id = vim.fn.bufwinid(prompt_bufnr)
    if win_id ~= -1 then
      vim.api.nvim_set_current_win(win_id)
    else
      vim.cmd("buffer " .. prompt_bufnr)
    end
  else
    create_prompt_buffer()
  end
end

-- Clears all content from the current PROMPT buffer
-- Does nothing if not in a PROMPT buffer
-- Prints error message if executed outside of PROMPT buffer
function M.clear_prompt_buffer()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.api.nvim_buf_get_name(bufnr):match("PROMPT$") then
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {})
  else
    print("Not in PROMPT buffer")
  end
end

-- ============================================================================
-- PROMPT Buffer Commands - Add content to local PROMPT buffer
-- ============================================================================

-- :PromptRef (visual mode)
-- Appends a file reference (with optional line selection) to PROMPT buffer
-- Format: @file/path#L<start>-<end>
vim.api.nvim_create_user_command("PromptRef", function(opts)
  local ref = utils.build_file_reference(opts)
  if not ref then
    print("Current buffer has no filename")
    return
  end

  M.append_to_prompt_buffer(ref)
end, {
  range = true,
  desc = "Add file reference (with selection) to PROMPT buffer",
})

-- :PromptFileRef
-- Appends the current file reference to PROMPT buffer (without line numbers)
-- Format: @file/path
vim.api.nvim_create_user_command("PromptFileRef", function(opts)
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname == "" then
    print("Current buffer has no filename")
    return
  end

  local relative_path = vim.fn.fnamemodify(bufname, ":.")
  local ref = "@" .. relative_path

  M.append_to_prompt_buffer(ref)
end, {
  desc = "Add current file reference to PROMPT buffer",
})

return M
