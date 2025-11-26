---
description: Interactively configure Neovim plugins with latest documentation
---

# Neovim Plugin Configuration

## Objective
Interactively configure Neovim plugins by fetching the latest documentation, proposing configurations that follow best practices, and applying changes to your Neovim setup. Handles adding new plugins, fixing issues, updating configurations, and removing plugins with validation and testing.

## CRITICAL: Neovim Configuration Directory

**ALWAYS use this exact directory path for ALL Neovim configuration operations:**
```
./nvim/.config/nvim/
```

This is the ONLY correct location for Neovim config files in this dotfiles repository. Specifically:
- Plugin files: `./nvim/.config/nvim/lua/plugins/*.lua`
- Core config files: `./nvim/.config/nvim/lua/config/*.lua`
- Main init file: `./nvim/.config/nvim/init.lua`

**DO NOT use these incorrect paths:**
- ❌ `~/.config/nvim/`
- ❌ `.config/nvim/`
- ❌ `/home/user/.config/nvim/`
- ❌ Any other variation

**Before ANY file operations, verify you are using `./nvim/.config/nvim/` as the base path.**

## Input
- **Optional argument:** Task type (`add`, `fix`, `update`, `remove`)
  - If provided via `$ARGUMENTS`: Use that task type directly
  - If not provided or invalid: Ask user interactively to select task type

## Process

### 1. Task Type Detection

Determine what type of configuration task to perform:

1. **Check for argument:**
   ```bash
   # If $ARGUMENTS contains: add, fix, update, or remove
   # Use that as the task type
   ```

2. **If no valid argument provided, ask user:**
   ```
   What would you like to do with your Neovim configuration?
   
   1. add     - Add a new plugin
   2. fix     - Fix an issue with an existing plugin
   3. update  - Update/improve an existing plugin configuration
   4. remove  - Remove a plugin
   
   Please select a task type (1-4 or type the name):
   ```

3. **Confirm task type:**
   - Acknowledge the user's selection
   - Proceed to the appropriate workflow

### 2. Plugin Identification

The identification strategy depends on the task type:

#### For ADD Tasks

1. **Ask user for plugin information:**
   ```
   What plugin would you like to add?
   
   You can provide:
   - Plugin name (e.g., "telescope", "nvim-tree")
   - GitHub URL (e.g., "https://github.com/nvim-telescope/telescope.nvim")
   - Author/repo format (e.g., "nvim-telescope/telescope.nvim")
   ```

2. **Parse and normalize the input:**
   - If URL provided: Extract author and repo name
   - If short name: Search for official/popular repository
   - Construct GitHub repository URL: `https://github.com/[author]/[repo]`

3. **Verify repository exists:**
   - Attempt to fetch the README
   - If not found, ask user to clarify or provide correct URL

#### For FIX/UPDATE/REMOVE Tasks

1. **List current plugins:**
   ```bash
   # Read all plugin files
   ls -1 ./nvim/.config/nvim/lua/plugins/*.lua | sed 's/.*\///' | sed 's/\.lua$//'
   ```

2. **Present plugins to user:**
   ```
   Current installed plugins:
   
   1. autopairs
   2. blink
   3. bufferline
   4. catppuccin
   [... list continues ...]
   
   Which plugin would you like to [fix/update/remove]?
   (Enter number or plugin name):
   ```

3. **Read selected plugin configuration:**
   ```bash
   cat ./nvim/.config/nvim/lua/plugins/[selected-plugin].lua
   ```

4. **Extract repository information:**
   - Parse the plugin spec to find the GitHub repo (first string in the return table)
   - Example: `return { "nvim-telescope/telescope.nvim", ... }`
   - Construct full GitHub URL for documentation fetching

### 3. Fetch Latest Documentation

1. **Fetch plugin README from GitHub:**
   ```bash
   # Use WebFetch to get the README
   # Use: https://github.com/[author]/[repo]
   # Example: https://github.com/akinsho/toggleterm.nvim
   # This will automatically redirect to the correct default branch
   ```

