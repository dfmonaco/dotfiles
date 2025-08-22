return {
  {
    "roobert/search-replace.nvim",
    keys = {
      {
        "<C-r>",
        "<CMD>SearchReplaceSingleBufferVisualSelection<CR>",
        mode = "v",
        desc = "Visual search/replace in buffer"
      },
      {
        "<leader>rw",
        "<CMD>SearchReplaceSingleBufferCWord<CR>",
        desc = "Search/replace in buffer for [w]ord"
      },
      {
        "<leader>rW",
        "<CMD>SearchReplaceSingleBufferCWORD<CR>",
        desc = "Search/replace in buffer for [W]WORD"
      },
    },
    config = function()
      require("search-replace").setup({})
    end,
  },
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require("grug-far")
          grug.open({
            transient = true,
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  }
}
