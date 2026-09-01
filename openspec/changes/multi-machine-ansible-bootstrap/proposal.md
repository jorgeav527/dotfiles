# multi-machine-ansible-bootstrap

## Why

The current Ansible config (`config/`) is a single playbook that runs all roles against one `local` host. It cannot distinguish between a desktop, a server, or a WSL machine, so installing a desktop-oriented role (GNOME, browsers, terminals) on a server or WSL makes no sense. The config needs to target three different Debian 13 machines — a desktop, a server, and WSL — each with its own role set.

## What Changes

- **`config/bootstrap.sh`**: reworked to take a machine argument (`desktop`, `server`, `wsl`). Runs a shared core (`sudo apt update` + install `git`, `python3`, `python3-venv`, `ansible`), runs `--syntax-check` on the target playbook before executing it, then dispatches. The `server` machine additionally establishes the first SSH connection (via `ssh-copy-id`) before running the playbook over SSH with `-K`.
- **New per-machine playbooks**: `config/desktop.yml`, `config/server.yml`, `config/wsl.yml`, replacing the single `config/playbook.yml`. Each uses `gather_facts: yes`, a `pre_task` debug of the target host, and a `post_task` verifying `git` is available.
- **New inventory files**: `config/inventory/desktop.ini` (local), `config/inventory/wsl.ini` (local), `config/inventory/server.ini` (static SSH host, user-edited). Each sets `[all:vars]` with `ansible_python_interpreter=/usr/bin/python3`; `server.ini` also sets `ansible_ssh_private_key_file=~/.ssh/id_ed25519`. Delete `config/inventory/local`.
- **Minimal `common` role**: apt cache update with `cache_valid_time: 3600` guarded by `when: ansible_os_family == 'Debian'`, plus install of `{{ common_packages }}` (defined in `group_vars/all.yml` as `[git]`). Existing heavier roles (`zsh`, `terminal`, `languages`, `fonts`, `docker`, `desktop`, `apps`, `dotfiles`) stay on disk but are **not referenced** by the new playbooks in this change.
- **`config/group_vars/all.yml`**: adds `common_packages` list.
- **`config/ansible.cfg`**: `inventory = inventory/` default.
- **`config/Makefile`**: targets `desktop`, `wsl`, `server` (each calling `bootstrap.sh`).
- **`config/test/Dockerfile`**: fix stale `WORKDIR` pointing at the removed `debian_trixie/` path.
- **BREAKING**: `config/playbook.yml` and `config/inventory/local` are removed; existing invocation methods (`./bootstrap.sh`, `make install`) change.
- All changes are confined to `config/`. Stow packages at the repo root (`alacritty/`, `ghostty/`, `herdr/`, `kitty/`, `nvim/`, `tmux/`, `zsh/`) are untouched.

## Capabilities

### New Capabilities
- `machine-bootstrap`: machine-aware bootstrap entrypoint (`bootstrap.sh <desktop|server|wsl>`) with a shared apt/git/ansible core, syntax-check gate, and per-machine dispatch.
- `machine-playbooks`: per-machine playbooks and inventories selecting which roles run on desktop, server, and WSL machines, with a minimal `common` role.

### Modified Capabilities
<!-- No existing specs. -->

## Impact

- `config/`: `bootstrap.sh`, `ansible.cfg`, `Makefile`, `playbook.yml` (removed), `inventory/local` (removed), new `inventory/*.ini`, new `desktop.yml`/`server.yml`/`wsl.yml`, `roles/common/tasks/main.yml`, `group_vars/all.yml`, `test/Dockerfile`.
- Repo root: no changes.
- Server machines: first-time SSH key exchange required; `inventory/server.ini` must be edited with the target host.
- Test environment: container test invocation changes to use the new desktop playbook.
