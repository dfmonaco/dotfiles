return {
  "saghen/blink.cmp",
  version = "1.*",
  opts = {
    sources = {
      -- adding any nvim-cmp sources here will enable them
      -- with blink.compat
      compat = {},
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        buffer = {
          opts = {
            -- Autocomplete from all open buffers
            get_bufnrs = function()
              return vim.tbl_filter(function(bufnr)
                return vim.bo[bufnr].buftype == ""
              end, vim.api.nvim_list_bufs())
            end,
          },
        },
      },
    },
    -- Borders
    completion = {
      menu = { border = "single" },
      documentation = { window = { border = "single" } },
    },
    signature = { window = { border = "single" } },
    keymap = {
      preset = "super-tab",
      ["<C-y>"] = { "select_and_accept" },
    },
  },
}
