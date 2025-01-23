return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require("which-key").add({
        { "<leader>f", group = "[f]ind" },
        { "<leader>e", group = "[e]dit" },
        { "<leader>r", group = "[r]eplace" },
        { "<leader>t", group = "[t]est" },
        { "<leader>s", group = "[s]earch" },
        { "<leader>h", group = "[h]unk" },
        { "<leader>h_", hidden = true },
        { "<leader>l", group = "[l]sp" },
        { "<leader>l_", hidden = true },
        { "<leader>o", group = "[o]open" },
        { "<leader>o_", hidden = true },
        { "<leader>i", group = "[i]insert" },
        { "<leader>i_", hidden = true },
        { "<leader>a", group = "[a]i" },
        { "<leader>a_", hidden = true },
      })
    end,
  },
}