2. **Parse documentation for key information:**
   - Installation instructions (lazy.nvim format if available)
   - Required dependencies
   - Configuration options and defaults
   - Setup function requirements
   - Common keybindings and commands
   - Integration points with other plugins
   - Any deprecation notices or breaking changes

3. **Extract configuration examples:**
   - Look for lazy.nvim specific examples
   - Look for `setup()` function examples
   - Identify minimal vs. full configuration options

### 4. Requirements Gathering

Ask user about their specific needs based on task type:

#### For ADD Tasks

```
I've reviewed the documentation for [plugin-name]. Let me understand your needs:

1. **Primary Use Case:** What do you want to use this plugin for?
   
2. **Features:** Are there specific features you need enabled?
   (Based on docs, available features include: [list key features])

3. **Keybindings:** Do you have preferred keybindings, or should I suggest defaults?
   (Common prefix keys: <leader>f, <leader>g, <leader>s, etc.)

4. **Integration:** Should this plugin integrate with any of your existing plugins?
   (You have: [list relevant installed plugins])

5. **Lazy Loading:** When should this plugin load?
   - On startup (may slow down Neovim)
   - On specific events (e.g., file open, insert mode)
   - On command (fastest, loads only when needed)
   - On keypress (good for occasional use)
```

#### For FIX Tasks

```
I've fetched the latest documentation for [plugin-name]. Please describe the issue:

1. **Problem Description:** What's not working?

2. **Error Messages:** Are there any error messages? (Paste them if available)

3. **When It Occurs:** When does the issue happen?
   - On Neovim startup?
   - When using a specific command?
   - When editing certain file types?

4. **Expected Behavior:** What should happen instead?

I'll compare your current configuration with the latest documentation to identify the issue.
```

#### For UPDATE Tasks

```
I've fetched the latest documentation for [plugin-name]. What would you like to improve?

1. **Goal:** What do you want to add or change?
   
2. **New Features:** Any new features from the docs you'd like to enable?
   (I can highlight what's new if this is an update)

3. **Performance:** Should I optimize lazy loading?

4. **Keybindings:** Want to add/change any keybindings?

5. **Integration:** Should I integrate with any other plugins?
```

#### For REMOVE Tasks

```
You want to remove [plugin-name]. Before I do:

1. **Reason:** Why are you removing it? (Optional, helps me suggest alternatives)

2. **Dependencies:** This plugin has [X] dependents:
   [List any plugins that depend on this one]
   
   Should I remove these as well, or keep them?

3. **Configuration:** Should I also clean up related keybindings in other config files?
```

### 5. Configuration Analysis & Proposal

Based on the documentation and user requirements, create a configuration proposal:

#### For ADD Tasks

1. **Draft the plugin specification:**
   ```lua
   return {
     "[author]/[plugin-name]",
     
     -- Dependencies (from docs + analysis)
     dependencies = {
       "[required-dependency]",
       { "[optional-dependency]", opts = {} },
     },
     
     -- Lazy loading strategy (based on plugin type and user preference)
     event = "VeryLazy",  -- or cmd, keys, ft as appropriate
     
     -- Configuration options
     opts = {
       -- Options based on docs defaults + user requirements
       -- Include helpful comments
     },
     
     -- Or manual config if needed
     config = function()
       require("[plugin-name]").setup({
         -- configuration
       })
       
       -- Additional setup if needed
     end,
     
     -- Keybindings
     keys = {
       { "<leader>xx", "<cmd>Command<cr>", desc = "Description" },
     },
   }
   ```

2. **Add inline comments explaining:**
   - Why specific options are chosen
   - What each option does (for non-obvious settings)
   - Alternative values user might want to try
   - Links to relevant documentation sections

3. **Choose optimal lazy loading strategy:**
   - **LSP/Completion plugins:** `event = "BufReadPre"` or `"BufEnter"`
   - **Treesitter/Syntax:** `event = "BufReadPost"` or `"VeryLazy"`
   - **UI enhancements:** `event = "VeryLazy"` or `"UIEnter"`
   - **File managers/finders:** `cmd = { "Command" }` or `keys = { ... }`
   - **Git tools:** `event = "BufReadPre"` or `cmd = { ... }`
   - **Editing utilities:** `event = "InsertEnter"` or `keys = { ... }`

