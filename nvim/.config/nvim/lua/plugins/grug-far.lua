return {
  "MagicDuck/grug-far.nvim",
  
  -- Lazy loading: load on command or keypress for optimal performance
  cmd = { "GrugFar" },
  keys = {
    { "<leader>sr", "<cmd>GrugFar<cr>", desc = "Search and Replace" },
    { "<leader>sw", "<cmd>GrugFarWithin<cr>", desc = "Search within range" },
  },
  
  config = function()
    require('grug-far').setup({
      -- Search engines to enable (all by default)
      engines = {
        ripgrep = {
          -- Use ripgrep for fast regex search/replace
          -- enabled = true, -- default
        },
        astgrep = {
          -- Use ast-grep for structural search (optional, requires ast-grep CLI)
          -- enabled = true, -- default
        },
        ["astgrep-rules"] = {
          -- Use ast-grep with YAML rules for advanced patterns
          -- enabled = true, -- default
        },
      },
      
      -- UI options
      resultLocation = {
        -- Show number labels for quick navigation
        showNumberLabel = true,
      },
      
      -- History options
      history = {
        -- Auto-save history on successful operations
        autoSave = true,
        -- Max history entries
        maxEntries = 100,
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
        qflist = "<localleader>q",
      },
      
      -- Window options
      window = {
        -- Default window creation (vertical split)
        -- Can be overridden with command modifiers like :botright GrugFar
      },
      
      -- Icons (requires nvim-web-devicons or mini.icons)
      icons = {
        -- enabled = true, -- default
      },
      
      -- Transient buffer (unlisted, auto-deletes when closed)
      -- transient = false, -- default
      
      -- Instance naming for multiple buffers
      -- instanceName = nil, -- default
      
      -- Static title for buffer
      -- staticTitle = nil, -- default
      
      -- Visual selection usage
      -- visualSelectionUsage = "prefill-search", -- default: prefill search with selection
      -- Alternatives: "operate-within-range" for searching within selection
      
      -- Prefills for default values
      -- prefills = {},
      
      -- Custom result actions
      -- resultActions = {},
      
      -- Custom flags for engines
      -- flags = {},
      
      -- Buffer options
      -- bufferOptions = {},
      
      -- Filetype options
      -- filetypeOptions = {},
    })
  end,
}