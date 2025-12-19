-- ESLint Language Server Configuration
-- Installation (Priority Order):
--   1. System (Recommended): sudo pacman -S vscode-langservers-extracted
--   2. Global via npm: npm install -g vscode-langservers-extracted
--
-- Installed via: pacman (vscode-langservers-extracted)
-- Command used: vscode-eslint-language-server --stdio
-- Strategy: Conditional activation (only starts if ESLint config exists)
--
-- Provides real-time linting for:
-- - JavaScript (.js, .jsx)
-- - TypeScript (.ts, .tsx)
-- - Svelte (.svelte)
--
-- Note: This LSP only activates in projects with an ESLint config file.
-- Projects without ESLint are silently skipped.

-- ESLint config file patterns to detect
local eslint_config_patterns = {
  "eslint.config.js",
  "eslint.config.mjs",
  "eslint.config.cjs",
  "eslint.config.ts",
  "eslint.config.mts",
  "eslint.config.cts",
  ".eslintrc",
  ".eslintrc.js",
  ".eslintrc.cjs",
  ".eslintrc.json",
  ".eslintrc.yaml",
  ".eslintrc.yml",
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "svelte",
  },
  callback = function(args)
    -- Find project root with ESLint config
    local root_dir = vim.fs.root(args.buf, eslint_config_patterns)

    -- If no ESLint config found, don't start the LSP
    if not root_dir then
      return
    end

    -- Start ESLint LSP client
    vim.lsp.start({
      name = "eslint",
      cmd = { "vscode-eslint-language-server", "--stdio" },
      root_dir = root_dir,

      -- ESLint-specific initialization options
      init_options = {
        -- Path to Node.js (uses system node)
        nodePath = "",
      },

      settings = {
        -- Validate these file types
        validate = "on",

        -- Package manager for resolving ESLint
        packageManager = "npm",

        -- Use flat config (eslint.config.js) when available
        useFlatConfig = true,

        -- Experimental settings
        experimental = {
          useFlatConfig = true,
        },

        -- Code action settings
        codeActionOnSave = {
          enable = false, -- Manual fix via <leader>ce instead
          mode = "problems",
        },

        -- Formatting is handled by Prettier via conform.nvim
        format = false,

        -- Run ESLint on type (real-time diagnostics)
        run = "onType",

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

      -- Handlers for ESLint-specific methods
      handlers = {
        -- Handle ESLint probe requests (checks if ESLint should run)
        ["eslint/openDoc"] = function(_, result)
          if result then
            vim.fn.system({ "xdg-open", result.url })
          end
          return {}
        end,

        ["eslint/confirmESLintExecution"] = function()
          return 4 -- approved
        end,

        ["eslint/probeFailed"] = function()
          vim.notify("ESLint probe failed", vim.log.levels.WARN)
          return {}
        end,

        ["eslint/noLibrary"] = function()
          vim.notify("ESLint library not found in project", vim.log.levels.WARN)
          return {}
        end,
      },

      -- Additional capabilities
      capabilities = vim.lsp.protocol.make_client_capabilities(),
    })
  end,
})
