-- Completion Engine - blink.cmp
-- https://github.com/saghen/blink.cmp
-- Modern, performant completion plugin with built-in fuzzy matching

return {
  "saghen/blink.cmp",
  version = "1.*", -- Use release tag for pre-built binaries
  
  dependencies = {
    -- Dictionary completion: comprehensive English word suggestions
    {
      "Kaiser-Yang/blink-cmp-dictionary",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    -- Spell checker: corrections for misspelled words
    "ribru17/blink-cmp-spell",
  },
  
  -- Setup function to configure highlight groups with Catppuccin colors
  config = function()
    -- Get Catppuccin color palette (works with all flavors: mocha, latte, frappe, macchiato)
    local colors = require('catppuccin.palettes').get_palette()
    
    -- Define custom highlight groups for source identification
    -- Each source gets a unique color for quick visual recognition
    vim.api.nvim_set_hl(0, 'BlinkCmpSourceLSP', { 
      fg = colors.blue,      -- Blue for LSP (code intelligence)
      bold = true 
    })
    vim.api.nvim_set_hl(0, 'BlinkCmpSourceDict', { 
      fg = colors.green,     -- Green for Dictionary (comprehensive words)
      bold = true 
    })
    vim.api.nvim_set_hl(0, 'BlinkCmpSourceSpell', { 
      fg = colors.yellow,    -- Yellow for Spell (corrections/warnings)
      bold = true 
    })
    vim.api.nvim_set_hl(0, 'BlinkCmpSourcePath', { 
      fg = colors.teal,      -- Cyan/Teal for Path (file system)
      bold = true 
    })
    vim.api.nvim_set_hl(0, 'BlinkCmpSourceBuffer', { 
      fg = colors.overlay0   -- Gray for Buffer (lower priority, not bold)
    })
    
    -- Setup blink.cmp with configuration
    require('blink.cmp').setup(require('blink.cmp').get_config())
  end,
  
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- Keymap preset with enhanced accept options
    keymap = {
      preset = "default",
      ["<Tab>"] = { "select_and_accept" }, -- Accept with Tab (or first if none selected)
    },

    appearance = {
      -- 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      nerd_font_variant = "mono",
    },

    -- Completion menu and documentation appearance
    completion = {
      menu = {
        border = "rounded", -- Rounded border (matches documentation window)
        
        -- Menu drawing configuration: controls how completion items are displayed
        draw = {
          -- Column layout: [kind_icon] [label + description] [source_icon + name]
          -- This creates a three-column layout for better visual organization
          columns = { 
            { 'kind_icon' },                           -- Left: Type icon (function, variable, etc.)
            { 'label', 'label_description', gap = 1 }, -- Middle: The actual completion text
            { 'source_icon' }                          -- Right: Source identifier (NEW!)
          },
          
          -- Component definitions
          components = {
            -- Custom component: source_icon
            -- Displays an icon + short name for each completion source
            -- This helps you instantly identify where each suggestion comes from
            source_icon = {
              width = { max = 8 },  -- Max width: "󰓆 Dict" = 7 chars + padding
              
              -- Text function: returns the icon + name for each source
              text = function(ctx)
                -- Icon mapping for each source
                local icons = {
                  lsp = '󰘧',        -- Lightbulb icon for LSP
                  dictionary = '󰓆', -- Book icon for Dictionary
                  spell = '',      -- Spell check icon
                  path = '󰉋',       -- Folder icon for Path
                  buffer = '󰈙',     -- File icon for Buffer
                }
                
                -- Short name mapping for compact display
                local names = {
                  lsp = 'LSP',
                  dictionary = 'Dict',
                  spell = 'Spell',
                  path = 'Path',
                  buffer = 'Buf',
                }
                
                -- Get icon and name, with fallback for unknown sources
                local icon = icons[ctx.source_id] or ''
                local name = names[ctx.source_id] or ctx.source_name
                
                return icon .. ' ' .. name
              end,
              
              -- Highlight function: applies color-coding to each source
              -- Uses the custom highlight groups defined in config function
              highlight = function(ctx)
                local hl_map = {
                  lsp = 'BlinkCmpSourceLSP',        -- Blue
                  dictionary = 'BlinkCmpSourceDict', -- Green
                  spell = 'BlinkCmpSourceSpell',     -- Yellow
                  path = 'BlinkCmpSourcePath',       -- Cyan/Teal
                  buffer = 'BlinkCmpSourceBuffer',   -- Gray
                }
                return hl_map[ctx.source_id] or 'BlinkCmpSource'
              end,
            },
          },
        },
      },
      
      documentation = {
        auto_show = true,        -- Show documentation automatically after delay
        auto_show_delay_ms = 1000, -- 1 second delay (only shows when pausing on item)
        update_delay_ms = 50,    -- Quick updates when switching items
        window = {
          border = "rounded",
        },
      },
      
      -- Auto-brackets: automatically insert brackets for functions/methods
      -- Uses LSP semantic tokens to intelligently determine when brackets are needed
      -- Works alongside nvim-autopairs (autopairs handles manual typing, this handles completions)
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      
      -- Ghost text: inline preview of selected completion (consistent with cmdline)
      ghost_text = {
        enabled = true,
      },
    },

    -- Signature help: disabled to avoid window clutter
    signature = {
      enabled = false,
    },

    -- Sources: LSP, path, dictionary, spell checker, buffer (from all open buffers)
    sources = {
      -- Priority order: LSP > path > dictionary > spell > buffer
      default = { "lsp", "path", "dictionary", "spell", "buffer" },
      
      -- Provider-specific configuration
      providers = {
        -- Dictionary: comprehensive English word completion (370k+ words)
        dictionary = {
          module = "blink-cmp-dictionary",
          name = "Dict",
          -- Minimum 2 characters to trigger (prevents spam on single letters)
          min_keyword_length = 2,
          -- Limit results for better performance
          max_items = 10,
          opts = {
            -- Path to dictionary file (370k+ English words)
            dictionary_files = { vim.fn.expand("~/.config/nvim/dictionary/english.txt") },
            -- Smart capitalization: matches your typing style
            -- "Word" if you type "W", "WORD" if you type "WO", "word" otherwise
            capitalize_first = nil, -- Auto-detect from input
            capitalize_whole_word = nil, -- Auto-detect from input
          },
        },
        
        -- Spell checker: corrections for misspelled words
        spell = {
          module = "blink-cmp-spell",
          name = "Spell",
          -- Only show spell suggestions in specific contexts
          enabled = function()
            -- Enable in markdown, text files, and comments
            local ft = vim.bo.filetype
            if ft == "markdown" or ft == "text" then
              return true
            end
            -- Also enable in code comments (when spell is enabled)
            return vim.opt.spell:get()
          end,
          opts = {
            max_entries = 5,
            preselect_current_word = true,
            keep_all_entries = false,
          },
        },
        
        buffer = {
          opts = {
            -- Autocomplete from all open buffers (not just current)
            -- Filters out special buffers (terminals, quickfix, etc.)
            get_bufnrs = function()
              return vim.tbl_filter(function(bufnr)
                -- Only include normal buffers (files)
                return vim.bo[bufnr].buftype == ""
              end, vim.api.nvim_list_bufs())
            end,
          },
        },
      },
    },

    -- Use Rust fuzzy matcher (falls back to Lua if Rust unavailable)
    fuzzy = { implementation = "prefer_rust_with_warning" },

    -- Command-line completion with fuzzy matching
    -- Provides typo-resistant completions for :commands, file paths, options, etc.
    cmdline = {
      enabled = true,
      -- Use same keymaps as insert mode for consistency
      -- <Tab> = accept, <C-n>/<C-p> = navigate, <C-e> = cancel
      keymap = {
        preset = "default",
        -- Override Tab to match insert mode behavior exactly
        ["<Tab>"] = { "select_and_accept" },
      },
      sources = { "cmdline", "buffer" }, -- Command completion + buffer text
      
      completion = {
        -- Auto-show completions as you type
        menu = { auto_show = true },
        
        -- Selection behavior (same as insert mode)
        list = {
          selection = {
            preselect = true,    -- Auto-select first item
            auto_insert = true,  -- Insert selection automatically
          },
        },
        
        -- Show preview of selected item inline (like fish shell)
        ghost_text = { enabled = true },
      },
    },
  },
  opts_extend = { "sources.default" },
}
