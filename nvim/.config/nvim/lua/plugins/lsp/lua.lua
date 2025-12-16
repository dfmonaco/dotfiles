-- Lua Language Server Configuration
-- Install: sudo pacman -S lua-language-server
--
-- Custom settings for Neovim development:
-- - Uses LuaJIT runtime (Neovim's Lua interpreter)
-- - Includes Neovim runtime library for completions
-- - Recognizes 'vim' as a global variable

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
      diagnostics = { globals = { "vim" } },
    },
  },
})
