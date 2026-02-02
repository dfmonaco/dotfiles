return {
  "github/copilot.vim",
  event = "InsertEnter", -- Lazy load when entering insert mode
  config = function()
    -- Disable Copilot's default Tab mapping (we'll create our own smart Tab)
    vim.g.copilot_no_tab_map = true
    
    -- Disable default assume_mapped to have full control over keybindings
    vim.g.copilot_assume_mapped = true
    
    -- Optional: Configure Copilot settings
    -- vim.g.copilot_filetypes = { ["*"] = true } -- Enable for all filetypes
    
    -- ============================================================================
    -- SMART KEYMAPS: Blink.cmp + Copilot Integration
    -- ============================================================================
    -- Philosophy: Make <Tab> "just work" intelligently
    -- - If Blink menu is open → Accept Blink completion
    -- - Else if Copilot suggestion visible → Accept Copilot
    -- - Else → Regular tab behavior
    -- ============================================================================
    
    -- Helper function: Check if Blink completion menu is visible
    local function is_blink_menu_visible()
      local ok, blink = pcall(require, 'blink.cmp')
      if not ok then return false end
      return blink.is_menu_visible()
    end
    
    -- Helper function: Check if Copilot has a suggestion
    local function has_copilot_suggestion()
      local suggestion = vim.fn['copilot#GetDisplayedSuggestion']()
      return suggestion.text ~= nil and suggestion.text ~= ''
    end
    
    -- ============================================================================
    -- SMART TAB: Primary completion acceptance
    -- ============================================================================
    vim.keymap.set('i', '<Tab>', function()
      -- Priority 1: Blink menu (immediate context-specific completions)
      if is_blink_menu_visible() then
        return vim.fn['blink.cmp'].accept()
      end
      
      -- Priority 2: Copilot suggestion (AI-powered broader suggestions)
      if has_copilot_suggestion() then
        vim.fn['copilot#Accept']('')
        return
      end
      
      -- Priority 3: Fallback to regular tab
      return vim.api.nvim_replace_termcodes('<Tab>', true, false, true)
    end, {
      expr = true,
      replace_keycodes = false,
      desc = 'Smart accept: Blink > Copilot > Tab'
    })
    
    -- ============================================================================
    -- SMART <C-n> / <C-p>: Navigation (Blink menu or Copilot suggestions)
    -- ============================================================================
    -- When Blink menu is open: Navigate Blink items
    -- When only Copilot visible: Cycle through Copilot suggestions
    -- Mental model: "These keys always mean navigate options"
    
    vim.keymap.set('i', '<C-n>', function()
      if is_blink_menu_visible() then
        return vim.fn['blink.cmp'].select_next()
      end
      
      if has_copilot_suggestion() then
        vim.fn['copilot#Next']()
        return
      end
      
      -- Fallback: do nothing
      return ''
    end, {
      expr = true,
      replace_keycodes = false,
      desc = 'Next: Blink item or Copilot suggestion'
    })
    
    vim.keymap.set('i', '<C-p>', function()
      if is_blink_menu_visible() then
        return vim.fn['blink.cmp'].select_prev()
      end
      
      if has_copilot_suggestion() then
        vim.fn['copilot#Previous']()
        return
      end
      
      -- Fallback: do nothing
      return ''
    end, {
      expr = true,
      replace_keycodes = false,
      desc = 'Previous: Blink item or Copilot suggestion'
    })
    
    -- ============================================================================
    -- COPILOT HJKL NAVIGATION: Vim-native directional control
    -- ============================================================================
    -- Think of the suggestion as a navigable space:
    --   <C-k> = Up (previous suggestion)
    --   <C-j> = Down (accept line / next line)
    --   <C-h> = Left (dismiss / go back)
    --   <C-l> = Right (accept word / move forward)
    -- These work ONLY in insert mode, so they don't conflict with window navigation
    
    -- <C-l>: Accept next word (move forward/right through the suggestion)
    vim.keymap.set('i', '<C-l>', function()
      if has_copilot_suggestion() then
        return vim.fn['copilot#AcceptWord']('')
      end
      return ''
    end, {
      expr = true,
      replace_keycodes = false,
      desc = 'Copilot: Accept next word'
    })
    
    -- <C-j>: Accept next line (move down through the suggestion)
    vim.keymap.set('i', '<C-j>', function()
      if has_copilot_suggestion() then
        return vim.fn['copilot#AcceptLine']('')
      end
      return ''
    end, {
      expr = true,
      replace_keycodes = false,
      desc = 'Copilot: Accept next line'
    })
    
    -- <C-k>: Previous Copilot suggestion (move up through alternatives)
    -- Note: Redundant with <C-p> but provides spatial mnemonic (k = up)
    vim.keymap.set('i', '<C-k>', function()
      if has_copilot_suggestion() then
        vim.fn['copilot#Previous']()
        return
      end
      return ''
    end, {
      expr = true,
      replace_keycodes = false,
      desc = 'Copilot: Previous suggestion'
    })
    
    -- <C-h>: Dismiss Copilot (go back/left/escape)
    -- Note: Redundant with <C-e> but provides spatial mnemonic (h = left/back)
    vim.keymap.set('i', '<C-h>', function()
      if is_blink_menu_visible() then
        return vim.fn['blink.cmp'].hide()
      end
      
      if has_copilot_suggestion() then
        vim.fn['copilot#Dismiss']()
        return
      end
      
      return ''
    end, {
      expr = true,
      replace_keycodes = false,
      desc = 'Dismiss: Blink menu or Copilot'
    })
    
    -- ============================================================================
    -- ADDITIONAL COPILOT CONTROLS
    -- ============================================================================
    
    -- <C-y>: Force accept Copilot (override Blink menu if both are visible)
    -- Traditional Vim mnemonic: "y = yes, accept"
    vim.keymap.set('i', '<C-y>', function()
      if has_copilot_suggestion() then
        return vim.fn['copilot#Accept']('')
      end
      return ''
    end, {
      expr = true,
      replace_keycodes = false,
      desc = 'Copilot: Force accept (override Blink)'
    })
    
    -- <C-e>: Dismiss everything (Blink + Copilot)
    -- Traditional Vim: "e = end/escape"
    vim.keymap.set('i', '<C-e>', function()
      if is_blink_menu_visible() then
        vim.fn['blink.cmp'].hide()
      end
      
      if has_copilot_suggestion() then
        vim.fn['copilot#Dismiss']()
      end
      
      return ''
    end, {
      expr = true,
      replace_keycodes = false,
      desc = 'Dismiss: Everything (Blink + Copilot)'
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
    -- KEYMAP SUMMARY (for quick reference)
    -- ============================================================================
    -- PRIMARY COMPLETION:
    --   <Tab>   : Smart accept (Blink > Copilot > fallback)
    --   <C-y>   : Force accept Copilot (override Blink)
    --   <C-e>   : Dismiss everything (Blink + Copilot)
    --
    -- COPILOT HJKL NAVIGATION (insert mode only):
    --   <C-l>   : Accept next word (→ forward)
    --   <C-j>   : Accept next line (↓ down)
    --   <C-h>   : Dismiss Copilot (← back)
    --   <C-k>   : Previous suggestion (↑ up)
    --
    -- CYCLING:
    --   <C-n>   : Next (Blink item or Copilot suggestion)
    --   <C-p>   : Previous (Blink item or Copilot suggestion)
    --
    -- MANUAL TRIGGER:
    --   <C-\>   : Request Copilot suggestion
    -- ============================================================================
  end,
}
