-- Completion Engine - blink.cmp
-- https://github.com/saghen/blink.cmp
-- Modern, performant completion plugin with built-in fuzzy matching

return {
  "saghen/blink.cmp",
  version = "1.*", -- Use release tag for pre-built binaries
  
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- Keymap preset with enhanced accept options
    keymap = {
      preset = "default",
      ["<C-y>"] = { "select_and_accept" }, -- Accept selected item (or first if none selected)
      ["<Tab>"] = { "select_and_accept" }, -- Accept with Tab (or first if none selected)
    },

    appearance = {
      -- 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      nerd_font_variant = "mono",
    },

    -- Completion menu and documentation appearance
    completion = {
      menu = {
        border = "single", -- Add border to completion menu
      },
      documentation = {
        auto_show = false,       -- Show documentation only when manually triggered
        window = { border = "single" }, -- Add border to documentation window
      },
    },

    -- Signature help with border
    signature = {
      enabled = true,
      window = { border = "single" },
    },

    -- Sources: LSP, path, snippets, buffer (from all open buffers)
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      
      -- Provider-specific configuration
      providers = {
        buffer = {
          opts = {
            -- Autocomplete from all open buffers (not just current)
            -- Filters out special buffers (terminals, quickfix, etc.)
            get_bufnrs = function()
              return vim.tbl_filter(function(bufnr)
                -- Only include normal buffers (files)
                return vim.bo[bufnr].buftype == ""
              end, vim.api.nvim_list_bufs())
            end,
          },
        },
      },
    },

    -- Use Rust fuzzy matcher (falls back to Lua if Rust unavailable)
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
