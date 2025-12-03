return {
  "MagicDuck/grug-far.nvim",

  -- Lazy loading: load on command or keypress for optimal performance
  cmd = { "GrugFar" },
  keys = {
    {
      "<leader>sr",
      function()
        local grug = require("grug-far")
        local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
        grug.open({
          transient = true,
          prefills = {
            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
          },
        })
      end,
      mode = { "n", "x" },
      desc = "Search and Replace",
    },
  },

  config = function()
    require('grug-far').setup({
      -- UI options
      resultLocation = {
        -- Show number labels for quick navigation
        showNumberLabel = true,
      },

      -- Search options
      search = {
        -- Minimum characters before search triggers
        minSearchChars = 2,
        -- Debounce delay in ms
        debounceMs = 300,
      },

      -- Replace options
      replace = {
        -- Confirm before replacing with empty string
        confirmOnEmptyReplace = true,
      },

      -- Keybindings (customize as needed)
      keymaps = {
        -- Replace action
        replace = "<localleader>r",
        -- Open location
        open = "<localleader>o",
        -- Goto location
        goto = "<CR>",
        -- Close buffer
        close = "<localleader>c",
        -- Abort operation
        abort = "<localleader>a",
        -- Toggle show command
        toggleShowCommand = "<localleader>t",
        -- Swap engine
        swapEngine = "<localleader>e",
        -- History open
        historyOpen = "<localleader>h",
        -- Sync line
        syncLine = "<localleader>l",
        -- Sync all
        syncAll = "<localleader>s",
        -- Open next/prev
        openNext = "<down>",
        openPrev = "<up>",
        -- Preview
        preview = "<localleader>p",
        -- Quickfix
        qflist = "<localleader>f",
      },

      -- Transient buffer (unlisted, auto-deletes when closed)
      transient = true, -- default
    })
  end,
}