#### For FIX Tasks

1. **Compare current config with latest docs:**
   - Identify deprecated options
   - Find missing required options
   - Check for incorrect option types or values
   - Verify dependency versions

2. **Draft the corrected configuration:**
   - Fix identified issues
   - Preserve user customizations where possible
   - Add comments explaining what was changed and why

3. **List all changes:**
   ```
   Changes made to fix the issue:
   
   - Removed deprecated option `old_option` (replaced with `new_option`)
   - Added required dependency `required/plugin`
   - Fixed setup function call (was missing setup())
   - Updated event from "BufEnter" to "BufReadPre" (recommended in latest docs)
   ```

#### For UPDATE Tasks

1. **Draft the enhanced configuration:**
   - Add requested features/options
   - Integrate with other plugins if requested
   - Update lazy loading if beneficial
   - Add new keybindings

2. **Highlight what changed:**
   ```
   Updates to [plugin-name] configuration:
   
   + Added feature: [feature-name]
   + New keybinding: <leader>xx for [action]
   + Integration with: [other-plugin]
   ~ Optimized lazy loading: changed from [old] to [new]
   ```

#### For REMOVE Tasks

1. **Prepare removal steps:**
   - Identify the plugin file to delete
   - List any dependent plugins that may need updates
   - Check for keybindings in other config files that reference this plugin

2. **List cleanup tasks:**
   ```
   Removal plan for [plugin-name]:
   
   - Delete: ./nvim/.config/nvim/lua/plugins/[plugin-name].lua
   - Check for orphaned dependencies: [list]
   - Remove keybindings in: [files if any]
   - Update configs that referenced this plugin: [list if any]
   ```

### 6. Present Proposal & Get Approval

1. **Show the proposed configuration:**
   ````
   Here's the proposed configuration for [plugin-name]:
   
   ```lua
   [Full configuration code]
   ```
   
   **Key Features:**
   - [Feature 1]: [Explanation]
   - [Feature 2]: [Explanation]
   - [Feature 3]: [Explanation]
   
   **Lazy Loading:** [Strategy and reasoning]
   
   **Keybindings:**
   - `<leader>xx`: [Description]
   - `<leader>yy`: [Description]
   
   **Dependencies:** [List with explanations]
   ````

2. **Ask for user approval:**
   ```
   Does this configuration meet your needs?
   
   Reply with:
   - "Yes" or "Approve" to apply this configuration
   - "No" or "Modify" to request changes (tell me what to change)
   - Specific feedback about any section
   ```

3. **If user requests changes:**
   - Make the requested modifications
   - Re-present the configuration
   - Repeat until approved

### 7. Apply Configuration

Once the user approves the configuration:

#### For ADD Tasks

1. **Create the plugin file:**
   ```bash
   # Normalize plugin name for filename (lowercase, hyphens)
   # Example: "telescope.nvim" -> "telescope.lua"
   ```

2. **Write the configuration:**
   - CRITICAL: Write to `./nvim/.config/nvim/lua/plugins/[plugin-name].lua`
   - VERIFY the path starts with `./nvim/.config/nvim/`
   - Use the approved configuration
   - Ensure proper Lua formatting

3. **Update related files if needed:**
   - If keybindings should be in `keymaps.lua` instead, update `./nvim/.config/nvim/lua/config/keymaps.lua`
   - If global options are needed, update `./nvim/.config/nvim/lua/config/options.lua`
   - Always verify paths start with `./nvim/.config/nvim/`

#### For FIX/UPDATE Tasks

1. **Backup the current configuration:**
   ```bash
   # CRITICAL: Use the correct dotfiles path
   cp ./nvim/.config/nvim/lua/plugins/[plugin-name].lua ./nvim/.config/nvim/lua/plugins/[plugin-name].lua.bak
   ```

2. **Update the plugin file:**
   - Overwrite with the corrected/updated configuration
   - Preserve file permissions

3. **Clean up backup if successful:**
   - The backup serves as a safety net during testing
   - Will be removed after successful validation

#### For REMOVE Tasks

