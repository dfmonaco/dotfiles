return {
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
}
