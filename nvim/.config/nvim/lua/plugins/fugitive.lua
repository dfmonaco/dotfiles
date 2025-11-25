-- vim-fugitive: Git wrapper so awesome, it should be illegal
-- https://github.com/tpope/vim-fugitive
return {
  "tpope/vim-fugitive",
  cmd = {
    "G",
    "Git",
    "Gdiffsplit",
    "Gvdiffsplit",
    "Gedit",
    "Gsplit",
    "Gread",
    "Gwrite",
    "Ggrep",
    "Glgrep",
    "GMove",
    "GRename",
    "GDelete",
    "GRemove",
    "GBrowse",
  },
  keys = {
    { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
    { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
    { "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
    { "<leader>gP", "<cmd>Git pull<cr>", desc = "Git pull" },
    { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
    { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff split" },
    { "<leader>gl", "<cmd>Git log<cr>", desc = "Git log" },
  },
}
