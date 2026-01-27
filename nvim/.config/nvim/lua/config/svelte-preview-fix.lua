-- Fix for svelte (and other filetypes) syntax highlighting in snacks.nvim picker preview
-- Issue: Preview buffers are set to "snacks_picker_preview" filetype, preventing treesitter
--
-- Root cause: snacks/picker/core/preview.lua:280 sets buffer filetype = "snacks_picker_preview"
--             The highlight function tries to use treesitter but the buffer has wrong filetype
--
-- Solution: Patch the preview highlight method to set the correct filetype before treesitter

local M = {}

function M.setup()
  -- Wait for Snacks to load
  vim.defer_fn(function()
    local ok, snacks_picker = pcall(require, "snacks.picker.core.preview")
    if not ok then
      return
    end

    -- Store original highlight method
    local original_highlight = snacks_picker.highlight

    -- Override with our fixed version
    function snacks_picker:highlight(opts)
      opts = opts or {}
      
      -- Detect the filetype
      local ft = opts.ft
      if not ft and opts.buf then
        local modeline = require("snacks.picker.util").modeline(opts.buf)
        ft = modeline and modeline.ft
      end
      if not ft and (opts.file or opts.buf) then
        ft = vim.filetype.match({
          buf = opts.buf or self.win.buf,
          filename = opts.file,
        })
      end

      -- Set the buffer filetype BEFORE attempting treesitter
      -- This is the key fix - the buffer needs the correct filetype for treesitter to work
      if ft and ft ~= "snacks_picker_preview" and ft ~= "bigfile" then
        vim.bo[self.win.buf].filetype = ft
      end

      -- Now call original highlight (treesitter should work now)
      return original_highlight(self, opts)
    end
  end, 100)
end

return M
