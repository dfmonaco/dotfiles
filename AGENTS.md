# AI Agent Global Context - Development Guidelines

## Codebase Overview

Personal dotfiles repository for Linux system configuration. Contains
configuration for Neovim (LazyVim), shell (Bash/Zsh), window managers
(Hyprland/i3), and various system tools. This repo is primarily managed with
GNU Stow to create symlinks for files under `$HOME`. No build, test, or lint
commands.

## Repository Structure

- Top-level directories are generally Stow packages that map to target paths
  under `$HOME`
- `/nvim/`, `/lazyvim/`: Neovim configurations (LazyVim starter)
- `/bash/`, `/zsh/`: Shell configurations
- `/hypr/`, `/i3/`, `/i3blocks/`: Window manager configs
- `/kitty/`, `/wezterm/`: Terminal emulator configs
- `/git/`: Git configuration
- Other: Individual tool configurations (waybar, rofi, sops, etc.)

### Stow Folder Structure Rules

- Each package should mirror the final destination path relative to `$HOME`
- For XDG configs, place files under `.config/<app>/` inside the package
  (example: `nvim/.config/nvim/`)
- For home-level dotfiles, place them at the package root only when the real
  target lives directly in `$HOME` (example: `bash/.bashrc`,
  `git/.gitconfig`)
- Keep one application or closely related toolset per package so Stow can
  enable or disable it cleanly
- When adding new files, preserve the real on-disk layout the application
  expects instead of flattening paths for convenience

### Stow Usage In This Repo

- Stow packages from the repo root with a home target, for example:
  `stow -t "$HOME" nvim bash git`
- Use `stow -D -t "$HOME" <package>` to remove a package's symlinks
- Use `stow -R -t "$HOME" <package>` after reorganizing files to restow them
- Prefer updating files inside the package directories in this repo, not the
  symlinked files in `$HOME`
- Before creating a new top-level directory, treat it as a Stow package and
  verify its internal layout matches the intended target path

## Code Style & Conventions

- **Languages:** Lua (Neovim), Bash/Shell, TOML, JSON, YAML configs
- **Naming:** Lowercase with hyphens for files, follow tool conventions
- **Editors:** Primary: Neovim; VSCode for secondary tasks
- **Git:** Conventional commits preferred

## Important Notes

- Configuration files prioritize maintainability and documentation
- Assume Stow compatibility when moving or adding files; incorrect package
  layout will create broken or unexpected symlinks
