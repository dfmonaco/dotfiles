return {
  -- File explorer that lets you edit your filesystem
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup()
    end,
    keys = {
      {
        "-", "<cmd>Oil --float<cr>", desc = "Open [e]xplorer"
      }
    }
  },
}
