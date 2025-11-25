return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- Input: Better vim.ui.input (replaces dressing.nvim)
    input = { enabled = true },
    
    -- Indent: Visual indent guides (replaces indent-blankline.nvim)
    indent = {
      enabled = true,
      char = "┊",
      scope = { enabled = false },
    },
    
    -- Notifier: Pretty notifications (replaces nvim-notify)
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    
    -- Bigfile: Handle large files efficiently
    bigfile = { enabled = true },
    
    -- Quickfile: Fast file rendering
    quickfile = { enabled = true },
  },
  keys = {
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History" },
  },
}
