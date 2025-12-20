-- CSS/HTML/JSON Language Server Configuration
-- Installation (Priority Order):
--   1. System (Recommended): sudo pacman -S vscode-langservers-extracted
--
-- Installed via: pacman
-- Command used: vscode-css-language-server
-- Strategy: System-only (web standards rarely need project isolation)
--
-- This package provides multiple language servers:
-- - cssls:   CSS language server
-- - html:    HTML language server (available but not enabled)
-- - jsonls:  JSON language server (available but not enabled)
-- - eslint:  ESLint language server (configured separately in eslint.lua)
--
-- Currently enabled: cssls (CSS/SCSS/LESS)
-- To enable others: Add to init.lua servers list and create respective config files
--
-- Note: Formatting is handled by Prettier via conform.nvim, not by this LSP.
--       Install Prettier with: sudo pacman -S prettier

-- Custom configuration for cssls
vim.lsp.config("cssls", {
  settings = {
    css = {
      lint = {
        -- Ignore unknown at-rules (e.g., @apply, @tailwind, @reference)
        -- These are handled by tailwindcss LSP instead
        unknownAtRules = "ignore",
      },
    },
    scss = {
      lint = {
        unknownAtRules = "ignore",
      },
    },
    less = {
      lint = {
        unknownAtRules = "ignore",
      },
    },
  },
})

-- Enabled via init.lua with: vim.lsp.enable("cssls")
