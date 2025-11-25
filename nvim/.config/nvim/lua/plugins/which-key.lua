-- which-key.nvim - Displays a popup with possible key bindings
-- https://github.com/folke/which-key.nvim

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern", -- Use modern preset for better visuals
    delay = 200, -- Delay before showing the popup (ms)

    -- Group definitions with icons
    spec = {
      { "<leader>f", group = "find", icon = "" },
      { "<leader>g", group = "git", icon = "" },
      { "<leader>gh", group = "hunks", icon = "" },
      { "<leader>b", group = "buffer", icon = "" },
      { "<leader>c", group = "code", icon = "" },
      { "<leader>s", group = "search", icon = "" },
      { "<leader>w", group = "windows", proxy = "<c-w>", icon = "" },
    },

    -- Plugins configuration
    plugins = {
      marks = true, -- Shows marks on ' and `
      registers = true, -- Shows registers on " in NORMAL or <C-r> in INSERT
      spelling = {
        enabled = true, -- Show WhichKey for z= spelling suggestions
        suggestions = 20, -- Number of suggestions to show
      },
      -- Built-in help for common keybindings
      presets = {
        operators = true, -- Help for operators like d, y, etc.
        motions = true, -- Help for motions
        text_objects = true, -- Help for text objects after operator
        windows = true, -- Default bindings on <c-w>
        nav = true, -- Misc bindings for navigation
        z = true, -- Bindings for folds, spelling, etc.
        g = true, -- Bindings prefixed with g
      },
    },

    -- Window configuration
    win = {
      border = "rounded", -- Border style
      padding = { 1, 2 }, -- Extra padding [top/bottom, right/left]
      title = true, -- Show title
      title_pos = "center", -- Title position
    },

    -- Layout configuration
    layout = {
      width = { min = 20 }, -- Min width of columns
      spacing = 3, -- Spacing between columns
    },

    -- Show help message in command line
    show_help = true,
    show_keys = true,
  },

  -- Key mappings
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
    {
      "<c-w><space>",
      function()
        require("which-key").show({ keys = "<c-w>", loop = true })
      end,
      desc = "Window Hydra Mode (which-key)",
    },
  },
}
