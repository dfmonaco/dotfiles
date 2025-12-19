-- TypeScript/JavaScript Language Server Configuration
-- Installation (Priority Order):
--   1. System (Recommended): sudo pacman -S typescript-language-server
--   2. Global via npm: npm install -g typescript-language-server
--
-- Installed via: pacman
-- Command used: typescript-language-server --stdio
-- Strategy: System-only (LSP server)
--
-- Provides LSP for:
-- - TypeScript (.ts, .tsx)
-- - JavaScript (.js, .jsx)
--
-- Note: TypeScript compiler can be installed separately if needed:
--   - System: sudo pacman -S typescript
--   - Global: npm install -g typescript (via asdf nodejs)
--   - Per-project: Already in node_modules (most common)
--
-- Note: For Svelte projects, also enable svelte LSP for .svelte files
-- Note: Uses ts_ls (modern name, formerly tsserver)
-- Note: Formatting is handled by Prettier via conform.nvim, not by this LSP.
--       Install Prettier with: sudo pacman -S prettier

-- Inlay hints configuration
-- Toggle with <leader>ci (defined in init.lua)
vim.lsp.config("ts_ls", {
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = false,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = false,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
	},
})

-- Enabled via init.lua with: vim.lsp.enable("ts_ls")
