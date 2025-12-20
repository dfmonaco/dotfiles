-- Tailwind CSS Language Server Configuration
-- Installation (Priority Order):
--   1. System (Recommended): sudo pacman -S tailwindcss-language-server
--
-- Installed via: pacman
-- Command used: tailwindcss-language-server --stdio
-- Strategy: System-only (works across all Tailwind projects)
--
-- Provides:
-- - Autocomplete for Tailwind CSS classes
-- - Hover documentation showing CSS output
-- - Linting for invalid classes, conflicts, and deprecated utilities
-- - Support for @apply, @tailwind, @reference and other directives
-- - Color decorators for Tailwind classes
--
-- Requirements:
-- - tailwindcss installed in project (npm/pnpm/yarn)
-- - For v4: CSS file with @import "tailwindcss"
-- - For v3: tailwind.config.{js,cjs,mjs,ts,cts,mts} in project root
--
-- Note: This LSP understands Tailwind directives that cssls reports as "Unknown at rule"

-- Custom configuration for tailwindcss LSP
vim.lsp.config("tailwindcss", {
  settings = {
    tailwindCSS = {
      -- Class attributes to provide completions for
      classAttributes = { "class", "className", "class:list", "classList", "ngClass" },

      -- Include additional language support
      includeLanguages = {
        eelixir = "html-eex",
        elixir = "phoenix-heex",
        eruby = "erb",
        heex = "phoenix-heex",
        htmlangular = "html",
        templ = "html",
        -- Svelte is already supported by default
      },

      -- Linting configuration
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
      },

      -- Enable validation
      validate = true,

      -- Show px equivalents for rem values
      showPixelEquivalents = true,
      rootFontSize = 16,

      -- Enable color decorators
      colorDecorators = true,

      -- Enable hover documentation
      hovers = true,

      -- Enable autocomplete suggestions
      suggestions = true,

      -- Enable code actions
      codeActions = true,
    },
  },
})

-- Enabled via init.lua with: vim.lsp.enable("tailwindcss")
