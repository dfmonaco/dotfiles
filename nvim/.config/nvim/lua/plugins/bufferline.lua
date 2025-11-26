return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        style_preset = require("bufferline").style_preset.default, -- or bufferline.style_preset.minimal
        themable = true,
        numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string
        close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
        indicator = {
          icon = "▎", -- this should be omitted if indicator style is not 'icon'
          style = "icon", -- | 'underline' | 'none'
        },
        buffer_close_icon = "󰅖",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        --- name_formatter can be used to change the buffer's label in the bufferline.
        --- Please note some names can/will break the
        --- bufferline so use this at your discretion knowing that it has
        --- some limitations that will *NOT* be fixed.
        
        -- UPDATED: Custom name formatter to show parent directory for duplicates
        name_formatter = function(buf)
          -- Get the full path
          local path = buf.path
          local filename = vim.fn.fnamemodify(path, ":t")
          
          -- Check if there are other buffers with the same filename
          local buffers = vim.fn.getbufinfo({ buflisted = 1 })
          local duplicates = {}
          
          for _, b in ipairs(buffers) do
            if vim.fn.fnamemodify(b.name, ":t") == filename and b.bufnr ~= buf.bufnr then
              table.insert(duplicates, b.name)
            end
          end
          
          -- If duplicates exist, show parent directory
          if #duplicates > 0 then
            local parent = vim.fn.fnamemodify(path, ":h:t")
            return parent .. "/" .. filename
          end
          
          -- Otherwise just show filename
          return filename
        end,
        
        max_name_length = 25, -- UPDATED: Increased to accommodate parent folder
        max_prefix_length = 20, -- UPDATED: Increased for better visibility
        truncate_names = true, -- whether or not tab names should be truncated
        tab_size = 25, -- UPDATED: Increased for parent folder display
        diagnostics = false, -- | "nvim_lsp" | "coc"
        diagnostics_update_in_insert = false,
        -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
        color_icons = true, -- whether or not to add the filetype icon highlights
        show_buffer_icons = true, -- disable filetype icons for buffers
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        show_duplicate_prefix = true, -- UPDATED: Enable showing duplicate prefix
        duplicates_across_groups = true, -- whether to consider duplicate paths in different groups as duplicates
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        separator_style = "thin", -- | "slope" | "thick" | "thin" | { 'any', 'any' }
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        auto_toggle_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        sort_by = "id", -- | 'insert_after_current' | 'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
      },
    })

    -- Keymaps for buffer navigation
    vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
    vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
    vim.keymap.set("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle buffer pin" })
    vim.keymap.set("n", "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete non-pinned buffers" })
    vim.keymap.set("n", "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", { desc = "Delete other buffers" })
  end,
}
