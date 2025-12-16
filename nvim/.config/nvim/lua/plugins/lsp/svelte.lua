-- Svelte Language Server Configuration
-- Install: npm install -g svelte-language-server
--
-- Provides:
-- - HTML/CSS completions with Emmet support
-- - TypeScript integration for script blocks
-- - Svelte-specific formatting and diagnostics
--
-- Note: Requires svelte.config.js or package.json in project root
-- Note: Also enable TypeScript LSP (ts_ls) for best results in Svelte projects

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
