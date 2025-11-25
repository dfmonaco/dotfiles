-- oil.nvim - File explorer: edit your filesystem like a buffer
-- https://github.com/stevearc/oil.nvim

return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false, -- Don't lazy load - recommended by the plugin
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    { "<leader>e", "<cmd>Oil<cr>", desc = "Open file explorer" },
    { "<leader>E", "<cmd>Oil --float<cr>", desc = "Open file explorer (float)" },
  },
  opts = {
    -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
    default_file_explorer = true,

    -- Columns to display
    -- Id is automatically added at the beginning, and name at the end
    columns = {
      "icon",
      -- "permissions",
      -- "size",
      -- "mtime",
    },

    -- Skip confirmation for simple operations
    skip_confirm_for_simple_edits = false,

    -- Prompt to save changes when selecting a new entry
    prompt_save_on_select_new_entry = true,

    -- Constrain cursor to editable parts of the buffer
    constrain_cursor = "editable",

    -- Watch filesystem for changes and reload oil
    watch_for_changes = false,

    -- Keymaps in oil buffer
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open in vertical split" },
      ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open in horizontal split" },
      ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open in new tab" },
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-l>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = "CD to current directory (tab)" },
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\"] = "actions.toggle_trash",
    },

    use_default_keymaps = true,

    view_options = {
      -- Show files and directories that start with "."
      show_hidden = false,

      -- Sort file names with numbers intuitively
      natural_order = "fast",

      -- Case insensitive sorting
      case_insensitive = false,

      sort = {
        { "type", "asc" },
        { "name", "asc" },
      },
    },

    -- Configuration for floating window
    float = {
      padding = 2,
      max_width = 90,
      max_height = 30,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
    },

    -- Configuration for preview window
    preview_win = {
      update_on_cursor_moved = true,
      preview_method = "fast_scratch",
      win_options = {},
    },

    -- Configuration for confirmation window
    confirmation = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      max_height = 0.9,
      min_height = { 5, 0.1 },
      border = "rounded",
    },

    -- Configuration for progress window
    progress = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      max_height = { 10, 0.9 },
      min_height = { 5, 0.1 },
      border = "rounded",
      minimized_border = "none",
    },
  },
}
