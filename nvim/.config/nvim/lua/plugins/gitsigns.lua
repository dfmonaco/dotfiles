-- Gitsigns: Git integration for buffers
-- https://github.com/lewis6991/gitsigns.nvim
-- Version: v2.0.0

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },

  -- Global keymaps (always available, even without hunks)
  keys = {
    {
      "<leader>hD",
      function()
        require('gitsigns').change_base('develop', true)
        vim.g.gitsigns_base = 'develop'
        require('snacks').notify.info("Changed base to: develop (global)")
      end,
      desc = "Change base to develop"
    },
    {
      "<leader>h1",
      function()
        require('gitsigns').change_base('HEAD^', true)
        vim.g.gitsigns_base = 'HEAD^'
        require('snacks').notify.info("Changed base to: HEAD^ (global)")
      end,
      desc = "Change base to HEAD^"
    },
    {
      "<leader>h0",
      function()
        require('gitsigns').reset_base(true)
        vim.g.gitsigns_base = nil
        require('snacks').notify.info("Reset base to index (global)")
      end,
      desc = "Reset base to index"
    },
    {
      "<leader>hQ",
      function()
        require('gitsigns').setqflist('all')
      end,
      desc = "Quickfix list all hunks"
    },
  },
  opts = {
    signs                        = {
      add          = { text = '┃' },
      change       = { text = '┃' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
    signs_staged                 = {
      add          = { text = '┃' },
      change       = { text = '┃' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
    signs_staged_enable          = true,
    signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir                 = {
      follow_files = true
    },
    auto_attach                  = true,
    attach_to_untracked          = false,
    current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts      = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 100,
      use_focus = true,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    sign_priority                = 6,
    update_debounce              = 100,
    status_formatter             = nil, -- Use default
    max_file_length              = 40000, -- Disable if file is longer than this (in lines)
    preview_config               = {
      -- Options passed to nvim_open_win
      border = 'rounded',
      style = 'minimal',
      relative = 'editor',
      row = math.floor(vim.o.lines * 0.2),
      col = math.floor(vim.o.columns * 0.2),
      width = math.floor(vim.o.columns * 0.6),
    },
    -- Keymaps setup function
    on_attach                    = function(bufnr)
      local gitsigns = require('gitsigns')

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation - all hunks
      map('n', '<C-n>', function()
        if vim.wo.diff then
          vim.cmd.normal({ ']c', bang = true })
        else
          gitsigns.nav_hunk('next', { target = 'all' })
        end
      end, { desc = 'Next git hunk (all)' })

      map('n', '<C-p>', function()
        if vim.wo.diff then
          vim.cmd.normal({ '[c', bang = true })
        else
          gitsigns.nav_hunk('prev', { target = 'all' })
        end
      end, { desc = 'Previous git hunk (all)' })

      map('n', '<C-h>', gitsigns.preview_hunk, { desc = 'Preview hunk (popup window)' })

      -- Actions
      map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Stage hunk' })
      map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Reset hunk' })

      map('v', '<leader>hs', function()
        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, { desc = 'Stage hunk' })

      map('v', '<leader>hr', function()
        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, { desc = 'Reset hunk' })

      map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Stage buffer' })
      map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Reset buffer' })
      map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Preview hunk' })
      map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'Preview hunk inline' })

      map('n', '<leader>hb', function()
        gitsigns.blame_line({ full = true })
      end, { desc = 'Blame line' })

      map('n', '<leader>hd', gitsigns.diffthis, { desc = 'Diff this' })

      map('n', '<leader>hv', function()
        gitsigns.diffthis('~')
      end, { desc = 'Diff this ~ (split view)' })

      map('n', '<leader>hq', gitsigns.setqflist, { desc = 'Quickfix list (buffer)' })

      -- Toggles
      map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Toggle git blame' })
      map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = 'Toggle word diff' })

      -- Text object
      map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = 'Select hunk' })
    end
  },
}
