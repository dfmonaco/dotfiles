return {
  "github/copilot.vim",
  event = "InsertEnter", -- Lazy load when entering insert mode
  config = function()
    -- Use default Tab key to accept suggestions
    -- Other default keybindings:
    --   <M-]> - Next suggestion
    --   <M-[> - Previous suggestion
    --   <C-]> - Dismiss suggestion
    
    -- Optional: Configure Copilot settings
    -- vim.g.copilot_no_tab_map = false -- Use Tab (default)
    -- vim.g.copilot_assume_mapped = false
    -- vim.g.copilot_filetypes = { ["*"] = true } -- Enable for all filetypes
  end,
}
