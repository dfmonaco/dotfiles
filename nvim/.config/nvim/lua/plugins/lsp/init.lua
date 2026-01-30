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
--   lua/plugins/lsp/tailwind.lua   - Tailwind CSS language server
--   lua/plugins/lsp/eslint.lua     - ESLint language server (conditional)
--
-- Keymap Quick Reference (Hybrid Scheme with Snacks.nvim):
--   Navigation (using Snacks.nvim pickers - defined in plugins/snacks.lua):
--     gd          Go to Definition (Snacks picker)
--     gr          Go to References (Snacks picker)
--     gI          Go to Implementation (Snacks picker)
--     gy          Go to Type Definition (Snacks picker)
--     gD          Go to Declaration (Snacks picker)
--     gai         Incoming Calls (Snacks picker)
--     gao         Outgoing Calls (Snacks picker)
--     gb          Jump Back (to previous location in jumplist)
--
--   Documentation (vim defaults):
--     K           Hover Documentation
--     [d / ]d     Previous/Next Diagnostic
--
--   Code namespace (<leader>c - Quick access without picker):
--     <leader>cs  Signature Help
--     <leader>ca  Code Action
--     <leader>cn  Rename Symbol
--     <leader>cf  Format Buffer
--     <leader>cw  Workspace Symbols (Snacks picker) [also: <leader>sS]
--     <leader>co  Document Outline (Snacks picker) [also: <leader>ss]
--     <leader>cx  Show Diagnostic Float
--     <leader>cX  List All Diagnostics
--     <leader>ch  Toggle Inlay Hints
--     <leader>cl  Toggle Document Highlight
--     <leader>cR  Restart LSP
--     <leader>cI  LSP Info
--     <leader>ce  ESLint Fix All (conditional)

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
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- ============================================================
        -- FREQUENT ACTIONS (vim-style for speed)
        -- ============================================================
        -- Note: Navigation keymaps (gd, gr, gI, gy, gD, gai, gao) are
        -- provided by snacks.nvim with fancy picker UI (see plugins/snacks.lua)
        -- We don't override them here to keep the better UX

        -- Documentation (vim convention)
        map("K", vim.lsp.buf.hover, "Hover Documentation")

        -- Diagnostics navigation (vim convention)
        map("[d", function()
          vim.diagnostic.jump({ count = -1 })
        end, "Previous Diagnostic")
        map("]d", function()
          vim.diagnostic.jump({ count = 1 })
        end, "Next Diagnostic")

        -- Jump back in jumplist (after navigation like gd/gr/etc)
        -- Note: Vim's built-in <C-o> (back) and <C-i> (forward) also work
        map("gb", "<C-o>", "Jump Back (to previous location)")

        -- ============================================================
        -- CODE NAMESPACE (<leader>c)
        -- ============================================================
        -- Quick access to LSP features without picker UI
        -- Use these when you want immediate action without fuzzy search

        -- Documentation
        map("<leader>cs", vim.lsp.buf.signature_help, "Signature Help")

        -- Actions
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action", "v") -- Visual mode
        map("<leader>cn", vim.lsp.buf.rename, "Rename Symbol")
        map("<leader>cf", function()
          vim.lsp.buf.format({ async = false })
        end, "Format Buffer")

        -- Workspace & Symbols (using Snacks pickers for better UX)
        map("<leader>cw", function()
          -- Use global Snacks (set by lazy.nvim) instead of require()
          if _G.Snacks and _G.Snacks.picker then
            _G.Snacks.picker.lsp_workspace_symbols()
          else
            vim.lsp.buf.workspace_symbol()
          end
        end, "Workspace Symbols")
        map("<leader>co", function()
          -- Use global Snacks (set by lazy.nvim) instead of require()
          if _G.Snacks and _G.Snacks.picker then
            _G.Snacks.picker.lsp_symbols()
          else
            vim.lsp.buf.document_symbol()
          end
        end, "Document Outline")

        -- Call Hierarchy (removed - use gai/gao from snacks.lua instead)

        -- Diagnostics
        map("<leader>cx", vim.diagnostic.open_float, "Show Diagnostic")
        map("<leader>cX", vim.diagnostic.setloclist, "List All Diagnostics")

        -- Toggles
        map("<leader>ch", function()
          local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
          vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
          vim.notify("Inlay hints " .. (enabled and "disabled" or "enabled"), vim.log.levels.INFO)
        end, "Toggle Inlay Hints")

        map("<leader>cl", function()
          if vim.b[event.buf].document_highlight_enabled then
            vim.lsp.buf.clear_references()
            vim.b[event.buf].document_highlight_enabled = false
            vim.notify("Document highlight disabled", vim.log.levels.INFO)
          else
            vim.lsp.buf.document_highlight()
            vim.b[event.buf].document_highlight_enabled = true
            vim.notify("Document highlight enabled", vim.log.levels.INFO)
          end
        end, "Toggle Document Highlight")

        -- LSP Management
        map("<leader>cR", "<cmd>LspRestart<cr>", "Restart LSP")
        map("<leader>cI", "<cmd>LspInfo<cr>", "LSP Info")

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
    require("plugins.lsp.tailwind")
    require("plugins.lsp.eslint")

    -- Enable simple language servers (no custom config needed)
    local servers = { "lua_ls", "ts_ls", "pyright", "bashls", "cssls", "tailwindcss", "eslint" }
    for _, server in ipairs(servers) do
      vim.lsp.enable(server)
    end
  end,
}
