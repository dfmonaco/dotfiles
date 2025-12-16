# LSP Installation Strategy

This directory contains language-specific LSP configurations for Neovim.

## Installation Priority Tiers

We follow a consistent priority order for language server installation:

### Tier 1: System Packages (pacman) - PREFERRED
**When to use:** Language servers that don't need project-specific versions

**Benefits:**
- System-managed updates via pacman
- No version conflicts
- Works system-wide
- Well-maintained Arch packages

**Languages using this tier:**
- Lua (lua-language-server)
- CSS/HTML/JSON (vscode-langservers-extracted)
- Python (pyright)
- Bash (bash-language-server)
- TypeScript (typescript-language-server)
- Svelte (svelte-language-server)

### Tier 2: asdf-managed Language Tools
**When to use:** Languages that need version management

**Benefits:**
- Per-project version control via .tool-versions
- Isolated from system packages
- Team consistency

**Languages using this tier:**
- Ruby (asdf for Ruby version, gem for ruby-lsp)
  ```bash
  asdf install ruby 3.2.9
  asdf set ruby 3.2.9 --home  # Sets in ~/.tool-versions
  gem install ruby-lsp
  ```
- Node.js (asdf for Node version, npm for packages)

### Tier 3: Per-Project Installation
**When to use:** Project-specific requirements

**Benefits:**
- Exact dependency matching
- Team consistency via lock files
- Isolated from global environment

**Examples:**
- Ruby projects with ruby-lsp in Gemfile → `bundle exec ruby-lsp`
- Node projects with LSP in package.json → `npx typescript-language-server`
- Python projects with LSP in venv → `.venv/bin/pyright`

### Tier 4: Global Language Manager
**When to use:** Fallback for standalone files outside projects

**Examples:**
- `gem install ruby-lsp` (outside Ruby projects)
- `npm install -g` (for standalone JS files)

## Command Detection

Most language servers use simple hardcoded commands since they're system-installed.

**Exception:** Ruby uses smart detection:
1. Check for Gemfile.lock + ruby-lsp entry → `bundle exec ruby-lsp`
2. Otherwise → `ruby-lsp` (global)

Future enhancements may add similar detection for Python (venv) and Node (npx).

## Verification

After installation, verify each server:

```bash
# Check system installations
which lua-language-server      # /usr/bin/lua-language-server
which pyright                   # /usr/bin/pyright
which typescript-language-server # /usr/bin/typescript-language-server
which bash-language-server      # /usr/bin/bash-language-server
which svelteserver              # /usr/bin/svelteserver
which vscode-css-language-server # /usr/bin/vscode-css-language-server

# Check asdf installations
which ruby-lsp                  # ~/.asdf/shims/ruby-lsp
asdf current ruby               # Should show version 3.2.9
asdf current nodejs             # Should show version 24.12.0
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
