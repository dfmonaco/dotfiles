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
-- Problem: The asdf shim for herb-language-server calls `asdf exec` which
--          requires a nodejs version to be set in the project's .tool-versions.
--          Projects without nodejs in .tool-versions fail with exit code 126.
-- Fix:     Prepend the asdf nodejs bin dir to PATH so the real binary is found
--          directly, bypassing the shim's version lookup entirely.
--
-- Update: npm install -g @herb-tools/language-server
-- Verify: which herb-language-server  → ~/.asdf/shims/herb-language-server

-- Resolve the asdf nodejs install path at startup to build a stable PATH.
-- `asdf where nodejs` returns the install dir for the current global version.
local asdf_nodejs_bin = vim.fn.trim(vim.fn.system("asdf where nodejs")) .. "/bin"

vim.lsp.config("herb_ls", {
  cmd_env = {
    -- Prepend the real nodejs bin dir so herb-language-server is found
    -- without going through the asdf shim (which requires .tool-versions)
    PATH = asdf_nodejs_bin .. ":" .. vim.env.PATH,
  },
})

-- Enabled via init.lua with: vim.lsp.enable("herb_ls")
