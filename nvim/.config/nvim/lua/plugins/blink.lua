-- Completion Engine - blink.cmp
-- https://github.com/saghen/blink.cmp
-- Modern, performant completion plugin with built-in fuzzy matching

return {
  "saghen/blink.cmp",
  version = "1.*", -- Use release tag for pre-built binaries
  
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- Keymap preset: 'default' uses C-y to accept (like built-in completion)
    keymap = { preset = "default" },

    appearance = {
      -- 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      nerd_font_variant = "mono",
    },

    -- Show documentation only when manually triggered (not auto)
    completion = {
      documentation = { auto_show = false },
    },

    -- Sources: LSP, path, buffer (no snippets)
    sources = {
      default = { "lsp", "path", "buffer" },
    },

    -- Use Rust fuzzy matcher (falls back to Lua if Rust unavailable)
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
