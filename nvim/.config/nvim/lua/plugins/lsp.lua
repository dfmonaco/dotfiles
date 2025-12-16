-- LSP Configuration
-- Modern setup for Neovim 0.11+
-- https://github.com/neovim/nvim-lspconfig
--
-- nvim-lspconfig provides server configs from its lsp/ directory.
-- vim.lsp.config (built into Nvim 0.11+) automatically discovers them.
--
-- Install language servers manually:
--   Strategy: Prefer system packages (pacman), fallback to language-specific managers
--
--   lua:        sudo pacman -S lua-language-server
--   css:        sudo pacman -S vscode-langservers-extracted (includes json/yaml/html/css)
--   typescript: npm install -g typescript-language-server typescript
--   python:     pip install pyright
--   ruby:       gem install ruby-lsp
--   bash:       npm install -g bash-language-server

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

    -- Customize ruby_lsp with hybrid approach (per-project + global fallback)
    -- We need to handle this manually because cmd needs to be determined at runtime
    vim.lsp.config("ruby_lsp", {
      cmd_env = {
        -- This ensures rbenv shims are in PATH
        PATH = vim.env.PATH,
      },
    })

    -- Enable language servers (nvim-lspconfig provides the configs)
    local servers = { "lua_ls", "ts_ls", "pyright", "bashls", "cssls" }
    for _, server in ipairs(servers) do
      vim.lsp.enable(server)
    end

    -- Ruby LSP: Manual start with hybrid command detection
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "ruby",
      callback = function(args)
        -- Determine ruby-lsp command based on Gemfile.lock presence
        local cmd
        local gemfile_lock = vim.fn.filereadable("Gemfile.lock") == 1
        
        if gemfile_lock then
          -- Check if ruby-lsp is in Gemfile.lock
          local lockfile = vim.fn.readfile("Gemfile.lock")
          local has_ruby_lsp = false
          for _, line in ipairs(lockfile) do
            if line:match("^%s*ruby%-lsp") then
              has_ruby_lsp = true
              break
            end
          end
          
          if has_ruby_lsp then
            cmd = { "bundle", "exec", "ruby-lsp" }
          else
            cmd = { "ruby-lsp" }
          end
        else
          cmd = { "ruby-lsp" }
        end

        -- Find root directory
        local root_dir = vim.fs.root(args.buf, { "Gemfile", ".git" })

        -- Start LSP client
        vim.lsp.start({
          name = "ruby_lsp",
          cmd = cmd,
          root_dir = root_dir,
        })
      end,
    })
  end,
}
