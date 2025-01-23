return {
  { "nvim-pack/nvim-spectre",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      {
        "<leader>sp",
        '<cmd>lua require("spectre").toggle()<CR>',
        desc = "Toggle Search/Replace [p]anel",
      },
      {
        "<leader>sw",
        '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
        desc = "Search current [w]ord on all files",
      },
      { "<leader>sb",
        '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
        desc = "Search current word on current [b]uffer",
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
  },
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
        "<C-s>",
        "<CMD>SearchReplaceWithinVisualSelection<CR>",
        mode = "v",
        desc = "Search/replace within visual selection"
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
}
