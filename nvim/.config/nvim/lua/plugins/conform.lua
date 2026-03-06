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
    },
  },
}
