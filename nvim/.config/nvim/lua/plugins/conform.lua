-- Code Formatting Configuration
-- https://github.com/stevearc/conform.nvim
--
-- conform.nvim runs external formatters on your code.
-- This is separate from LSP - formatters only handle code style (indentation,
-- line breaks, quotes), while LSP handles code intelligence (completion, diagnostics).
--
-- Required Formatters (install based on languages you use):
--   Lua:        sudo pacman -S stylua
--   Python:     pip install isort black
--   JS/TS/Web:  sudo pacman -S prettier
--   SQL:        pip install sqlfluff
--   Ruby:       gem install syntax_tree rubocop (or via bundler)
--              syntax_tree (stree) reformats code: wraps long lines, consistent style
--              rubocop runs second for lint autocorrections
--              Project config: .streerc (print width), .rubocop.yml (lint rules)
--   ERB:        npm install -g @herb-tools/formatter  (asdf nodejs)
--              herb-format: ERB-aware HTML+ERB formatter (EXPERIMENTAL PREVIEW)
--              Requires .herb.yml with `formatter.enabled: true` in project root
--              WARNING: experimental - may corrupt files in edge cases; use git!
--
-- Usage:
--   <leader>cf  - Format current buffer

return {
  "stevearc/conform.nvim",
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "",
      desc = "[C]ode [F]ormat buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      svelte = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      sql = { "sqlfluff" },
      -- stree reformats (line wrapping, style), rubocop fixes lint issues after
      ruby = { "syntax_tree", "rubocop" },
      -- herb-format: ERB-aware HTML+ERB formatter (experimental preview)
      -- Requires .herb.yml with `formatter.enabled: true` in project root
      eruby = { "herb_format" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    formatters = {
      sqlfluff = {
        require_cwd = false,
      },
      syntax_tree = {
        -- stree needs the PATH to include asdf shims for the correct Ruby version
        env = {
          PATH = vim.fn.expand("~/.asdf/shims") .. ":" .. vim.env.PATH,
        },
      },
      rubocop = {
        -- rubocop also needs asdf shims
        env = {
          PATH = vim.fn.expand("~/.asdf/shims") .. ":" .. vim.env.PATH,
        },
      },
      herb_format = {
        -- herb-format is installed into asdf-managed Node.js global bin
        command = vim.fn.expand("~/.asdf/shims/herb-format"),
        -- herb-format accepts stdin: `cat file.erb | herb-format`
        -- Pass '-' to explicitly signal stdin input
        stdin = true,
        args = { "-" },
        env = {
          PATH = vim.fn.expand("~/.asdf/shims") .. ":" .. vim.env.PATH,
        },
      },
    },
  },
}
