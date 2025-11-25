return {
  -- Add mappings to easily manipulate surroundings
  { "tpope/vim-surround" },
  -- Extends text objects to support additional targets
  { "wellle/targets.vim" },
  -- Repeats supported plugin commands with '.'
  { "tpope/vim-repeat" },
  -- Auto pairs for "" '' () []
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  }
}
