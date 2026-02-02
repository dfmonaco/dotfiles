return {
  "github/copilot.vim",
  event = "InsertEnter", -- Lazy load when entering insert mode
  config = function()
    -- Disable Copilot's default Tab mapping (Blink handles Tab)
    vim.g.copilot_no_tab_map = true
    
    -- Disable default assume_mapped to have full control over keybindings
    vim.g.copilot_assume_mapped = true
    
    -- ============================================================================
    -- COPILOT KEYMAPS: Arrow key navigation (insert mode only)
    -- ============================================================================
    -- Arrow keys provide intuitive directional control for Copilot suggestions
    --   →  Right  : Accept next word
    --   ↓  Down   : Accept next line
    --   ←  Left   : Dismiss suggestion
    --   ↑  Up     : Previous suggestion (cycle alternatives)
    -- ============================================================================
    
    -- Right arrow: Accept next word
    vim.keymap.set('i', '<Right>', 'copilot#AcceptWord()', {
      expr = true,
      replace_keycodes = false,
      desc = 'Copilot: Accept next word'
    })
    
    -- Down arrow: Accept next line
    vim.keymap.set('i', '<Down>', 'copilot#AcceptLine()', {
      expr = true,
      replace_keycodes = false,
      desc = 'Copilot: Accept next line'
    })
    
    -- Left arrow: Dismiss suggestion
    vim.keymap.set('i', '<Left>', function()
      vim.fn['copilot#Dismiss']()
      return ''
    end, {
      expr = true,
      replace_keycodes = false,
      desc = 'Copilot: Dismiss suggestion'
    })
    
    -- Up arrow: Previous suggestion (cycle alternatives)
    vim.keymap.set('i', '<Up>', function()
      vim.fn['copilot#Previous']()
      return ''
    end, {
      expr = true,
      replace_keycodes = false,
      desc = 'Copilot: Previous suggestion'
    })
    
    -- ============================================================================
    -- ADDITIONAL COPILOT CONTROLS
    -- ============================================================================
    
    -- <C-y>: Accept full suggestion
    -- Traditional Vim: "y = yes, accept"
    vim.keymap.set('i', '<C-y>', 'copilot#Accept("")', {
      expr = true,
      replace_keycodes = false,
      desc = 'Copilot: Accept full suggestion'
    })
    
    -- <C-\>: Manually trigger Copilot suggestion
    vim.keymap.set('i', '<C-\\>', function()
      vim.fn['copilot#Suggest']()
      return ''
    end, {
      expr = true,
      replace_keycodes = false,
      desc = 'Copilot: Manually request suggestion'
    })
    
    -- ============================================================================
    -- KEYMAP SUMMARY
    -- ============================================================================
    -- ARROW KEY NAVIGATION (insert mode):
    --   →  Right  : Accept next word
    --   ↓  Down   : Accept next line
    --   ←  Left   : Dismiss suggestion
    --   ↑  Up     : Previous suggestion
    --
    -- TRADITIONAL VIM CONTROLS:
    --   <C-y>     : Accept full suggestion
    --   <C-\>     : Manually request suggestion
    --
    -- NOTE: <Tab> is handled by Blink.cmp for LSP/buffer completions
    -- ============================================================================
  end,
}
