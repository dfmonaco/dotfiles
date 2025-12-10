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
      ["<Tab>"] = { "select_and_accept" }, -- Accept with Tab (or first if none selected)
    },

    appearance = {
      -- 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      nerd_font_variant = "mono",
    },

    -- Completion menu and documentation appearance
    completion = {
      menu = {
        border = "rounded", -- Rounded border (matches documentation window)
      },
      documentation = {
        auto_show = true,        -- Show documentation automatically after delay
        auto_show_delay_ms = 1000, -- 1 second delay (only shows when pausing on item)
        update_delay_ms = 50,    -- Quick updates when switching items
        window = {
          border = "rounded",
        },
      },
      
      -- Auto-brackets: automatically insert brackets for functions/methods
      -- Uses LSP semantic tokens to intelligently determine when brackets are needed
      -- Works alongside nvim-autopairs (autopairs handles manual typing, this handles completions)
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      
      -- Ghost text: inline preview of selected completion (consistent with cmdline)
      ghost_text = {
        enabled = true,
      },
    },

    -- Signature help: disabled to avoid window clutter
    signature = {
      enabled = false,
    },

    -- Sources: LSP, path, snippets, buffer (from all open buffers)
    sources = {
      default = { "lsp", "path", "buffer" },
      
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

    -- Command-line completion with fuzzy matching
    -- Provides typo-resistant completions for :commands, file paths, options, etc.
    cmdline = {
      enabled = true,
      -- Use same keymaps as insert mode for consistency
      -- <Tab> = accept, <C-n>/<C-p> = navigate, <C-e> = cancel
      keymap = {
        preset = "default",
        -- Override Tab to match insert mode behavior exactly
        ["<Tab>"] = { "select_and_accept" },
      },
      sources = { "cmdline", "buffer" }, -- Command completion + buffer text
      
      completion = {
        -- Auto-show completions as you type
        menu = { auto_show = true },
        
        -- Selection behavior (same as insert mode)
        list = {
          selection = {
            preselect = true,    -- Auto-select first item
            auto_insert = true,  -- Insert selection automatically
          },
        },
        
        -- Show preview of selected item inline (like fish shell)
        ghost_text = { enabled = true },
      },
    },
  },
  opts_extend = { "sources.default" },
}
