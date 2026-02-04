-- nvim-opencode - OpenCode integration for Neovim
-- Local development plugin
return {
  {
    dir = "~/code/nvim.op.old",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    dir = "~/code/nvim-opencode",
    config = function()
      require("plugin").setup()
    end,
  }
}
