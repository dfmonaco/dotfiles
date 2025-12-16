-- Ruby Language Server Configuration
-- Installation (Priority Order):
--   1. asdf Ruby (Recommended):
--      asdf install ruby 3.2.9
--      asdf set ruby 3.2.9 --home
--      gem install ruby-lsp
--   2. Per-project: Add 'ruby-lsp' to Gemfile
--
-- Installed via: asdf + gem (global) or bundler (per-project)
-- Command used: Dynamic (bundle exec ruby-lsp OR ruby-lsp)
-- Strategy: Hybrid with runtime detection (per-project + global fallback)
--
-- Detection logic:
--   1. If Gemfile.lock exists AND contains ruby-lsp → bundle exec ruby-lsp
--   2. Otherwise → ruby-lsp (global gem via asdf)
--
-- This ensures:
-- - Project gems match the project's Ruby version and dependencies
-- - Global fallback works for Ruby files outside projects
-- - asdf manages Ruby versions consistently

-- Configure ruby_lsp with PATH environment (for asdf shims)
vim.lsp.config("ruby_lsp", {
  cmd_env = {
    PATH = vim.env.PATH,
  },
})

-- Manual start with FileType autocmd for runtime command detection
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function(args)
    -- Determine ruby-lsp command based on Gemfile.lock presence
    local cmd
    local gemfile_lock = vim.fn.filereadable("Gemfile.lock") == 1

    if gemfile_lock then
      -- Check if ruby-lsp is in Gemfile.lock
      local lockfile = vim.fn.readfile("Gemfile.lock")
      local has_ruby_lsp = false
      for _, line in ipairs(lockfile) do
        if line:match("^%s*ruby%-lsp") then
          has_ruby_lsp = true
          break
        end
      end

      if has_ruby_lsp then
        cmd = { "bundle", "exec", "ruby-lsp" }
      else
        cmd = { "ruby-lsp" }
      end
    else
      cmd = { "ruby-lsp" }
    end

    -- Find root directory
    local root_dir = vim.fs.root(args.buf, { "Gemfile", ".git" })

    -- Start LSP client
    vim.lsp.start({
      name = "ruby_lsp",
      cmd = cmd,
      root_dir = root_dir,
    })
  end,
})