1. **Remove the plugin file:**
   ```bash
   # CRITICAL: Use the correct dotfiles path
   rm ./nvim/.config/nvim/lua/plugins/[plugin-name].lua
   ```

2. **Clean up related configurations:**
   - Remove or comment out related keybindings in other files
   - Update any configs that referenced this plugin

3. **List orphaned dependencies:**
   - Identify dependencies that are no longer needed
   - Ask user if they want to remove those as well

### 8. Validation & Testing

Perform automated checks and guide user through manual testing:

#### Syntax Check

1. **Check Lua syntax:**
   ```bash
   # CRITICAL: Use the correct dotfiles path
   nvim --headless -c "lua dofile('./nvim/.config/nvim/lua/plugins/[plugin-name].lua')" -c "q" 2>&1
   ```

2. **Report results:**
   ```
   ✓ Syntax Check: PASSED
   No Lua syntax errors found.
   ```
   
   Or if errors found:
   ```
   ✗ Syntax Check: FAILED
   
   Error: [error message]
   Line: [line number]
   
   Let me fix this issue...
   ```

3. **If errors found:**
   - Automatically fix common issues (missing commas, quote mismatches, etc.)
   - Re-run syntax check
   - If still failing, ask user for help

#### Health Check

1. **Run Neovim health check:**
   ```bash
   # Extract plugin module name from the config
   # Run health check for that module
   nvim --headless -c "checkhealth [module-name]" -c "quit" > /tmp/nvim-checkhealth-[plugin-name].log 2>&1
   
   # Display results
   cat /tmp/nvim-checkhealth-[plugin-name].log
   ```

2. **Parse and report results:**
   ```
   Health Check Results for [plugin-name]:
   
   ✓ [check-name]: OK
   ⚠ [check-name]: WARNING - [message]
   ✗ [check-name]: ERROR - [message]
   
   Summary:
   - X checks passed
   - Y warnings (optional dependencies or recommendations)
   - Z errors (require attention)
   ```

3. **For warnings/errors:**
   - Explain what each warning/error means
   - Provide recommended fixes
   - Ask if user wants to address them now or proceed

#### Manual Testing Instructions

1. **Provide clear testing steps:**
   ```
   Please test the configuration manually:
   
   1. **Restart Neovim:**
      Close all Neovim instances and open a new one
      
   2. **Verify plugin loaded:**
      Run: :Lazy
      Look for "[plugin-name]" in the list
      It should show as "Loaded" or "Not Loaded" (if lazy loaded)
      
   3. **Test basic functionality:**
      - [Specific command to try]: :[Command]
      - [Keybinding to test]: Press <leader>xx
      - [Expected behavior]: You should see [description]
      
   4. **Check for errors:**
      Run: :messages
      Look for any error messages related to [plugin-name]
      
   5. **Test in real usage:**
      [Specific scenario to test based on plugin type]
   ```

2. **Common testing patterns by plugin type:**
   
   **File Finders/Pickers:**
   ```
   - Press <leader>ff to open file finder
   - Type to search for files
   - Press Enter to open a file
   - Try other pickers: <leader>fg (grep), <leader>fb (buffers)
   ```
   
   **LSP/Completion:**
   ```
   - Open a code file (e.g., .lua, .py, .js)
   - Type some code and verify completion suggestions appear
   - Hover over a symbol (should show documentation)
   - Try go-to-definition with gd
   ```
   
   **UI Enhancements:**
   ```
   - Observe the visual changes (statusline, bufferline, etc.)
   - Check that colors and icons render correctly
   - Verify performance (Neovim should still feel snappy)
   ```
   
   **Git Tools:**
   ```
   - Open a file in a git repository
   - Look for git signs in the gutter
   - Try git commands: [commands specific to plugin]
   ```
   
   **Editing Utilities:**
   ```
   - Test the specific editing functionality
   - Try the keybindings multiple times
   - Verify it works across different file types
   ```

3. **Ask for user confirmation:**
   ```
   Did the plugin work correctly during your testing?
   
   Reply with:
   - "Yes" if everything works as expected
   - "No" if there are issues (describe what went wrong)
   - "Partial" if some features work but others don't
   ```

