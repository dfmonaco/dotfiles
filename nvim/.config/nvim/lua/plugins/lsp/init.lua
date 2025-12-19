-- LSP Configuration
-- Modern setup for Neovim 0.11+
-- https://github.com/neovim/nvim-lspconfig
--
-- nvim-lspconfig provides server configs from its lsp/ directory.
-- vim.lsp.config (built into Nvim 0.11+) automatically discovers them.
--
-- Installation Strategy:
--   See lua/plugins/lsp/README.md for detailed installation strategy
--   TL;DR: Prefer system packages (pacman), use asdf for version management,
--          per-project when needed, global language tools as fallback
--
-- Language-specific configurations are in separate files:
--   lua/plugins/lsp/lua.lua        - Lua language server
--   lua/plugins/lsp/ruby.lua       - Ruby language server (hybrid detection)
--   lua/plugins/lsp/svelte.lua     - Svelte language server (manual config)
--   lua/plugins/lsp/typescript.lua - TypeScript/JavaScript language server
--   lua/plugins/lsp/python.lua     - Python language server
--   lua/plugins/lsp/bash.lua       - Bash language server
--   lua/plugins/lsp/css.lua        - CSS/HTML/JSON language servers
--   lua/plugins/lsp/eslint.lua     - ESLint language server (conditional)

return {
  "neovim/nvim-lspconfig",
  config = function()
    -- Diagnostic configuration
    vim.diagnostic.config({
      virtual_text = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "✘",
          [vim.diagnostic.severity.WARN] = "▲",
          [vim.diagnostic.severity.HINT] = "◆",
          [vim.diagnostic.severity.INFO] = "○",
        },
      },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        source = true,
      },
    })

    -- LSP keymaps on attach
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Navigation
        map("gd", vim.lsp.buf.definition, "Go to Definition")
        map("gr", vim.lsp.buf.references, "Go to References")
        map("gi", vim.lsp.buf.implementation, "Go to Implementation")
        map("gD", vim.lsp.buf.declaration, "Go to Declaration")

        -- Documentation
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")

        -- Code actions
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("<leader>cr", vim.lsp.buf.rename, "Rename")

        -- Diagnostics
        map("<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")
        map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
        map("]d", vim.diagnostic.goto_next, "Next Diagnostic")

        -- Inlay hints disabled by default
        -- Toggle with <leader>ci when needed
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Toggle inlay hints
        map("<leader>ci", function()
          local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
          vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
          vim.notify("Inlay hints " .. (enabled and "disabled" or "enabled"), vim.log.levels.INFO)
        end, "Toggle Inlay Hints")

        -- ESLint fix all (only when ESLint is attached)
        if client and client.name == "eslint" then
          map("<leader>ce", function()
            vim.lsp.buf.code_action({
              apply = true,
              filter = function(action)
                return action.title:match("Fix all") or action.title:match("fix all")
              end,
            })
          end, "ESLint Fix All")
        end
      end,
    })

    -- Load language-specific configurations
    require("plugins.lsp.lua")
    require("plugins.lsp.ruby")
    require("plugins.lsp.svelte")
    require("plugins.lsp.typescript")
    require("plugins.lsp.python")
    require("plugins.lsp.bash")
    require("plugins.lsp.css")
    require("plugins.lsp.eslint")

    -- Enable simple language servers (no custom config needed)
    local servers = { "lua_ls", "ts_ls", "pyright", "bashls", "cssls" }
    for _, server in ipairs(servers) do
      vim.lsp.enable(server)
    end
  end,
}
