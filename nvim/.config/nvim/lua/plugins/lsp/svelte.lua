-- Svelte Language Server Configuration
-- Installation (Priority Order):
--   1. System (Recommended): sudo pacman -S svelte-language-server
--
-- Installed via: pacman
-- Command used: svelteserver --stdio
-- Strategy: System-only (Svelte LSP version rarely affects functionality)
--
-- Provides:
-- - HTML/CSS completions with Emmet support
-- - TypeScript integration for script blocks
-- - Svelte-specific formatting and diagnostics
--
-- Requirements:
-- - svelte.config.js or package.json in project root
-- - TypeScript LSP (ts_ls) enabled for best results in script blocks
--
-- Note: Manual start required because not included in nvim-lspconfig by default

vim.api.nvim_create_autocmd("FileType", {
  pattern = "svelte",
  callback = function(args)
    -- Find root directory
    local root_dir = vim.fs.root(args.buf, { "svelte.config.js", "package.json", ".git" })

    if not root_dir then
      vim.notify("Svelte LSP: Could not find project root", vim.log.levels.WARN)
      return
    end

    -- Start LSP client
    vim.lsp.start({
      name = "svelte",
      cmd = { "svelteserver", "--stdio" },
      root_dir = root_dir,
      settings = {
        svelte = {
          plugin = {
            html = {
              completions = {
                enable = true,
                emmet = true, -- Enable Emmet abbreviations
              },
            },
            css = {
              completions = {
                enable = true,
                emmet = true,
              },
            },
            typescript = {
              enable = true,
              diagnostics = { enable = true },
              hover = { enable = true },
              completions = { enable = true },
              codeActions = { enable = true },
              rename = { enable = true },
            },
            svelte = {
              compilerWarnings = {},
              format = {
                enable = true,
                config = {
                  svelteSortOrder = "options-scripts-markup-styles",
                  svelteStrictMode = false,
                  svelteAllowShorthand = true,
                  svelteIndentScriptAndStyle = true,
                },
              },
            },
          },
        },
      },
    })
  end,
})
