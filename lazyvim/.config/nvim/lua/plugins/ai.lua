return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    strategies = {
      chat = {
        adapter = "openai",
      },
    },
    opts = {
      log_level = "DEBUG",
    },
    adapters = {
      openai = function()
        return require("codecompanion.adapters").extend("openai", {
          schema = {
            model = {
              default = "gpt-4o",
            },
          },
        })
      end,
    },
  },
  keys = {
    { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
    {
      "<leader>aa",
      "<cmd>CodeCompanionChat Toggle<cr>",
      desc = "Toggle AI Chat",
      mode = { "n", "v" },
    },
    {
      "<leader>am",
      "<cmd>CodeCompanionActions<cr>",
      desc = "Open AI Menu",
      mode = { "n", "v" },
    },
    {
      "ga",
      "<cmd>CodeCompanionChat Add<cr>",
      desc = "Add visual selection to AI Chat",
      mode = { "v" },
    },
  },
}
