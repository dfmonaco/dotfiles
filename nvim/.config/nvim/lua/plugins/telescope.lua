-- telescope.nvim - Fuzzy finder over lists
-- https://github.com/nvim-telescope/telescope.nvim

return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.9",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = "Telescope",
  keys = {
    -- File pickers
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Find word under cursor" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },

    -- Vim pickers
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Marks" },
    { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in buffer" },
    { "<leader>fp", "<cmd>Telescope resume<cr>", desc = "Resume previous picker" },

    -- Git pickers
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
    { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git status" },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git branches" },

    -- Search pickers
    { "<leader>sh", "<cmd>Telescope search_history<cr>", desc = "Search history" },
    { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command history" },
  },
  opts = {
    defaults = {
      -- Appearance
      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { "truncate" },
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },

      -- Behavior
      file_ignore_patterns = {
        "node_modules",
        ".git/",
        "%.lock",
      },

      -- Keymaps
      mappings = {
        i = {
          -- Navigation
          ["<C-n>"] = "move_selection_next",
          ["<C-p>"] = "move_selection_previous",
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",

          -- Close
          ["<C-c>"] = "close",
          ["<Esc>"] = "close",

          -- Scroll preview
          ["<C-u>"] = "preview_scrolling_up",
          ["<C-d>"] = "preview_scrolling_down",

          -- Open in splits
          ["<C-x>"] = "select_horizontal",
          ["<C-v>"] = "select_vertical",
          ["<C-t>"] = "select_tab",

          -- Quickfix/Loclist
          ["<C-q>"] = "smart_send_to_qflist",
          ["<M-q>"] = "smart_add_to_qflist",

          -- Show help
          ["<C-h>"] = "which_key",
        },
        n = {
          -- Navigation
          ["j"] = "move_selection_next",
          ["k"] = "move_selection_previous",
          ["gg"] = "move_to_top",
          ["G"] = "move_to_bottom",

          -- Close
          ["<Esc>"] = "close",
          ["q"] = "close",

          -- Open in splits
          ["<C-x>"] = "select_horizontal",
          ["<C-v>"] = "select_vertical",
          ["<C-t>"] = "select_tab",

          -- Quickfix/Loclist
          ["<C-q>"] = "smart_send_to_qflist",
          ["<M-q>"] = "smart_add_to_qflist",

          -- Show help
          ["?"] = "which_key",
        },
      },
    },
    pickers = {
      find_files = {
        hidden = true, -- Show hidden files
      },
      buffers = {
        show_all_buffers = true,
        sort_lastused = true,
        mappings = {
          i = {
            ["<c-d>"] = "delete_buffer",
          },
          n = {
            ["dd"] = "delete_buffer",
          },
        },
      },
    },
  },
}
