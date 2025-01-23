return {
  { "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        textobjects = {
          select = {
            -- Enable text objects selection with lookahead.
            enable = true,
            lookahead = true,
            keymaps = {
              -- Define key mappings for various text objects.
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
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
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  -- Markdown preview
  {
    'MeanderingProgrammer/markdown.nvim',
    name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('render-markdown').setup({})
    end,
  },
}
