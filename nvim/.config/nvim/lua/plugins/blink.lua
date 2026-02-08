-- Completion Engine - blink.cmp
-- https://github.com/saghen/blink.cmp
-- Modern, performant completion plugin with built-in fuzzy matching

return {
  "saghen/blink.cmp",
  version = "1.*", -- Use release tag for pre-built binaries
  
  dependencies = {
    -- Spell checker: corrections for misspelled words
    "ribru17/blink-cmp-spell",
  },
  
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- Keymap: Tab + C-j/C-k navigation (arrow keys reserved for Copilot)
    keymap = {
      preset = "default",
      ["<Tab>"] = { "select_and_accept" },
      ["<C-j>"] = { "select_next" },
      ["<C-k>"] = { "select_prev" },
      -- Disable arrow keys (used by Copilot instead)
      ["<Up>"] = {},
      ["<Down>"] = {},
    },

    -- Completion menu and documentation appearance
    completion = {
      menu = {
        border = "rounded",
        
        draw = {
          -- Column layout: [kind_icon] [label + description] [source_icon]
          columns = { 
            { 'kind_icon' },
            { 'label', 'label_description', gap = 1 },
            { 'source_icon' }
          },
          
          components = {
            -- Source icon: Shows which source provided each completion
            -- Icons: 󰘧=LSP 󰓆=Spell 󰉋=Path 󰈙=Buffer
            -- Color-coded: Blue=LSP Yellow=Spell Cyan=Path Orange=Buffer
            source_icon = {
              width = { max = 8 },
              
              text = function(ctx)
                local icons = {
                  lsp = '󰘧',
                  spell = '󰓆',
                  path = '󰉋',
                  buffer = '󰈙',
                }
                local names = {
                  lsp = 'LSP',
                  spell = 'Spell',
                  path = 'Path',
                  buffer = 'Buf',
                }
                
                local icon = icons[ctx.source_id] or ''
                local name = names[ctx.source_id] or ctx.source_name
                
                return icon .. ' ' .. name
              end,
              
              highlight = function(ctx)
                -- Use built-in diagnostic highlights for color-coding
                local hl_map = {
                  lsp = 'DiagnosticInfo',      -- Blue
                  spell = 'DiagnosticWarn',     -- Yellow
                  path = 'DiagnosticHint',      -- Cyan
                  buffer = 'DiagnosticError',   -- Orange
                }
                return hl_map[ctx.source_id] or 'BlinkCmpSource'
              end,
            },
          },
        },
      },
      
      -- Documentation: show after 1 second pause (helpful for learning APIs)
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 1000,
        window = {
          border = "rounded",
        },
      },
    },

    -- Sources: LSP, buffer, path, spell checker
    sources = {
      default = { "lsp", "buffer", "path", "spell" },
      
      providers = {
        -- Spell checker: corrections for misspelled words
        spell = {
          module = "blink-cmp-spell",
          name = "Spell",
          -- Enable in markdown, text files, and comments
          enabled = function()
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
            -- Autocomplete from valid, loaded buffers only (including terminals)
            -- This filtering prevents blink from crashing on invalid buffers
            get_bufnrs = function()
              local bufs = {}
              for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) then
                  local buftype = vim.api.nvim_get_option_value('buftype', { buf = buf })
                  -- Include normal file buffers AND terminal buffers
                  if buftype == "" or buftype == "terminal" then
                    table.insert(bufs, buf)
                  end
                end
              end
              return bufs
            end,
          },
        },
      },
    },

    -- Command-line completion with fuzzy matching
    cmdline = {
      enabled = true,
      keymap = {
        preset = "default",
        -- Tab to accept completion (same as insert mode)
        ["<Tab>"] = { "select_and_accept" },
      },
    },
  },
  opts_extend = { "sources.default" },
}
