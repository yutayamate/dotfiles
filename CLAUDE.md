# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository that manages configuration files for *nix environments (macOS and Linux). The repository uses symlinks to install configuration files from the repo to the appropriate system locations.

## Installation and Setup

```bash
# Install all configurations
make install

# Install specific tool configurations
make git
make zsh
make sheldon
make zellij
make ghostty
make alacritty
# See Makefile for all available targets
```

The Makefile creates symlinks from `${XDG_CONFIG_HOME}` (defaults to `~/.config`) to the configuration files in this repository.

## Repository Structure

- `.config/` - XDG Base Directory compliant configurations
  - `git/` - Git configuration, hooks, and ignore patterns
  - `sheldon/` - Zsh plugin manager configuration
  - `zellij/` - Terminal multiplexer configuration
  - `ghostty/` - Terminal emulator configuration
  - `alacritty/` - Alternative terminal emulator with platform-specific configs
  - `tmux/` - Terminal multiplexer configuration
  - `emacs/` - Emacs initialization
  - `containers/` - Podman/container configuration
- `.zshrc` - Main Zsh configuration
- `.zshrc.d/` - Additional Zsh scripts (prompt themes, info functions)
- `.vim/` - Vim configuration
- `.ssh/` - SSH client configuration
- `.aws/` - AWS CLI configuration
- `Brewfile` - Homebrew package list

## Key Configuration Details

### Zsh Setup
- Uses `sheldon` for plugin management (zsh-defer, zsh-completions, zsh-syntax-highlighting, zsh-autosuggestions)
- Custom prompt themes in `.zshrc.d/` (Kali prompt with custom info functions)
- Integrates with mise, fzf, zellij, and ghostty when available
- Auto-starts zellij for local sessions (not over SSH)
- Podman integration with Docker compatibility

### Git Configuration
- Custom hooks path: `~/.config/git/hooks`
- Pre-commit hook runs shellcheck and gitleaks (if installed)
- Commit-msg hook shows commit preview and requires confirmation
- Uses GitHub CLI for credential management
- User: Yuta Yamate <11874627+yutayamate@users.noreply.github.com>

### Platform-Specific Behavior
- Alacritty uses different configs for Darwin vs Linux (see Makefile:67-71)
- The `OS` variable in Makefile determines platform-specific installation

### Local Overrides
Files ending in `.local` are gitignored and can be used for machine-specific settings:
- `.zshrc.local`
- `.config/git/config.local`
- `.config/ghostty/config.local`
- `.config/alacritty/alacritty.toml` (generated symlink)

## Development Tools
Brewfile includes essential CLI tools:
- Cloud: awscli, azure-cli, gcloud-cli
- Containers: docker, podman, docker-compose, kubernetes-cli
- Development: gh, jq, yq, fzf, bat, mise
- Terminals: zellij, ghostty
- IaC: terraform

## CI/CD
GitHub Actions workflow (`.github/workflows/main.yml`) tests `make install` on both macOS and Ubuntu.
