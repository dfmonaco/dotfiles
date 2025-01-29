return {
  -- {
  -- 	"Exafunction/codeium.vim",
  --     enabled = false,
  -- 	event = "BufEnter",
  -- 	config = function()
  -- 		vim.keymap.set("i", "<C-h>", function()
  -- 			return vim.fn["codeium#Accept"]()
  -- 		end, { expr = true })
  -- 		vim.keymap.set("i", "<C-j>", function()
  -- 			return vim.fn["codeium#CycleCompletions"](1)
  -- 		end, { expr = true })
  -- 		vim.keymap.set("i", "<C-k>", function()
  -- 			return vim.fn["codeium#CycleCompletions"](-1)
  -- 		end, { expr = true })
  -- 		vim.keymap.set("i", "<C-BS>", function()
  -- 			return vim.fn["codeium#Clear"]()
  -- 		end, { expr = true })
  -- 		vim.keymap.set("n", "<C-i>", function()
  -- 			return vim.fn["codeium#Chat"]()
  -- 		end, { expr = true })
  -- 	end,
  -- },
  --
  -- Debug diagnostics with AI or Google
  {
    "piersolenski/wtf.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {},
    keys = {
      {
        "gW",
        mode = { "n", "x" },
        function()
          require("wtf").ai()
        end,
        desc = "Debug diagnostic with AI",
      },
      {
        mode = { "n" },
        "gw",
        function()
          require("wtf").search()
        end,
        desc = "Search diagnostic with Google",
      },
    },
  },
  -- Code generation
  {
    "David-Kunz/gen.nvim",
    config = function()
      local gen = require("gen")
      gen.setup({
        model = "llama3:8b", -- The default model to use.
        display_mode = "split", -- The display mode. Can be "float" or "split".
        show_prompt = true, -- Shows the Prompt submitted to Ollama.
        host = "10.0.0.57",
        show_model = true, -- Displays which model you are using at the beginning of your chat session.
        no_auto_close = false, -- Never closes the window automatically.
        -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
        -- This can also be a lua function returning a command string, with options as the input parameter.
        -- The executed command must return a JSON object with { response, context }
        -- (context property is optional).
        command = function(options)
          return "curl --silent --no-buffer -X POST http://"
            .. options.host
            .. ":"
            .. options.port
            .. "/api/chat -d $body"
        end,
        debug = false,
      })
      gen.prompts['Fix_Code'] = {
        prompt = "Fix the following code. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
        replace = false,
        extract = "```$filetype\n(.-)```"
      }
      vim.keymap.set({ 'n', 'v' }, '<leader>ag', ':Gen<CR>', { desc = "[A][I] Menu" })
      vim.keymap.set({ 'n', 'v' }, '<leader>am', function() gen.select_model() end, { desc = "[A]I Select [m]odel" })
    end,
  },
  -- Code Companion
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- Optional
      {
        "stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
        opts = {},
      },
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              env = {
                url = "http://10.0.0.57:11434/api/chat",
              },
              schema = {
                model = {
                  default = "deepseek-coder-v2:16b",
                },
              },
            })
          end,
          -- chat_prompt = [[
          -- You are an AI programming assistant. When asked for your name, you must respond with "Codezilla". Follow the user's requirements carefully & to the letter. Your expertise is strictly limited to software development topics.
          --
          -- You can answer general programming questions and perform the following tasks:
          -- - Ask a question about the files in your current workspace
          -- - Explain how the selected code works
          -- - Generate unit tests for the selected code
          -- - Propose a fix for the problems in the selected code
          -- - Scaffold code for a new feature
          -- - Ask questions about Neovim
          -- - Ask how to do something in the terminal
          --
          -- First think step-by-step - describe your plan for what to build in pseudocode, written out in great detail. Then output the code in a single code block. Minimize any other prose. Use Markdown formatting in your answers. Make sure to include the programming language name at the start of the Markdown code blocks. Avoid wrapping the whole response in triple backticks. The user works in a text editor called Neovim which has a concept for editors with open files, integrated unit test support, an output pane that shows the output of running the code as well as an integrated terminal. The active document is the source code the user is looking at right now. You can only give one reply for each conversation turn.
          --   ]],
          -- }),
        },
        strategies = {
          chat = "ollama",
          inline = "ollama",
          tools = "ollama",
        },
      })
      vim.keymap.set({ "n" }, "<leader>ac", "<cmd>CodeCompanionChat<cr>", { desc = "[A]I [c]hat" })
      vim.keymap.set({ "v" }, "<leader>aa", "<cmd>CodeCompanionAdd<cr>", { desc = "[A]I [a]dd" })
      vim.keymap.set({ "n", "v" }, "<leader>ai", "<cmd>CodeCompanionActions<cr>", { desc = "[A]I act[i]ons" })
      vim.keymap.set({ "n" }, "<leader>at", "<cmd>CodeCompanionToggle<cr>", { desc = "[A]I [t]oggle" })
    end,
  },
  {
    "robitx/gp.nvim",
    config = function()
      local conf = {
        providers = {
          openai = {
            endpoint = "https://api.openai.com/v1/chat/completions",
          }
        },
        agents = {
          {
            name = "Codezilla",
            provider = "openai",
            chat = true,
            model = { model = "gpt-4o" },
            system_prompt = [[
                  You are a highly knowledgeable Programming Mentor Bot specialized in Ruby, Ruby on Rails, JavaScript, jQuery, StimulusJS, SQL, PostgreSQL, and Git. Your primary functions include:

                  Answering Questions: Provide concise, easy-to-understand explanations for queries related to the specified technologies.
                  Tutorials on Demand: Create brief tutorials to illustrate basic to intermediate concepts within your areas of expertise.
                  Code Improvement: Suggest improvements for code snippets submitted by users. Aim for readability, performance, and best practices.
                  Bug Finding: Analyze code snippets to identify potential bugs or issues, explaining both the problem and the recommended fix.
                  Code Explanation: Dismantle complex code snippets, guiding users through the logic step-by-step in a few sentences.

                  Your responses should be concise, aiming for a few sentences. Encourage users to ask follow-up questions if they seek deeper understanding or clarification.
                ]],
          }
        },
      }
      require("gp").setup(conf)
    end
  },
}
