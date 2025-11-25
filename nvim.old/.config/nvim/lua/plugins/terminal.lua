return {
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        open_mapping = "<C-8>",
        direction = "float",
        shade_terminals = true,
      })

      local Terminal = require("toggleterm.terminal").Terminal

      local rails_c = Terminal:new({
        name = "rails console",
        cmd = "rails c",
        hidden = true,
        on_open = function()
          vim.cmd("startinsert!")
        end,
      })

      local rails_s = Terminal:new({
        name = "rails server",
        cmd = "rails s",
        hidden = true,
      })

      function Rails_c_toggle()
        rails_c:toggle()
      end

      function Rails_s_toggle()
        rails_s:toggle()
      end

      vim.keymap.set("n", "<C-1>", "<cmd>lua Rails_s_toggle()<cr>", { noremap = true, silent = true})
      vim.keymap.set("t", "<C-1>", "<cmd>lua Rails_s_toggle()<cr>" )

      vim.keymap.set("n", "<C-9>", "<cmd>lua Rails_c_toggle()<cr>", { noremap = true, silent = true})
      vim.keymap.set("t", "<C-9>", "<cmd>lua Rails_c_toggle()<cr>" )

      vim.keymap.set("n", "<leader>o1", "<cmd>1ToggleTerm name=Term1<cr>", { desc = "Open [1] terminal" })

      vim.keymap.set("n", "<leader>o2", "<cmd>2ToggleTerm name=Term2<cr>", { desc = "Open [2] terminal" })
    end,
  },
}
