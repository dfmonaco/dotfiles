# LSP Installation Strategy

This directory contains language-specific LSP configurations for Neovim.

## Installation Priority Tiers

**IMPORTANT:** ALL language servers should follow this consistent priority order:

### Tier 1: System Packages (pacman) - ALWAYS CHECK FIRST ✅
**Rule:** ALWAYS check if a language server is available via pacman before using other methods.

**Benefits:**
- System-managed updates via pacman
- No version conflicts
- Works system-wide
- Well-maintained Arch packages
- Consistent installation method

**All language servers available via pacman:**
- Lua: `sudo pacman -S lua-language-server`
- Python: `sudo pacman -S pyright`
- TypeScript: `sudo pacman -S typescript-language-server`
- Bash: `sudo pacman -S bash-language-server`
- Svelte: `sudo pacman -S svelte-language-server`
- Ruby: `sudo pacman -S ruby-lsp` ⭐
- CSS/HTML/JSON: `sudo pacman -S vscode-langservers-extracted`

**Check availability:**
```bash
yay -Si <package-name>  # Check if available in repos
```

### Tier 2: Global Language Manager Installation
**When to use:** If system package unavailable OR for language runtime management

**Examples:**
- Ruby version: `asdf install ruby 3.2.9` (runtime, not LSP)
- Node version: `asdf install nodejs 24.12.0` (runtime, not LSP)
- TypeScript compiler: `npm install -g typescript` (compiler, not LSP server)
- Fallback LSP: `gem install ruby-lsp` (only if pacman unavailable)

### Tier 3: Per-Project Installation (Overrides)
**When to use:** Project-specific requirements that differ from system

**Benefits:**
- Exact dependency matching
- Team consistency via lock files
- Project isolation

**Detection logic (Ruby example):**
1. Check for project-specific installation (Gemfile.lock) → `bundle exec ruby-lsp`
2. Fallback to system installation → `ruby-lsp`

**Examples:**
- Ruby: `bundle exec ruby-lsp` (if ruby-lsp in Gemfile.lock)
- Node: `npx typescript-language-server` (if in package.json)
- Python: `.venv/bin/pyright` (if in virtualenv)

## Command Detection Strategy

**Default:** All language servers use system-installed binaries (simple, no detection needed)

**Per-Project Override Detection (Ruby):**
Ruby implements smart detection to support project-specific versions:
1. Check for Gemfile.lock + ruby-lsp entry → `bundle exec ruby-lsp`
2. Otherwise → `ruby-lsp` (system binary from pacman)

**Future enhancements:** Similar detection could be added for:
- Python: Check for venv → `.venv/bin/pyright` else `/usr/bin/pyright`
- Node: Check for package.json → `npx typescript-language-server` else `/usr/bin/typescript-language-server`

## Verification

After installation, verify each server:

```bash
# Check ALL system installations (should all show /usr/bin/*)
which lua-language-server        # /usr/bin/lua-language-server
which pyright                    # /usr/bin/pyright
which typescript-language-server # /usr/bin/typescript-language-server
which bash-language-server       # /usr/bin/bash-language-server
which svelteserver               # /usr/bin/svelteserver
which vscode-css-language-server # /usr/bin/vscode-css-language-server
which ruby-lsp                   # /usr/bin/ruby-lsp ⭐

# Check language runtimes (managed by asdf)
asdf current ruby                # Should show version 3.2.9
asdf current nodejs              # Should show version 24.12.0

# Verify pacman packages
pacman -Q | grep -E 'lua-language-server|pyright|typescript-language-server|bash-language-server|svelte-language-server|ruby-lsp|vscode-langservers'
```

## Adding New Languages

1. Create `<language>.lua` in this directory
2. Follow the template in existing files
3. Document installation using the tier system
4. Add `require("plugins.lsp.<language>")` to init.lua
5. Add server name to init.lua's servers list (if using simple enable)

## Troubleshooting

**LSP not starting:**
1. Check server is installed: `which <server-command>`
2. Check Neovim can find it: `:!which <server-command>`
3. Check LSP status: `:LspInfo`
4. Check logs: `:messages`

**Wrong version running:**
1. Check which binary: `which <command>` (might be shim vs system)
2. Check asdf shims: `asdf reshim <plugin>`
3. Check PATH priority: `echo $PATH`
