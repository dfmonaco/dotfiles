-- Gitsigns: Git integration for buffers
-- https://github.com/lewis6991/gitsigns.nvim
-- Version: v2.0.0

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    -- Sign column configuration
    signs = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    -- Staged changes signs (dimmed versions)
    signs_staged = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
    signs_staged_enable = true,

    -- Display options
    signcolumn = true, -- Show signs in sign column
    numhl = false, -- Highlight line numbers
    linehl = false, -- Highlight entire line
    word_diff = false, -- Highlight word-level changes
    
    -- Git integration
    watch_gitdir = {
      follow_files = true, -- Track file moves with git mv
    },
    auto_attach = true,
    attach_to_untracked = true, -- Attach to untracked files

    -- Current line blame (inline git blame)
    current_line_blame = false, -- Disabled by default, toggle with <leader>tb
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- End of line
      delay = 500, -- Delay in ms before showing blame
      ignore_whitespace = false,
      virt_text_priority = 100,
      use_focus = true, -- Only show when buffer is focused
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",

    -- Performance
    sign_priority = 6,
    update_debounce = 100,
    max_file_length = 40000, -- Disable for files longer than this

    -- Preview window configuration
    preview_config = {
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
      border = "rounded",
    },

    -- Keymaps setup function
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation between hunks
      map("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, { desc = "Next hunk" })

      map("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, { desc = "Previous hunk" })

      map("n", "]H", function()
        gitsigns.nav_hunk("last")
      end, { desc = "Last hunk" })

      map("n", "[H", function()
        gitsigns.nav_hunk("first")
      end, { desc = "First hunk" })

      -- Hunk actions
      map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
      map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })
      map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })

      -- Visual mode: stage/reset selected range
      map("v", "<leader>hs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Stage hunk" })

      map("v", "<leader>hr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Reset hunk" })

      -- Buffer actions
      map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
      map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
      map("n", "<leader>hU", gitsigns.reset_buffer_index, { desc = "Unstage buffer" })

      -- Preview hunks
      map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk (popup)" })
      map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview hunk (inline)" })

      -- Blame
      map("n", "<leader>hb", function()
        gitsigns.blame_line({ full = true })
      end, { desc = "Blame line (popup)" })
      map("n", "<leader>hB", gitsigns.blame, { desc = "Blame buffer (split)" })

      -- Diff
      map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff this" })
      map("n", "<leader>hD", function()
        gitsigns.diffthis("~")
      end, { desc = "Diff against HEAD~1" })

      -- Quickfix/Location list
      map("n", "<leader>hq", gitsigns.setqflist, { desc = "Hunks to quickfix" })
      map("n", "<leader>hQ", function()
        gitsigns.setqflist("all")
      end, { desc = "All hunks to quickfix" })
      map("n", "<leader>hl", gitsigns.setloclist, { desc = "Hunks to location list" })

      -- Toggle options
      map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })
      map("n", "<leader>ts", gitsigns.toggle_signs, { desc = "Toggle signs" })
      map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle word diff" })
      map("n", "<leader>tl", gitsigns.toggle_linehl, { desc = "Toggle line highlight" })
      map("n", "<leader>tn", gitsigns.toggle_numhl, { desc = "Toggle number highlight" })

      -- Text object (operate on hunk)
      map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select hunk" })
    end,
  },
}
