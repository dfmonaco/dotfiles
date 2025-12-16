-- Treesitter for better syntax highlighting and code understanding
-- https://github.com/nvim-treesitter/nvim-treesitter
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- Automatically update parsers after install/update
    event = { "BufReadPost", "BufNewFile" }, -- Load on buffer read

    config = function()
      -- Setup nvim-treesitter using the configs module (current stable API)
      require("nvim-treesitter.configs").setup({
        -- A list of parser names that should always be installed
        ensure_installed = {
          "bash",
          "c",
          "css",
          "html",
          "javascript",
          "json", -- JSON parser (works for tsconfig.json even with comments)
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "query", -- Tree-sitter query language
          "regex",
          "ruby",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },

        -- Install parsers synchronously (only applied to ensure_installed)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Disabled to avoid problematic auto-downloads of jsonc
        auto_install = false,

        -- Highlighting configuration
        highlight = {
          enable = true, -- Enable Tree-sitter based highlighting

          -- Disable for large files (performance optimization)
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,

          -- Set to false to use only treesitter highlighting
          -- Set to true or list of languages to use both treesitter and vim regex
          additional_vim_regex_highlighting = false,
        },

        -- Indentation based on treesitter (experimental, disabled by default)
        indent = {
          enable = false,
        },
      })

      -- Enable treesitter-based folding (optional, per-filetype)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "javascript",
          "typescript",
          "lua",
          "python",
          "ruby",
        },
        callback = function()
          vim.wo[0][0].foldmethod = "expr"
          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo[0][0].foldenable = false -- Don't fold by default
        end,
      })
    end,
  },
}
