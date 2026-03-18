-- Lualine: Statusline with mode, git branch, diagnostics
-- https://github.com/nvim-lualine/lualine.nvim
return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      theme = "auto",
      component_separators = "",
      section_separators = "",
      globalstatus = true,
    },
    sections = {
      -- Left side
      lualine_a = {
        {
          "mode",
          fmt = function(mode)
            local mode_map = {
              ["NORMAL"] = "N",
              ["INSERT"] = "I",
              ["VISUAL"] = "V",
              ["V-LINE"] = "VL",
              ["V-BLOCK"] = "VB",
              ["COMMAND"] = "C",
              ["REPLACE"] = "R",
              ["TERMINAL"] = "T",
              ["SELECT"] = "S",
              ["S-LINE"] = "SL",
              ["S-BLOCK"] = "SB",
              ["EX"] = "E",
              ["O-PENDING"] = "O",
            }
            return mode_map[mode] or mode:sub(1, 1)
          end,
        },
      },
      lualine_b = {
        {
          function()
            local cwd = vim.fn.getcwd()
            return vim.fn.fnamemodify(cwd, ":t")
          end,
        },
      },
      lualine_c = {
        {
          "branch",
          icon = "󰊢",
        },
      },
      -- Right side
      lualine_x = {
        -- LSP servers with language icons
        {
          function()
            local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
            if #buf_clients == 0 then
              return ""
            end

            local lsp_icons = {
              lua_ls = "󰢱",     -- Lua icon
              ruby_lsp = "󰴭",   -- Ruby icon
              pyright = "󰌠",    -- Python icon
              ts_ls = "󰛦",      -- TypeScript/JavaScript icon
              bashls = "",     -- Bash icon
              cssls = "󰌜",      -- CSS3 icon
              herb_ls = "󰌝",    -- HTML+ERB icon (Herb)
            }

            local icons = {}
            for _, client in ipairs(buf_clients) do
              local icon = lsp_icons[client.name]
              if icon then
                table.insert(icons, icon)
              end
            end

            if #icons > 0 then
              return table.concat(icons, " ")
            end
            return ""
          end,
          color = { fg = "#7aa2f7" },
        },
        -- Copilot status indicator
        {
          function()
            if vim.fn.exists("*copilot#RunningClient") == 0 then
              return ""
            end
            local client = vim.fn["copilot#RunningClient"]()
            if client == vim.NIL or client == 0 then
              return ""
            end
            if vim.fn["copilot#Enabled"]() == 1 then
              return ""
            end
            return ""
          end,
          color = function()
            if vim.fn.exists("*copilot#RunningClient") == 0 then
              return { fg = "#565f89" }
            end
            local client = vim.fn["copilot#RunningClient"]()
            if client == vim.NIL or client == 0 then
              return { fg = "#e0af68" }
            end
            if vim.fn["copilot#Enabled"]() == 1 then
              return { fg = "#7aa2f7" }
            end
            return { fg = "#565f89" }
          end,
          cond = function()
            return true
          end,
        },
        -- OpenCode statusline component
        {
          function()
            return require('nvim-opencode').statusline.get_component()
          end,
        },
      },
      lualine_y = {},
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  },
}
