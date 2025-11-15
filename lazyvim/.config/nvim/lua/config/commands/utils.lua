local M = {}

-- ============================================================================
-- Utility Functions
-- ============================================================================

-- Builds a file reference string in the format: @file/path[#L<line-range>]
-- Parameters:
--   opts: command options table with line1 and line2 (from range)
-- Returns: reference string or nil if buffer has no filename
function M.build_file_reference(opts)
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname == "" then
    return nil
  end

  local relative_path = vim.fn.fnamemodify(bufname, ":.")
  local ref = "@" .. relative_path
  if opts.line1 ~= opts.line2 then
    ref = ref .. "#L" .. opts.line1 .. "-" .. opts.line2
  elseif opts.line1 > 1 then
    ref = ref .. "#L" .. opts.line1
  end

  return ref
end

-- Deletes the current buffer and its associated file after confirmation
-- Prompts the user with a confirmation dialog before deleting
function M.confirm_and_delete_buffer()
  local confirm = vim.fn.confirm("Delete buffer and file?", "&Yes\n&No", 2)

  if confirm == 1 then
    os.remove(vim.fn.expand("%"))
    vim.api.nvim_buf_delete(0, { force = true })
  end
end

return M
