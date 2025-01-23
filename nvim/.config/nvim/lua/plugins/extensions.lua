return {
  -- Add mappings to easily manipulate surroundings
  { "tpope/vim-surround" },
  -- Extends text objects to support additional targets
  { "wellle/targets.vim" },
  -- Repeats supported plugin commands with '.'
  { "tpope/vim-repeat" },
  -- Auto pairs for "" '' () []
  {
    "echasnovski/mini.pairs" ,
    event = "VeryLazy",
    config = function()
      require("mini.pairs").setup()
    end,
  },
}
