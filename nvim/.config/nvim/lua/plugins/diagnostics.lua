return {
  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>lp", function()
        require("trouble").toggle()
      end, desc = "Toggle diagnostics [p]anel"
      },
      { "<leader>lr", function()
        require("trouble").toggle("lsp_references")
      end, desc = "Toggle LSP [r]eferences"
      },
    },
    config = function()
      require("trouble").setup({})
    end,
  },

}
