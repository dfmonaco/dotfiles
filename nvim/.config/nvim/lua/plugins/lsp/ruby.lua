-- Ruby Language Server Configuration
-- Installation (Priority Order):
--   1. System (Recommended): sudo pacman -S ruby-lsp
--   2. Global via gem: gem install ruby-lsp
--   3. Per-project: Add 'ruby-lsp' to Gemfile
--
-- Installed via: pacman (system)
-- Command used: Dynamic (bundle exec ruby-lsp OR ruby-lsp)
-- Strategy: System with per-project override support
--
-- Detection logic:
--   1. If Gemfile.lock exists AND contains ruby-lsp → bundle exec ruby-lsp
--   2. Otherwise → ruby-lsp (system binary)
--
-- This ensures:
--   - Consistent system-managed installation (pacman)
--   - Project-specific versions when needed (bundle exec)
--   - Works for standalone Ruby files (system fallback)
--
-- Note: Ruby version still managed via asdf, but ruby-lsp installed system-wide

-- Configure ruby_lsp with PATH environment
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
