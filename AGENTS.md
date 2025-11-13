# AI Agent Global Context - Development Guidelines

## Codebase Overview

Personal dotfiles repository for Linux system configuration. Contains
configuration for Neovim (LazyVim), shell (Bash/Zsh), window managers
(Hyprland/i3), and various system tools. No build, test, or lint commands.

## Repository Structure

- `/nvim/`, `/lazyvim/`: Neovim configurations (LazyVim starter)
- `/bash/`, `/zsh/`: Shell configurations
- `/hypr/`, `/i3/`, `/i3blocks/`: Window manager configs
- `/kitty/`, `/wezterm/`: Terminal emulator configs
- `/git/`: Git configuration
- Other: Individual tool configurations (waybar, rofi, sops, etc.)

## Code Style & Conventions

- **Languages:** Lua (Neovim), Bash/Shell, TOML, JSON, YAML configs
- **Naming:** Lowercase with hyphens for files, follow tool conventions
- **Editors:** Primary: Neovim; VSCode for secondary tasks
- **Git:** Conventional commits preferred

## Important Notes

- Configuration files prioritize maintainability and documentation
