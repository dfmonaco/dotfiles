-- noice.nvim - Highly experimental plugin that completely replaces the UI for messages, cmdline and popupmenu
-- https://github.com/folke/noice.nvim
--
-- NOTE: This config shows ALL available options set to their DEFAULT values
-- Uncomment and modify any option to customize behavior
--
-- Dependencies:
--   - MunifTanjim/nui.nvim (required)
--   - nvim-treesitter (optional but recommended) - for syntax highlighting in cmdline
--   - rcarriga/nvim-notify or folke/snacks.nvim (optional) - for notifications
--
-- Recommended treesitter parsers: vim, regex, lua, bash, markdown, markdown_inline

return {
  "folke/noice.nvim",
  event = "VeryLazy",

  dependencies = {
    "MunifTanjim/nui.nvim",
    -- We use snacks.nvim notifier instead of nvim-notify
    -- "rcarriga/nvim-notify",
  },

  opts = {
    -- ============================================================
    -- CMDLINE - Command-line UI configuration
    -- ============================================================
    cmdline = {
      enabled = true, -- Enable the Noice cmdline UI

      -- View to use for rendering the cmdline
      -- Options: "cmdline_popup" (fancy popup) or "cmdline" (classic bottom)
      view = "cmdline_popup",

      -- Global options for the cmdline view (see section on views)
      opts = {},

      -- Format configurations for different cmdline types
      -- Each format can have: pattern, icon, lang, view, opts, icon_hl_group, title, conceal
      format = {
        -- Regular vim commands (:write, :quit, etc)
        cmdline = {
          pattern = "^:",
          icon = "",
          lang = "vim",
          -- conceal = true, -- Hide the text matching the pattern (default: true)
        },

        -- Forward search (/)
        search_down = {
          kind = "search",
          pattern = "^/",
          icon = " ",
          lang = "regex",
        },

        -- Backward search (?)
        search_up = {
          kind = "search",
          pattern = "^%?",
          icon = " ",
          lang = "regex",
        },

        -- Shell filter commands (:!)
        filter = {
          pattern = "^:%s*!",
          icon = "$",
          lang = "bash",
        },

        -- Lua commands (:lua, := )
        lua = {
          pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
          icon = "",
          lang = "lua",
        },

        -- Help command (:help)
        help = {
          pattern = "^:%s*he?l?p?%s+",
          icon = "",
        },

        -- Input() function prompts
        input = {
          view = "cmdline_input",
          icon = "󰥻 ",
        },

        -- To disable a format, set it to false:
        -- lua = false,
      },
    },

    -- ============================================================
    -- MESSAGES - Message routing and display configuration
    -- ============================================================
    messages = {
      -- NOTE: Enabling messages also enables cmdline automatically (Neovim limitation)
      enabled = true, -- Enable the Noice messages UI

      view = "notify", -- Default view for messages
      view_error = "notify", -- View for error messages
      view_warn = "notify", -- View for warnings
      view_history = "messages", -- View for :messages command
      view_search = "virtualtext", -- View for search count messages. Set to false to disable
    },

    -- ============================================================
    -- POPUPMENU - Completion menu configuration
    -- ============================================================
    popupmenu = {
      enabled = true, -- Enable the Noice popupmenu UI

      -- Backend for showing regular cmdline completions
      -- Options: "nui" (Noice's UI) or "cmp" (nvim-cmp)
      backend = "nui",

      -- Icons for completion item kinds
      -- Set to false to disable icons
      -- Uses defaults from noice.config.icons.kinds
      kind_icons = {},
    },

    -- ============================================================
    -- REDIRECT - Default options for require('noice').redirect()
    -- ============================================================
    redirect = {
      view = "popup",
      filter = { event = "msg_show" },
    },

    -- ============================================================
    -- COMMANDS - Custom Noice commands (:Noice <command>)
    -- ============================================================
    commands = {
      -- :Noice history - Show message history
      history = {
        view = "split",
        opts = { enter = true, format = "details" },
        filter = {
          any = {
            { event = "notify" },
            { error = true },
            { warning = true },
            { event = "msg_show", kind = { "" } },
            { event = "lsp", kind = "message" },
          },
        },
      },

      -- :Noice last - Show last message
      last = {
        view = "popup",
        opts = { enter = true, format = "details" },
        filter = {
          any = {
            { event = "notify" },
            { error = true },
            { warning = true },
            { event = "msg_show", kind = { "" } },
            { event = "lsp", kind = "message" },
          },
        },
        filter_opts = { count = 1 },
      },

      -- :Noice errors - Show error messages
      errors = {
        view = "popup",
        opts = { enter = true, format = "details" },
        filter = { error = true },
        filter_opts = { reverse = true },
      },

      -- :Noice all - Show all messages
      all = {
        view = "split",
        opts = { enter = true, format = "details" },
        filter = {},
      },
    },

    -- ============================================================
    -- NOTIFY - vim.notify routing configuration
    -- ============================================================
    notify = {
      -- Noice can be used as vim.notify to route notifications
      -- Default routes forward notifications to nvim-notify or snacks.nvim
      enabled = true,
      view = "notify",
    },

    -- ============================================================
    -- LSP - Language Server Protocol UI overrides
    -- ============================================================
    lsp = {
      -- LSP Progress messages (bottom right by default)
      progress = {
        enabled = true,

        -- Format for progress messages (see formatting section)
        format = "lsp_progress",
        format_done = "lsp_progress_done",

        throttle = 1000 / 30, -- Update frequency (30 FPS)
        view = "mini",
      },

      -- Override default LSP handlers with Noice
      override = {
        -- Override markdown formatter (improves LSP hover/signature rendering)
        -- Enables beautiful syntax highlighting in LSP hover docs and signatures
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,

        -- Override cmp documentation (requires hrsh7th/nvim-cmp)
        -- NOTE: We use blink.cmp, so this is disabled
        ["cmp.entry.get_documentation"] = false,
      },

      -- Hover documentation (K key by default)
      hover = {
        enabled = true,
        silent = false, -- Set to true to not show message if hover unavailable
        view = nil, -- When nil, use defaults from documentation settings
        opts = {}, -- Merged with defaults from documentation
      },

      -- Signature help (<C-k> in insert mode by default)
      signature = {
        enabled = true,
        auto_open = {
          enabled = true,
          trigger = true, -- Auto-show when typing trigger character
          luasnip = true, -- Show when jumping to Luasnip insert nodes
          throttle = 50, -- Debounce by 50ms
        },
        view = nil, -- When nil, use defaults from documentation settings
        opts = {}, -- Merged with defaults from documentation
      },

      -- LSP server messages
      message = {
        enabled = true,
        view = "notify",
        opts = {},
      },

      -- Default settings for hover and signature help
      documentation = {
        view = "hover",
        opts = {
          lang = "markdown",
          replace = true,
          render = "plain",
          format = { "{message}" },
          win_options = {
            concealcursor = "n",
            conceallevel = 3,
          },
        },
      },
    },

    -- ============================================================
    -- MARKDOWN - Markdown rendering configuration
    -- ============================================================
    markdown = {
      -- Clickable elements in markdown
      hover = {
        ["|(%S-)|"] = vim.cmd.help, -- Vim help links
        -- Wrap in function to avoid loading noice.util before plugin is loaded
        ["%[.-%]%((%S-)%)"] = function(url)
          require("noice.util").open(url)
        end, -- Markdown links
      },

      -- Highlight patterns in markdown
      highlights = {
        ["|%S-|"] = "@text.reference",
        ["@%S+"] = "@parameter",
        ["^%s*(Parameters:)"] = "@text.title",
        ["^%s*(Return:)"] = "@text.title",
        ["^%s*(See also:)"] = "@text.title",
        ["{%S-}"] = "@parameter",
      },
    },

    -- ============================================================
    -- HEALTH - Health check configuration
    -- ============================================================
    health = {
      checker = true, -- Enable health checks (disable if causing issues)
    },

    -- ============================================================
    -- PRESETS - Quick configuration presets
    -- ============================================================
    presets = {
      -- Use classic bottom cmdline for search instead of popup
      bottom_search = false,

      -- Position cmdline and popupmenu together (like VSCode command palette)
      command_palette = true,

      -- Send long messages to a split instead of popup
      long_message_to_split = true,

      -- Enable input dialog for inc-rename.nvim
      inc_rename = false,

      -- Add border to LSP hover docs and signature help
      lsp_doc_border = false,
    },

    -- ============================================================
    -- PERFORMANCE
    -- ============================================================
    -- How frequently Noice checks for UI updates (no effect in blocking mode)
    throttle = 1000 / 30, -- 30 FPS

    -- ============================================================
    -- VIEWS - View configurations (see Noice docs for details)
    -- ============================================================
    -- Override or define custom views here
    -- Example:
    -- views = {
    --   cmdline_popup = {
    --     position = {
    --       row = 5,
    --       col = "50%",
    --     },
    --     size = {
    --       width = 60,
    --       height = "auto",
    --     },
    --   },
    --   popupmenu = {
    --     relative = "editor",
    --     position = {
    --       row = 8,
    --       col = "50%",
    --     },
    --     size = {
    --       width = 60,
    --       height = 10,
    --     },
    --     border = {
    --       style = "rounded",
    --       padding = { 0, 1 },
    --     },
    --     win_options = {
    --       winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
    --     },
    --   },
    -- },
    views = {},

    -- ============================================================
    -- ROUTES - Message routing configuration
    -- ============================================================
    -- Define custom routes to control where messages appear
    -- Routes are checked in order; first match wins (unless stop=false)
    routes = {
      -- Route: Hide noisy messages (file write confirmations, undo/redo)
      -- These messages are sent to the "mini" view (bottom-right corner)
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },      -- "15L, 234B written"
            { find = "; after #%d+" },    -- "undo; after #5"
            { find = "; before #%d+" },   -- "redo; before #3"
          },
        },
        view = "mini",
      },

      -- Route: Skip man page errors when no documentation is available
      -- This happens when pressing K on a word with no LSP hover docs
      {
        filter = {
          event = "notify",
          find = "no manual entry for",
        },
        opts = { skip = true },
      },
    },

    -- ============================================================
    -- STATUS - Statusline component configuration
    -- ============================================================
    -- Define custom statusline components
    -- Available components: message, command, mode, search, ruler
    --
    -- Example usage in lualine:
    -- {
    --   require("noice").api.status.message.get_hl,
    --   cond = require("noice").api.status.message.has,
    -- }
    status = {},

    -- ============================================================
    -- FORMAT - Message formatting configuration
    -- ============================================================
    -- Define custom formatters or override built-in ones
    -- Built-in formatters: level, text, title, event, kind, date, message,
    --                     confirm, cmdline, progress, spinner, data
    --
    -- Example:
    -- format = {
    --   level = {
    --     icons = {
    --       error = "✖",
    --       warn = "▼",
    --       info = "●",
    --     },
    --   },
    -- },
    format = {},
  },

  -- ============================================================
  -- KEYMAPS - Recommended keybindings
  -- ============================================================
  keys = {
    -- Message history
    { "<leader>sn", "<cmd>Noice<cr>", desc = "Noice Message History" },

    -- Last message
    { "<leader>snl", "<cmd>Noice last<cr>", desc = "Noice Last Message" },

    -- Dismiss all visible messages
    { "<leader>snd", "<cmd>Noice dismiss<cr>", desc = "Dismiss All Messages" },

    -- Error messages
    { "<leader>sne", "<cmd>Noice errors<cr>", desc = "Noice Errors" },

    -- Noice stats (for debugging)
    { "<leader>sns", "<cmd>Noice stats<cr>", desc = "Noice Stats" },

    -- Enable/disable Noice
    { "<leader>snt", "<cmd>Noice disable<cr>", desc = "Disable Noice" },
    { "<leader>snT", "<cmd>Noice enable<cr>", desc = "Enable Noice" },

    -- Redirect Cmdline - Press Shift+Enter in cmdline to redirect output to a popup
    -- Useful for: :messages, :!git log, :scriptnames, etc.
    -- The output opens in a scrollable, searchable popup instead of blocking the screen
    {
      "<S-Enter>",
      function()
        require("noice").redirect(vim.fn.getcmdline())
      end,
      mode = "c",
      desc = "Redirect Cmdline to Popup",
    },

    -- LSP hover doc scrolling (in hover windows)
    -- Scroll forward
    {
      "<c-f>",
      function()
        if not require("noice.lsp").scroll(4) then
          return "<c-f>"
        end
      end,
      silent = true,
      expr = true,
      desc = "Scroll Forward (Noice)",
      mode = { "i", "n", "s" },
    },

    -- Scroll backward
    {
      "<c-b>",
      function()
        if not require("noice.lsp").scroll(-4) then
          return "<c-b>"
        end
      end,
      silent = true,
      expr = true,
      desc = "Scroll Backward (Noice)",
      mode = { "i", "n", "s" },
    },
  },
}
