-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "css", "javascript", "ruby", "sql" },
  callback = function()
    vim.opt_local.keywordprg = "sh -c 'xdg-open \"https://devdocs.io/search?q= \"$1' _"
  end,
})


vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.md",
  callback = function()
    vim.opt_local.textwidth = 80
  end,
})
