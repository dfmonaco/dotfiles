-- Markdown preview with Mermaid diagram support
-- https://github.com/iamcco/markdown-preview.nvim
return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = function()
    require("lazy").load({ plugins = { "markdown-preview.nvim" } })
    vim.fn["mkdp#util#install"]()
  end,
  keys = {
    {
      "<leader>mp",
      ft = "markdown",
      "<cmd>MarkdownPreviewToggle<cr>",
      desc = "Markdown Preview",
    },
  },
  config = function()
    vim.cmd([[do FileType]])

    -- Keep preview open when switching away from markdown buffer
    vim.g.mkdp_auto_close = 0

    -- Use GitHub Dark theme for syntax highlighting
    local config_path = vim.fn.stdpath("config")
    vim.g.mkdp_highlight_css = config_path .. "/css/github-dark.css"

    -- Set dark theme by default
    vim.g.mkdp_theme = "dark"

    -- Debug: print the path being used
    print("mkdp_highlight_css set to: " .. vim.g.mkdp_highlight_css)
  end,
}
