-- Use JSON treesitter parser for JSONC files
-- This avoids the problematic jsonc parser while still getting syntax highlighting
vim.treesitter.language.register('json', 'jsonc')
