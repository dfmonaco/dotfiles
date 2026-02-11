-- vim-test: Run tests at the speed of thought
return {
  "vim-test/vim-test",

  -- Lazy load when opening test files or running test commands
  cmd = {
    "TestNearest",
    "TestFile",
    "TestSuite",
    "TestLast",
    "TestVisit",
  },

  keys = {
    { "<leader>tn", "<cmd>TestNearest<cr>", desc = "Test Nearest" },
    { "<leader>tf", "<cmd>TestFile<cr>", desc = "Test File" },
    { "<leader>ts", "<cmd>TestSuite<cr>", desc = "Test Suite" },
    { "<leader>tl", "<cmd>TestLast<cr>", desc = "Test Last" },
    { "<leader>tv", "<cmd>TestVisit<cr>", desc = "Test Visit" },
  },

  config = function()
    -- Use Neovim's built-in terminal in a split
    vim.g["test#strategy"] = "neovim"

    -- Open terminal at bottom in horizontal split
    vim.g["test#neovim#term_position"] = "botright"

    -- Start in normal mode (easier to scroll through output)
    vim.g["test#neovim#start_normal"] = 1

    -- Preserve screen between test runs
    vim.g["test#preserve_screen"] = 0

    -- Map CTRL-o to exit terminal insert mode easily
    vim.keymap.set("t", "<C-o>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
  end,
}
