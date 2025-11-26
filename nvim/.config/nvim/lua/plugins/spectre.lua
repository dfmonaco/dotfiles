-- nvim-spectre - Search and replace across files
return {
  "nvim-pack/nvim-spectre",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "<leader>st",
      function()
        require("spectre").toggle()
      end,
      desc = "Toggle Search/Replace [p]anel",
    },
    {
      "<leader>sW",
      function()
        require("spectre").open_visual({ select_word = true })
      end,
      desc = "Search current [w]ord on all files",
    },
  },
  config = function()
    require("spectre").setup({
      highlight = {
        ui = "String",
        search = "DiffChange",
        replace = "DiffDelete",
      },
    })
  end,
}
