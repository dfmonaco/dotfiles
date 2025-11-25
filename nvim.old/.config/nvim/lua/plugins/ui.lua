return {
  -- Status bar
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme = "catpuccin",
          icons_enabled = true,
          component_separators = "|",
          section_separators = "",
        },
        sections = {
          lualine_c = {
            -- "vim.call('codeium#GetStatusString')",
            require("lsp-progress").progress,
            {'filename', path = 1},
          },
        },
      })

      vim.api.nvim_create_augroup("lualine_augroup", {
        clear = true
      })
      vim.api.nvim_create_autocmd("User", {
        group = "lualine_augroup",
        pattern = "LspProgressStatusUpdated",
        callback = require("lualine").refresh,
      })
    end,
  },
  -- Input and Select prompts
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup({
        input = {
          enabled = true,
          prompt = "➤ ",
          relative = "editor",
          position = "center",
        },
        select = {
          enabled = true,
          backend = { "telescope", "fzf", "builtin" },
        },
      })
    end,
  },
  -- Notifications
  {
    "rcarriga/nvim-notify",
    opts = {
      stages = "static",
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
    init = function()
      vim.notify = require("notify")
    end,
  },
  -- Indent lines
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup({
        enabled = true,
        scope = {
          enabled = false,
        },
        indent = {
          char = "┊",
        },
      })
    end,
  },
  -- Replaces the UI for messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end,
  },
  -- Show hex colors
  {
      "catgoose/nvim-colorizer.lua",
      event = "BufReadPre",
      opts = { -- set to setup table
      },
  },
}
