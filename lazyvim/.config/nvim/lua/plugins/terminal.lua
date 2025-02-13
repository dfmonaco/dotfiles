return {
  {
    "akinsho/toggleterm.nvim",
    opts = {
      direction = "float",
    },
    keys = {
      {
        "<Esc>",
        function()
          require("toggleterm").toggle()
        end,
        desc = "Close Terminal",
        mode = { "t" },
      },
      {
        "<C-1>",
        function()
          require("toggleterm").toggle(1, nil, nil, "float", "Console 1")
        end,
        desc = "Toggle Terminal 1",
        mode = { "n", "t" },
      },
      {
        "<C-2>",
        function()
          require("toggleterm").toggle(2, nil, nil, "float", "Console 2")
        end,
        desc = "Toggle Terminal 2",
        mode = { "n", "t" },
      },
      {
        "<C-3>",
        function()
          require("toggleterm").toggle(3, nil, nil, "float", "Console 3")
        end,
        desc = "Toggle Terminal 3",
        mode = { "n", "t" },
      },
    },
  },
  {
    "mikesmithgh/kitty-scrollback.nvim",
    enabled = true,
    lazy = true,
    cmd = {
      "KittyScrollbackGenerateKittens",
      "KittyScrollbackCheckHealth",
      "KittyScrollbackGenerateCommandLineEditing",
    },
    event = { "User KittyScrollbackLaunch" },
    config = function()
      require("kitty-scrollback").setup()
    end,
  },
}
