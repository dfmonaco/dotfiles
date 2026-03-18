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
--          `asdf where nodejs` also picks up the project-local version, so
--          it points at the wrong install dir in projects with a different
--          nodejs version (e.g. 24.12.0 instead of 24.13.0).
-- Fix:     Read the global nodejs version from ~/.tool-versions and build
--          the absolute path from that, ignoring any project-local version.
--
-- Update: npm install -g @herb-tools/language-server
-- Verify: which herb-language-server  → ~/.asdf/shims/herb-language-server
--
-- HEADS-UP: If you upgrade the global Node.js version (asdf global nodejs <ver>),
--           reinstall the package: npm install -g @herb-tools/language-server
--           Then restart Neovim so the path below resolves to the new version.

-- Read the global nodejs version from ~/.tool-versions (not project-local).
-- `asdf where nodejs` would pick up the project's version instead.
local global_node_version = vim.fn.trim(vim.fn.system("grep '^nodejs' ~/.tool-versions | awk '{print $2}'"))
local herb_ls_bin = vim.fn.expand("~/.asdf/installs/nodejs/") .. global_node_version .. "/bin/herb-language-server"

vim.lsp.config("herb_ls", {
  -- Absolute path to global nodejs install bypasses the asdf shim entirely.
  -- Using ~/.tool-versions ensures we always use the global version, not the
  -- project-local one (which may differ and not have the package installed).
  cmd = { herb_ls_bin, "--stdio" },
})

-- Enabled via init.lua with: vim.lsp.enable("herb_ls")