4. **If testing reveals issues:**
   - Ask user to describe what went wrong
   - Check `:messages` output for errors
   - Review configuration again
   - Make necessary adjustments
   - Repeat testing

5. **Once testing passes:**
   ```
   ✓ Manual testing confirmed successful!
   
   Proceeding to commit the changes...
   ```

### 9. Git Commit

Commit the configuration changes with a descriptive message:

1. **Stage changes:**
   ```bash
   # CRITICAL: Use the correct dotfiles path
   # Stage the plugin configuration file
   git add ./nvim/.config/nvim/lua/plugins/[plugin-name].lua
   
   # Stage any other modified files (keymaps, options, etc.)
   git add [other-modified-files]
   ```

2. **Commit with conventional format:**
   ```bash
   git commit -m "config(nvim): [task] [plugin-name] plugin

   - [Key change 1]
   - [Key change 2]
   - [Key change 3]"
   ```

3. **Commit message patterns by task type:**

   **ADD:**
   ```
   config(nvim): add telescope plugin
   
   - Add nvim-telescope/telescope.nvim with fzf sorter
   - Configure file, grep, and buffer pickers
   - Set keybindings: <leader>ff, <leader>fg, <leader>fb
   - Lazy load on keypress for optimal performance
   ```
   
   **FIX:**
   ```
   config(nvim): fix lspconfig setup
   
   - Remove deprecated on_attach option
   - Add required capabilities from cmp-nvim-lsp
   - Update server configurations to new format
   - Fixes LSP not attaching to buffers
   ```
   
   **UPDATE:**
   ```
   config(nvim): update treesitter config
   
   - Enable incremental selection module
   - Add textobjects for function/class navigation
   - Configure rainbow delimiters
   - Integrate with nvim-ts-context-commentstring
   ```
   
   **REMOVE:**
   ```
   config(nvim): remove old-plugin
   
   - Remove old-plugin configuration
   - Clean up related keybindings in keymaps.lua
   - Remove orphaned dependency unused-dep
   ```

4. **Confirm to user:**
   ```
   ✓ Changes committed successfully!
   
   Commit: [commit hash]
   
   Your Neovim configuration has been updated and committed.
   ```

## Output

- **New or updated plugin configuration:** `./nvim/.config/nvim/lua/plugins/[plugin-name].lua`
- **Validation results:**
  - Syntax check status
  - Health check report
  - Manual testing confirmation
- **Git commit:** Conventional commit on feature branch
- **Summary:** What was configured and how to use it
- **Next steps:** Ready to use in Neovim, can merge branch when satisfied

## Success Criteria

- [ ] Task type determined (add/fix/update/remove)
- [ ] Plugin identified correctly
- [ ] Latest documentation fetched from GitHub
- [ ] User requirements gathered and understood
- [ ] Configuration proposed based on latest docs and best practices
- [ ] Configuration follows lazy.nvim conventions
- [ ] User approved the proposed configuration
- [ ] Configuration file created/updated in correct location
- [ ] Syntax check passed (no Lua errors)
- [ ] Health check executed and results reported
- [ ] User manually tested and confirmed functionality works
- [ ] Changes committed with conventional commit format
- [ ] User can immediately use the plugin in Neovim

## Notes

### Lazy.nvim Configuration Patterns

**Basic Plugin Spec:**
```lua
return {
  "author/plugin-name",
  
  -- Lazy loading strategy
  event = "VeryLazy",        -- Load after startup
  cmd = { "Command" },       -- Load on command
  keys = { "<leader>x" },    -- Load on keypress
  ft = { "lua", "python" },  -- Load on filetype
  
  -- Dependencies
  dependencies = {
    "required/plugin",
    { "optional/plugin", opts = {} },
  },
  
  -- Simple configuration (auto-calls setup)
  opts = {
    option1 = value1,
    option2 = value2,
  },
  
  -- Or advanced configuration
  config = function()
    require("plugin-name").setup({
      -- options
    })
  end,
  
  -- Plugin-specific keymaps
  keys = {
    { "<leader>x", "<cmd>Command<cr>", desc = "Description" },
    { "<leader>y", function() require("plugin").action() end, desc = "Action" },
  },
}
```

