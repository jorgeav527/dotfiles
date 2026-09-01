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
```

## Ghostty on Debian 13 (Trixie)

Ghostty is not in the official Debian repositories, so it is installed from the
community `deb.griffo.io` apt repository. This is also automated by the Ansible
`apps` role.

```bash
# 1. Add the repository
sudo install -d -m 0755 /etc/apt/keyrings
curl -fsSL https://deb.griffo.io/EA0F721D231FDD3A0A17B9AC7808B4DD62C41256.asc | sudo gpg --dearmor --yes -o /etc/apt/keyrings/deb.griffo.io.gpg
echo "deb [signed-by=/etc/apt/keyrings/deb.griffo.io.gpg] https://deb.griffo.io/apt trixie main" | sudo tee /etc/apt/sources.list.d/deb.griffo.io.list > /dev/null
sudo apt update

# 2. Install Ghostty
sudo apt install ghostty
ghostty --version
```

### Configuration

The config is stowed from `ghostty/.config/ghostty/config.ghostty` into
`~/.config/ghostty/config.ghostty`. The `config.ghostty` filename is read by
Ghostty on Linux since v1.2.3 (falling back to `config`).

It requires:

- **Font**: `JetBrainsMono Nerd Font` — installed by the Ansible `fonts` role.
- **Theme**: `Gruvbox Dark Hard` — built into Ghostty, no extra files needed.

Validate or inspect the active configuration with:

```bash
ghostty +validate-config
ghostty +show-config
ghostty +list-themes
```
