-- LSP Configuration
-- Modern setup for Neovim 0.11+
-- https://github.com/neovim/nvim-lspconfig
--
-- nvim-lspconfig provides server configs from its lsp/ directory.
-- vim.lsp.config (built into Nvim 0.11+) automatically discovers them.
--
-- Install language servers manually:
--   lua:        sudo pacman -S lua-language-server
--   typescript: npm install -g typescript-language-server
--   python:     pip install pyright
--   ruby:       gem install ruby-lsp
--   bash:       npm install -g bash-language-server
--   json/yaml:  npm install -g vscode-langservers-extracted

return {
  "neovim/nvim-lspconfig",
  config = function()
    -- Diagnostic configuration
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        source = true,
      },
    })

    -- Diagnostic signs
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

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
      end,
    })

    -- Customize lua_ls for Neovim development
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          workspace = {
            checkThirdParty = false,
            library = { vim.env.VIMRUNTIME },
          },
          diagnostics = { globals = { "vim" } },
        },
      },
    })

    -- Enable language servers (nvim-lspconfig provides the configs)
    local servers = { "lua_ls", "ts_ls", "pyright", "ruby_lsp", "bashls" }
    for _, server in ipairs(servers) do
      vim.lsp.enable(server)
    end
  end,
}
