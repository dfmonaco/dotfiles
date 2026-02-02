-- Gitsigns: Git integration for buffers
-- https://github.com/lewis6991/gitsigns.nvim
-- Version: v2.0.0

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },

  -- Helper function for git modified files picker
  config = function(_, opts)
    -- Define the helper function
    local function show_git_modified_files(base_ref, title_suffix)
      local gitsigns = require('gitsigns')
      local Snacks = require('snacks')

      -- Change gitsigns base
      if base_ref == nil then
        gitsigns.reset_base(true)
        vim.g.gitsigns_base = nil
      else
        gitsigns.change_base(base_ref, true)
        vim.g.gitsigns_base = base_ref
      end

      -- Get modified files from git
      local files = {}
      
      if base_ref == nil then
        -- For working tree: combine unstaged + staged + untracked
        -- 1. Unstaged changes
        local unstaged = vim.fn.systemlist('git diff --name-only')
        if vim.v.shell_error == 0 then
          vim.list_extend(files, unstaged)
        end
        
        -- 2. Staged changes
        local staged = vim.fn.systemlist('git diff --cached --name-only')
        if vim.v.shell_error == 0 then
          vim.list_extend(files, staged)
        end
        
        -- 3. Untracked files
        local untracked = vim.fn.systemlist('git ls-files --others --exclude-standard')
        if vim.v.shell_error == 0 then
          vim.list_extend(files, untracked)
        end
        
        -- Remove duplicates (file can be in both unstaged and staged if partially staged)
        local seen = {}
        local unique_files = {}
        for _, file in ipairs(files) do
          if not seen[file] then
            seen[file] = true
            table.insert(unique_files, file)
          end
        end
        files = unique_files
      else
        -- For other bases: just show diff
        local cmd = 'git diff --name-only ' .. base_ref
        files = vim.fn.systemlist(cmd)
        
        if vim.v.shell_error ~= 0 then
          Snacks.notify.error("Git command failed: " .. cmd)
          return
        end
      end

      if #files == 0 then
        Snacks.notify.info("No modified files " .. title_suffix)
        return
      end

      -- Convert to Snacks picker items
      local items = {}
      for _, file in ipairs(files) do
        table.insert(items, {
          file = file,
          text = file,
        })
      end

      -- Open Snacks picker
      Snacks.picker.pick({
        source = "git_modified",
        title = "Modified files " .. title_suffix,
        items = items,
      })
    end

    -- Store the function globally so keymaps can access it
    _G._show_git_modified_files = show_git_modified_files

    -- Apply gitsigns config
    require('gitsigns').setup(opts)
  end,

  -- Global keymaps (always available, even without hunks)
  keys = {
    {
      "<leader>gD",
      function() _G._show_git_modified_files('develop', 'vs develop') end,
      desc = "Modified files vs develop"
    },
    {
      "<leader>g1",
      function() _G._show_git_modified_files('HEAD^', 'vs HEAD^') end,
      desc = "Modified files vs HEAD^"
    },
    {
      "<leader>gf",
      function() _G._show_git_modified_files(nil, '(working tree)') end,
      desc = "Modified files (working tree)"
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
