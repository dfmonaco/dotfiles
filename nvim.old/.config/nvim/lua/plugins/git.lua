return {
  -- Git signs and hunk management
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "#" },
          delete = { text = "-" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]h", function()
            if vim.wo.diff then
              return "]h"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, desc = "Next hunk" })

          map("n", "[h", function()
            if vim.wo.diff then
              return "[h"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, desc = "Previous hunk" })

          -- Actions
          map("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Hunk [s]tage in selection" })
          map("v", "<leader>hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Hunk [r]eset in selection" })

          map("n", "<leader>hs", gs.stage_hunk, { desc = "Hunk [s]tage" })
          map("n", "<leader>hr", gs.reset_hunk, { desc = "Hunk [r]eset" })
          map("n", "<leader>hS", gs.stage_buffer, { desc = "Hunk [S]tage all in buffer" })
          map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Hunk [u]ndo stage" })
          map("n", "<leader>hR", gs.reset_buffer, { desc = "Hunk [R]eset all in buffer" })
          map("n", "<leader>hp", gs.preview_hunk, { desc = "Hunk [p]review" })
          map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end, { desc = "Line [b]lame" })
          map("n", "<leader>hd", gs.diffthis, { desc = "Hunk [d]iff" })
          map("n", "<leader>hD", function()
            gs.diffthis("~")
          end, { desc = "Hunk [D]iff all in buffer" })
          map("n", "<leader>ht", gs.toggle_deleted, { desc = "Hunk [t]oggle deleted" })
          map("n", "<leader>ha", ":Gitsigns setloclist<CR>", { desc = "Hunk show [a]ll" })

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
      })
    end,
  },
  -- Git wrapper
  { "tpope/vim-fugitive" },
  -- LazyGit
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>og", "<cmd>LazyGit<cr>", desc = "[o]pen [g]it" }
    }
  },
}
