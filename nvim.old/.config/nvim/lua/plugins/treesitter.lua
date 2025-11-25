return {
  { "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      highlight = {
        enable = true,
      },
      indent = {
        enable = false,
      },
      ensure_installed = {
        "javascript",
        "typescript",
        "tsx",
        "lua",
        "vim",
        "vimdoc",
        "css",
        "json",
        "ruby",
        "python",
        "yaml",
        "hyprlang",
      },
    })
  end,
},
{
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
  opts = {},
},
}
