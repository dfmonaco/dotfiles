# Global AI Agent Rules - Personal Preferences

These rules apply to all OpenCode sessions across all projects.

## Communication Style

- **Concise responses**: Be direct and to the point. Avoid unnecessary verbosity.
- **No emojis**: Unless explicitly requested, never use emojis in responses.
- **Technical accuracy**: Prioritize correctness over agreement. Challenge assumptions when necessary.
- **Structured output**: Use markdown formatting for clarity (code blocks, lists, headers).

## Code Style & Conventions

### General
- **Clean code**: Prioritize readability and maintainability over cleverness.
- **Documentation**: Add comments for complex logic, but let code be self-documenting where possible.
- **Naming**: Use descriptive names; avoid abbreviations unless widely understood.

### Language-Specific
- **Lua**: Follow Neovim plugin conventions; use snake_case for functions/variables.
- **Shell/Bash**: Use shellcheck-compliant code; quote variables; use `set -euo pipefail`.
- **Configuration files**: Maintain consistent formatting; add comments explaining non-obvious settings.

### Git Practices
- **Conventional commits**: Use conventional commit format (feat:, fix:, docs:, etc.).
- **Atomic commits**: Each commit should represent a single logical change.
- **Descriptive messages**: Explain *why* changes were made, not just *what* changed.

## Workflow Preferences

### Before Making Changes
- **Ask first for critical files**: Configuration files, scripts that run on startup/boot.
- **Show diffs**: When modifying existing files, explain what's changing and why.
- **Verify context**: Read existing files to understand current implementation before suggesting changes.

### Safety & Backups
- **Test commands**: When suggesting shell commands, explain what they do and potential side effects.
- **Destructive operations**: Always warn before operations that delete/overwrite data.
- **Symlink awareness**: Be careful with symlinked files (dotfiles managed by stow).

### Tool Preferences
- **Terminal tools**: Prefer modern alternatives (rg over grep, fd over find, bat over cat).
- **Editor**: Primary: Neovim
- **Package managers**: Use appropriate manager for context (bun, npm, cargo, pacman, etc.).

## Error Handling & Debugging

- **Validate commands**: Check for required dependencies before suggesting commands.
- **Error messages**: Include full context when reporting errors.
- **Fallback options**: Suggest alternatives if primary approach fails.

## Learning & Adaptation

- **Ask for feedback**: When unsure about preferences, ask rather than assume.
- **Update rules**: These rules should evolve; suggest updates when patterns emerge.
- **Context retention**: Remember decisions made in the current session to maintain consistency.

## Restrictions

- **No automatic pushes**: Never push to remote repositories without explicit instruction.
- **No config corruption**: Validate syntax before writing config files (JSON, YAML, TOML, etc.).
- **No breaking changes**: For system configs, verify changes won't break boot/login/display.

## Personal Notes

- User: Diego
- System: Linux (Arch-based)
- Primary workflows: Development
