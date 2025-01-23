return {
  -- [Test runner]
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "olimorris/neotest-rspec",
    },
    keys = {
      { "<leader>tt", function()
        require("neotest").run.run()
      end, desc = "Run nearest [t]est"},

      { "<leader>tf", function()
        require("neotest").run.run(vim.fn.expand("%"))
      end, desc = "Run [f]ile"},

      { "<leader>to", function()
        require("neotest").output.open({ enter = true })
      end, desc = "Open test [o]utput"},

      { "<leader>ts", function()
        require("neotest").summary.toggle()
      end, desc = "Toggle test [s]ummary"},

      { "<leader>tp", function()
        require("neotest").output_panel.toggle()
      end, desc = "Toggle test output [p]anel"},
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-rspec"),
        },
      })
    end,
  },
}
