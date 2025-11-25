-- Catppuccin colorscheme
-- A soothing pastel theme with great plugin integrations
-- https://github.com/catppuccin/nvim
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Load before other plugins to ensure theme is applied first
    config = function()
      require("catppuccin").setup({
        flavour = "auto", -- auto, latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false, -- Disables setting the background color
        show_end_of_buffer = false, -- Shows the '~' characters after the end of buffers
        term_colors = true, -- Sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false, -- Dims the background color of inactive window
          shade = "dark",
          percentage = 0.15, -- Percentage of the shade to apply to the inactive window
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { "italic" }, -- Change the style of comments
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        default_integrations = true, -- Enable default integrations
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
          -- For more plugins integrations see https://github.com/catppuccin/nvim#integrations
        },
      })

      -- Setup must be called before loading the colorscheme
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
