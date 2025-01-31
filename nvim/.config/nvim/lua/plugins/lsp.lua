return {
  -- LSP config
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/neodev.nvim", config = true },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      -- used to enable autocompletion (assign to every lsp server config
      local capabilities = cmp_nvim_lsp.default_capabilities()

      local servers = {
        "lua_ls",
        -- "ruby_lsp",
        -- "cssls",
        -- "html",
        -- "bashls",
        -- "solargraph",
        -- "pyright",
      }

      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          }
        }
      })

      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_installation = true,
      })

      local generic_opts = {
        capabilities = capabilities,
        root_dir = util.root_pattern(".git"),
      }

      local server_opts = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
                disable = { 'missing-fields' },
              }
            }
          }
        },
      }

      for _, server in pairs(servers) do
        local opts = vim.tbl_deep_extend("force", generic_opts, server_opts[server] or {})
        lspconfig[server].setup(opts)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        desc = "LSP actions",
        callback = function(event)
          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end

          local bufmap = function(mode, keys, cmd, opts)
            opts.buffer = event.buf
            vim.keymap.set(mode, keys, cmd, opts)
          end
          local telescope_builtin = require("telescope.builtin")

          -- You can search each function in the help page.
          -- For example :help vim.lsp.buf.hover()

          -- It shows information about the symbol under the cursor
          bufmap("n", "<leader>li", "<cmd>lua vim.lsp.buf.hover()<cr>",
            { desc = "Show [i]nfo" })

          -- It jumps to the definition of the symbol under the cursor
          bufmap("n", "<leader>ld", telescope_builtin.lsp_definitions,
            { desc = "Go to [d]efinition" })

          -- It jumps to the references of the symbol under the cursor
          bufmap("n", "<leader>lr", telescope_builtin.lsp_references,
            { desc = "Go to [r]eferences" })

          -- Lists all the implementations of the symbol under the cursor
          bufmap("n", "<leader>li", telescope_builtin.lsp_implementations,
            { desc = "List [i]mplementations" })

          -- Displays the symbols in the current buffer
          bufmap("n", "<leader>ls", telescope_builtin.lsp_document_symbols,
            { desc = "Show [s]imbols" })

          -- Formats the buffer using the current language server
          bufmap(
            { "n", "x" },
            "<leader>lf",
            "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
            { desc = "Buffer [f]ormat" }
          )

          -- Selects a code action available at the current cursor position
          bufmap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Select code [a]ction" })

        end,
      })
    end,
  },
  -- Replacement for tsserver
  {
    "pmizio/typescript-tools.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("typescript-tools").setup({})
    end,
  },
  -- LSP progress
  {
    "linrongbin16/lsp-progress.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lsp-progress").setup({})
    end,
  },
  -- Language server config
  {
    "creativenull/efmls-configs-nvim",
    version = "v1.x.x", -- version is optional, but recommended
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local languages = require("efmls-configs.defaults").languages()
      -- To extend and add additional tools or to override existing
      -- defaults registered:
      languages = vim.tbl_extend("force", languages, {
        -- you custom languages, or overrides
        slim = {
          require("efmls-configs.linters.slim_lint"),
        },
      })
      local efmls_config = {
        filetypes = vim.tbl_keys(languages),
        settings = {
          rootMarkers = { ".git/" },
          languages = languages,
        },
        init_options = {
          documentFormatting = true,
          documentRangeFormatting = true,
        },
      }

      require("lspconfig").efm.setup(vim.tbl_extend("force", efmls_config, {}))
    end,
  },
  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    -- The "InsertEnter" event is triggered when entering insert mode, so we load the plugin at that time.
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP completion source
      "hrsh7th/cmp-buffer", -- Buffer completion source
      "hrsh7th/cmp-path", -- Path completion source
      {
        "L3MON4D3/LuaSnip",
        config = function() require("luasnip.loaders.from_vscode").lazy_load() end
      },
      "saadparwaiz1/cmp_luasnip", -- Snippet completion source
      "onsails/lspkind-nvim", -- Icons for autocompletion
    },
    opts = function()
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      return {
        window = {
          completion = cmp.config.window.bordered({ border = "rounded" }),
          documentation = cmp.config.window.bordered({ border = "rounded" }),
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        formatting = {
          format = require("lspkind").cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
          })
        },
        -- completeopt controls how completion menus are displayed.
        -- "menu,menuone,noinsert" means show a menu, show only one menu entry, and don't insert the completion automatically.
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          -- Confirm the current completion item
          -- "<CR>" is the Enter key. This mapping confirms the currently selected completion item.
          ["<TAB>"] = cmp.mapping.confirm({ select = true }),
          -- Confirm and replace the current completion item
          -- "<S-CR>" is the Shift + Enter key. This mapping confirms and replaces the current completion item.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
        }),
        sources = cmp.config.sources(
          {
            -- LSP completion source
            -- "nvim_lsp" uses the Language Server Protocol to provide completion items.
            { name = "nvim_lsp" },
            -- Path completion source
            -- "path" provides completion for file paths.
            { name = "path" },
            -- Buffer completion source
            -- "buffer" provides completion for words in the current buffer.
            { name = "buffer",
              option = {
                get_bufnrs = function()
                  return vim.api.nvim_list_bufs()
                end
              }
            },
            -- Snippet completion source
            -- "luasnip" provides completion for snippets.
            { name = "luasnip" },
          }),
        sorting = defaults.sorting,
      }
    end,
    config = function(_, opts)
      -- The group index determines the order in which completion sources are queried.
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end

      local cmp = require("cmp")
      -- "CompletionItemKind" is used to identify the type of completion item.
      local Kind = cmp.lsp.CompletionItemKind

      -- cmp.setup configures nvim-cmp with the options we provided in the "opts" function.-- cmp.setup configures nvim-cmp with the options we provided in the "opts" function.
      cmp.setup(opts)

      -- Event handler for when a completion item is confirmed
      cmp.event:on("confirm_done", function(event)
        -- Check if auto-brackets are enabled for the current filetype
        -- opts.auto_brackets is a table of filetypes for which auto-brackets are enabled.
        if not vim.tbl_contains(opts.auto_brackets or {}, vim.bo.filetype) then
          return
        end

        -- Get the confirmed completion item
        local entry = event.entry
        local item = entry:get_completion_item()

        -- Check if the completion item is a function or method
        if vim.tbl_contains({ Kind.Function, Kind.Method }, item.kind) then
          -- We insert "()" after the function/method name and move the cursor inside the parentheses.
          local keys = vim.api.nvim_replace_termcodes("()<left>", false, false, true)
          vim.api.nvim_feedkeys(keys, "i", true)
        end
      end)
    end,
  },
  -- LSP timeout
  {
    "hinell/lsp-timeout.nvim",
    dependencies={ "neovim/nvim-lspconfig" },
    init = function()
      vim.g.lspTimeoutConfig = {
        stopTimeout  = 1000 * 60 * 5, -- ms, timeout before stopping all LSPs 
        startTimeout = 1000 * 10,     -- ms, timeout before restart
        silent       = false          -- true to suppress notifications
      }
    end
  },
}
