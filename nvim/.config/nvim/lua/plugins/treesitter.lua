-- Treesitter for better syntax highlighting and code understanding
-- https://github.com/nvim-treesitter/nvim-treesitter
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- Automatically update parsers after install/update
    event = { "BufReadPost", "BufNewFile" }, -- Load on buffer read
    opts = {
      -- A list of parser names, or "all" (parsers MUST always be installed)
      ensure_installed = {
        "bash",
        "c",
        "css",
        "html",
        "javascript",
        "json",
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

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      highlight = {
        enable = true, -- Enable Tree-sitter based highlighting

        -- NOTE: these are the names of the parsers and not the filetype
        -- List of languages that will be disabled
        -- disable = { "c", "rust" },

        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = true,
      },

      -- Indentation based on treesitter for the = operator (experimental)
      indent = {
        enable = false, -- Disabled by default as it's experimental
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