### Lazy Loading Strategy Guide

Choose the right lazy loading strategy based on plugin type:

| Plugin Type | Recommended Strategy | Example |
|-------------|---------------------|---------|
| **LSP** | `event = "BufReadPre"` | nvim-lspconfig |
| **Completion** | `event = "InsertEnter"` | nvim-cmp |
| **Treesitter** | `event = "BufReadPost"` | nvim-treesitter |
| **Syntax/Highlighting** | `event = "VeryLazy"` | colorscheme plugins |
| **Statusline/UI** | `event = "VeryLazy"` | lualine, bufferline |
| **File Navigation** | `cmd = { ... }` or `keys = { ... }` | telescope, oil.nvim |
| **Git Integration** | `event = "BufReadPre"` | gitsigns, fugitive |
| **Text Objects** | `keys = { ... }` | nvim-surround, targets.vim |
| **Editing Utilities** | `event = "InsertEnter"` or `keys` | autopairs, comment |
| **Terminal** | `cmd = { ... }` or `keys = { ... }` | toggleterm |
| **Colorschemes** | `lazy = false, priority = 1000` | catppuccin, tokyonight |

**Multiple Strategies:**
You can combine strategies:
```lua
{
  "plugin/name",
  event = "VeryLazy",
  cmd = { "Command1", "Command2" },
  keys = { "<leader>x" },
  -- Loads on FIRST occurrence of event, cmd, or key
}
```

### Common Dependencies

Plugins often require these common dependencies:

- **nvim-lua/plenary.nvim** - Utility functions (required by many plugins)
- **nvim-tree/nvim-web-devicons** - File icons
- **nvim-treesitter/nvim-treesitter** - Syntax parsing
- **nvim-telescope/telescope-fzf-native.nvim** - Faster telescope sorting

### GitHub URL Patterns

When fetching documentation, try these URL patterns in order:

1. `https://github.com/[author]/[repo]` (main page)
2. `https://raw.githubusercontent.com/[author]/[repo]/main/README.md` (raw README)
3. `https://raw.githubusercontent.com/[author]/[repo]/master/README.md` (fallback branch)

**Extract author/repo from different input formats:**
- Full URL: `https://github.com/nvim-telescope/telescope.nvim` → `nvim-telescope/telescope.nvim`
- SSH: `git@github.com:nvim-telescope/telescope.nvim.git` → `nvim-telescope/telescope.nvim`
- Short form: `nvim-telescope/telescope.nvim` → use as-is
- Plugin name only: `telescope` → search/guess → `nvim-telescope/telescope.nvim`

### Common Neovim Commands for Testing

- `:Lazy` - Open lazy.nvim plugin manager UI
- `:Lazy update` - Update all plugins
- `:Lazy sync` - Install missing and update plugins
- `:Lazy clean` - Remove unused plugins
- `:messages` - Show message history (errors, warnings)
- `:checkhealth` - Run all health checks
- `:checkhealth [plugin]` - Run health check for specific plugin
- `:h [plugin-name]` - Open help documentation (if available)

### Troubleshooting Common Issues

**Plugin not loading:**
- Check lazy loading strategy (might be too restrictive)
- Verify dependencies are installed
- Check `:Lazy` UI for error messages
- Try `lazy = false` temporarily to test

**Setup function not found:**
- Plugin might use different setup method
- Check documentation for correct function name
- Some plugins don't require setup() call

**Keybindings not working:**
- Verify plugin is loaded (`:Lazy`)
- Check for conflicts with existing keybindings
- Ensure correct mode (normal, insert, visual)
- Try executing command directly first (`:Command`)

**Performance issues:**
- Review lazy loading strategy
- Check for plugins loading on startup unnecessarily
- Use `:Lazy profile` to see load times
- Consider deferring with `event = "VeryLazy"`

**Health check failures:**
- Read the error message carefully
- Install missing external dependencies (CLI tools)
- Check PATH for required executables
- Some warnings are optional (e.g., clipboard providers)
