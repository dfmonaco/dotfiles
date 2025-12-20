-- ESLint Language Server Configuration
-- Installation (Priority Order):
--   1. System (Recommended): sudo pacman -S vscode-langservers-extracted
--   2. Global via npm: npm install -g vscode-langservers-extracted
--
-- Installed via: pacman (vscode-langservers-extracted)
-- Command used: vscode-eslint-language-server --stdio
--
-- Uses nvim-lspconfig's built-in eslint configuration which provides:
-- - Proper workspaceFolder settings (required by the server)
-- - Automatic flat config detection
-- - Yarn PnP support
-- - All required handlers
--
-- Provides real-time linting for:
-- - JavaScript (.js, .jsx)
-- - TypeScript (.ts, .tsx)
-- - Svelte (.svelte)
-- - Vue, Astro, and more
--
-- Enabled via init.lua with: vim.lsp.enable("eslint")

-- Custom configuration overrides
vim.lsp.config("eslint", {
  settings = {
    -- Validate files
    validate = "on",

    -- Package manager for resolving ESLint
    packageManager = "npm",

    -- Use flat config (eslint.config.js) - will be auto-detected by before_init
    -- but we set it explicitly for projects using flat config
    experimental = {
      useFlatConfig = true,
    },

    -- Code action settings
    codeActionOnSave = {
      enable = false, -- Manual fix via <leader>ce instead
      mode = "all",
    },

    -- Formatting is handled by Prettier via conform.nvim
    format = false,

    -- Run ESLint on type (real-time diagnostics)
    run = "onType",

    -- Required settings (must not be nil)
    quiet = false,
    onIgnoredFiles = "off",
    useESLintClass = false,
    rulesCustomizations = {},

    -- Problems to report
    problems = {
      shortenToSingleLine = false,
    },

    -- Working directories
    workingDirectory = {
      mode = "auto",
    },

    -- Code action settings
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = "separateLine",
      },
      showDocumentation = {
        enable = true,
      },
    },
  },
})
