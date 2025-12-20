---
description: Interactively configure Neovim plugins with latest documentation
---

# Neovim Plugin Configuration

## CRITICAL: Configuration Directory

**ALWAYS use this exact path for ALL Neovim configuration operations:**
```
./nvim/.config/nvim/
```

- Plugin files: `./nvim/.config/nvim/lua/plugins/*.lua`
- Config files: `./nvim/.config/nvim/lua/config/*.lua`
- Init file: `./nvim/.config/nvim/init.lua`

**DO NOT use** `~/.config/nvim/`, `.config/nvim/`, or any other path.

## Input

- **Optional argument:** Task type (`add`, `fix`, `update`, `remove`)
- If not provided: Ask user to select interactively

## Process

### 1. Task Type Detection

Check `$ARGUMENTS` for: `add`, `fix`, `update`, `remove`. If none provided, ask:
```
What would you like to do?
1. add    - Add a new plugin
2. fix    - Fix an issue with existing plugin
3. update - Update/improve existing configuration
4. remove - Remove a plugin
```

### 2. Plugin Identification

**For ADD:**
- Ask user for plugin name, GitHub URL, or author/repo format
- Normalize to GitHub URL: `https://github.com/[author]/[repo]`
- Verify repository exists by fetching README

**For FIX/UPDATE/REMOVE:**
- List current plugins: `ls ./nvim/.config/nvim/lua/plugins/*.lua`
- Let user select from list
- Read selected plugin config and extract repo URL from spec

### 3. Fetch Documentation

- WebFetch the plugin's GitHub page
- Extract: installation instructions, dependencies, config options, setup requirements, keybindings

### 4. Gather Requirements

Ask user about their needs based on task type:

- **ADD:** Use case, features needed, keybinding preferences, lazy loading preference
- **FIX:** Problem description, error messages, when it occurs, expected behavior
- **UPDATE:** What to improve, new features to enable, integration needs
- **REMOVE:** Check for dependents, ask about cleanup of related keybindings

### 5. Propose Configuration

Based on documentation and user requirements:

1. Draft lazy.nvim plugin spec with:
   - Dependencies (from docs)
   - Appropriate lazy loading strategy
   - Configuration options
   - Keybindings

2. Present proposal with explanation of key choices

3. Get user approval before applying:
   - "Yes" to apply
   - "No" or specific feedback to modify

4. Iterate until approved

### 6. Apply Configuration

**For ADD:**
- Create `./nvim/.config/nvim/lua/plugins/[plugin-name].lua`

**For FIX/UPDATE:**
- Backup existing file first (`.bak`)
- Update configuration

**For REMOVE:**
- Delete plugin file
- Clean up related keybindings in other config files
- Identify orphaned dependencies

### 7. Validation

1. **Syntax check:**
   ```bash
   nvim --headless -c "lua dofile('./nvim/.config/nvim/lua/plugins/[name].lua')" -c "q" 2>&1
   ```

2. **Health check:**
   ```bash
   nvim --headless -c "checkhealth [module]" -c "quit"
   ```

3. **Manual testing:** Ask user to:
   - Restart Neovim
   - Verify plugin in `:Lazy`
   - Test functionality
   - Check `:messages` for errors

4. If issues found, fix and re-validate

### 8. Git Commit

Stage and commit with conventional format:
```bash
git add ./nvim/.config/nvim/lua/plugins/[plugin-name].lua
git commit -m "config(nvim): [task] [plugin-name]

- [Key change 1]
- [Key change 2]"
```

## Success Criteria

- [ ] Task type determined (add/fix/update/remove)
- [ ] Plugin identified correctly
- [ ] Latest documentation fetched from GitHub
- [ ] User requirements gathered
- [ ] Configuration proposed based on docs and best practices
- [ ] User approved the configuration
- [ ] Configuration file created/updated in `./nvim/.config/nvim/lua/plugins/`
- [ ] Syntax check passed
- [ ] Health check executed
- [ ] User confirmed functionality works
- [ ] Changes committed
