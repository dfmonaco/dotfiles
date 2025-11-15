-- ============================================================================
-- Commands Module - Entry point for all custom commands
-- ============================================================================

-- Load command modules
require("config.commands.amp")
require("config.commands.prompt_buffer")

-- Export utility functions
local utils = require("config.commands.utils")
local prompt_buffer = require("config.commands.prompt_buffer")

local M = {}

M.confirm_and_delete_buffer = utils.confirm_and_delete_buffer
M.toggle_prompt_buffer = prompt_buffer.toggle_prompt_buffer
M.clear_prompt_buffer = prompt_buffer.clear_prompt_buffer

return M