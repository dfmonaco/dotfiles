-- Ruby Language Server Configuration
-- Installation (Priority Order):
--   1. asdf-managed Ruby gems (Recommended): gem install ruby-lsp
--   2. Per-project: Add 'ruby-lsp' to Gemfile
--   3. System fallback: sudo pacman -S ruby-lsp
--
-- Installed via: asdf Ruby (3.4.8, 3.2.9, 3.2.0) + system fallback
-- Command used: Dynamic (bundle exec ruby-lsp OR ruby-lsp via asdf shim)
-- Strategy: asdf with per-project override support
--
-- Detection logic:
--   1. If Gemfile.lock exists AND contains ruby-lsp → bundle exec ruby-lsp
--   2. Otherwise → ruby-lsp (asdf shim, uses project's Ruby version)
--
-- This ensures:
--   - Works with any asdf-managed Ruby version automatically
--   - Project-specific versions when needed (bundle exec)
--   - Works for standalone Ruby files (asdf global Ruby)
--   - Proper integration with asdf PATH and shims
--
-- Note: Ruby versions managed via asdf, ruby-lsp installed per Ruby version

-- Manual start with FileType autocmd for runtime command detection
-- cmd_env is passed directly to vim.lsp.start() so it is not lost;
-- vim.lsp.config() settings are NOT automatically merged into vim.lsp.start() calls.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "ruby", "eruby", "eruby.html" },
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

      cmd = has_ruby_lsp and { "bundle", "exec", "ruby-lsp" } or { "ruby-lsp" }
    else
      cmd = { "ruby-lsp" }
    end

    -- Find root directory
    local root_dir = vim.fs.root(args.buf, { "Gemfile", ".git" })

    -- Start LSP client with asdf shims in PATH for correct Ruby version detection
    vim.lsp.start({
      name = "ruby_lsp",
      cmd = cmd,
      root_dir = root_dir,
      cmd_env = {
        PATH = vim.fn.expand("~/.asdf/shims") .. ":" .. vim.env.PATH,
      },
    })
  end,
})
