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
    prompt_library = {
      ["Proofread"] = {
        strategy = "chat",
        description = "Writing assistant for refining texts, emails, and chats",
        opts = {
          index = 1,
          is_default = true,
          is_slash_cmd = true,
          short_name = "proofread",
          ignore_system_prompt = true,
        },
        prompts = {
          {
            role = "system",
            content = [[
You are a Chatbot AI specialized in assisting users with enhancing their
writing and proofreading skills. Your expertise covers a wide range of text types,
including general documents, emails, and chat messages.
Your goal is to provide clear, concise, and actionable feedback
to help users improve their communication effectiveness.
            ]],
          },
          {
            role = "user",
            content = [[
Please proofread and enhance the following text:

]],
          },
        },
      },
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
