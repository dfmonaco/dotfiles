-- ERB/HTML Language Server Configuration (Herb)
-- Installation (Priority Order):
--   1. System (pacman): NOT available in pacman/AUR
--   2. Global via npm (Recommended): npm install -g @herb-tools/language-server
--   3. Per-project: npx @herb-tools/language-server
--
-- Installed via: npm (asdf nodejs 24.13.0)
-- Command used: herb-language-server --stdio
-- Strategy: Global npm install via asdf-managed Node.js
--
-- Provides LSP for:
--   - ERB templates (.erb, .html.erb)
--   - HTML+ERB structure, diagnostics, and completions
--
-- Note: ruby_lsp also attaches to .erb files for Ruby semantics.
--       Both servers run concurrently — this is intentional and correct.
--       herb_ls handles HTML+ERB structure; ruby_lsp handles Ruby code.
--
-- Problem: The asdf shim calls `asdf exec` which requires nodejs in the
--          project's .tool-versions. Projects without it fail with exit 126.
--          cmd_env.PATH does NOT help because Neovim resolves the `cmd`
--          binary using its own process PATH before cmd_env is applied.
-- Fix:     Use an absolute path in `cmd` so the shim is never invoked.
--
-- Update: npm install -g @herb-tools/language-server
-- Verify: which herb-language-server  → ~/.asdf/shims/herb-language-server
--
-- HEADS-UP: If you upgrade the global Node.js version (asdf global nodejs <ver>),
--           reinstall the package: npm install -g @herb-tools/language-server
--           Then restart Neovim so `asdf where nodejs` resolves the new path.

-- Resolve absolute path to the binary at startup via `asdf where nodejs`.
-- This avoids the asdf shim entirely for command resolution.
local asdf_nodejs_bin = vim.fn.trim(vim.fn.system("asdf where nodejs")) .. "/bin"
local herb_ls_bin = asdf_nodejs_bin .. "/herb-language-server"

vim.lsp.config("herb_ls", {
  -- Absolute path bypasses the asdf shim (cmd_env.PATH is applied after
  -- Neovim resolves the command, so it cannot fix shim lookup failures).
  cmd = { herb_ls_bin, "--stdio" },
})

-- Enabled via init.lua with: vim.lsp.enable("herb_ls")
