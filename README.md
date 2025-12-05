# Debian Dev Environment (Ansible + Dotfiles)

This folder contains the automation to set up my full dev environment on a Debian-based system.

## What it does

- Updates the system
- Installs Ansible
- Installs common tools (git, curl, tmux, ripgrep, fzf, stow, etc.)
- Installs languages & runtimes:
  - Python + pip + venv
  - Go
  - Rust (rustup)
  - uv (Python package manager)
  - nvm (Node Version Manager)
- Installs terminal & shell:
  - Zsh
  - Oh-My-Zsh
  - Powerlevel10k
  - Kitty terminal
- Installs apps:
  - Neovim
  - LazyGit
  - Yazi
  - Brave browser
  - Steam (if available in repos)
- Stows and symlinks all dotfiles from `~/Devspace/dotfiles`:
  - zsh, nvim, kitty, lazygit, yazi, git, fzf

## Requirements

- Debian-based system
- A user with sudo rights
- The dotfiles repo cloned to `~/Devspace/dotfiles`

Example:

```bash
mkdir -p ~/Devspace
cd ~/Devspace
git clone https://github.com/YOUR_USERNAME/dotfiles.git
