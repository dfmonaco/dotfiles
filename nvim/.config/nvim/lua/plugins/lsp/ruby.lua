-- Ruby Language Server Configuration
-- Install:
--   Global:  gem install ruby-lsp
--   Project: Add 'ruby-lsp' to Gemfile
--
-- Strategy: Hybrid approach (per-project + global fallback)
-- - If Gemfile.lock exists AND contains ruby-lsp: use 'bundle exec ruby-lsp'
-- - Otherwise: use global 'ruby-lsp' command
--
-- This ensures:
-- - Project gems match the project's Ruby version and dependencies
-- - Global fallback works for Ruby files outside projects

-- Configure ruby_lsp with PATH environment (for rbenv shims)
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
