# AGENTS.md

## Architecture

Two-layer setup: Ansible (`debian_trixie/`) provisions the system, then GNU Stow symlinks dotfiles into `$HOME`.

- **Real playbook**: `debian_trixie/playbook.yml` (8 roles, run in order). Root `local.yml` is a separate incomplete playbook that imports nonexistent `tasks/` files — ignore it.
- **Bootstrap**: `debian_trixie/bootstrap.sh` installs ansible + deps, then runs the playbook.
- **Makefile shortcuts** (in `debian_trixie/`): `make install` / `make debian` → bootstrap.sh; `make update` → `apt update/upgrade` + `ansible-playbook playbook.yml`.
- **Stow packages deployed**: zsh, nvim, alacritty, tmux (`roles/dotfiles/tasks/main.yml`). **kitty** config exists but is NOT stowed.
- **README.md** is stale about installed/stowed packages. This file is authoritative.

## Testing

Run in a Debian 13 container:

```bash
debian_trixie/test/test.sh
```

Builds `debian:testing` with ansible + devuser, runs `ansible-playbook --skip-tags desktop,docker`.
- **desktop** skipped because UFW/GNOME won't work in a container.
- **docker** skipped because daemon won't start without `--privileged`.

For faster iteration, run directly:

```bash
docker run --rm -v $(pwd):/home/devuser/Devspace/dotfiles dotfiles-test \
  ansible-playbook -i inventory/local playbook.yml --tags common,languages
```

Image tagged `dotfiles-test`; reusable between runs.

## Roles that work in the container

| Role | Notes |
|------|-------|
| common | apt packages (stow, ripgrep, fd-find, fzf, tmux, etc.) |
| zsh | zsh + zinit |
| terminal | alacritty |
| languages | Python3, Go, Rust (rustup), uv, nvm (v0.40.1), Terraform (1.10.5) |
| fonts | JetBrainsMono Nerd Font v3.3.0 |
| apps | neovim, lazygit, brave-browser, librewolf (apt install only) |
| dotfiles | stow symlinks zsh/nvim/alacritty/tmux into $HOME |

## Gotchas

- **Hardcoded NVM path**: `nvim/.config/nvim/lua/plugins/lsp.lua:9` has `/home/jorgeav527/.nvm/...` for Vue TypeScript plugin. Machine-specific — update per user.
- **Tmux plugins**: vendored git repos in `tmux/.config/tmux/plugins/`, gitignored. TPM loads at runtime. Prefix is `C-Space`.
- **Docker role** uses `bookworm` repo (not `testing`/`trixie`). The docker APT repo lacks a `trixie` suite.
- **`.gitignore`**: ignores `lazy-lock.json` (unused — Neovim uses native `pack`, not lazy.nvim), `*.retry`, `*.pyc`, `.DS_Store`, and vendored tmux plugins.
- **No CI, no tests** beyond the container setup.
