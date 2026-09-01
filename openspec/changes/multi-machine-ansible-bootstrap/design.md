# Design: multi-machine-ansible-bootstrap

## Context

The Ansible config lives in `config/` at the repo root. Today it is a single `playbook.yml` that runs all 9 roles against one `inventory/local` host. The roles mix universal, desktop-only (GNOME, browsers, terminals), and server-appropriate (docker, firewall) concerns, with no way to select by machine type. The user provisions three Debian 13 machines: a desktop, a server, and WSL. `bootstrap.sh` currently runs the playbook unconditionally.

The repo root also contains Stow packages (`zsh/`, `nvim/`, `alacritty/`, `tmux/`, `ghostty/`, `kitty/`, `herdr/`) that must stay as siblings to `config/` — this change is confined to `config/`.

Terminology: these are three **machines** (desktop, server, wsl), not deployment environments (dev/staging/prod). All artifacts use "machine" / "target machine".

## Goals / Non-Goals

**Goals:**
- One Ansible setup in `config/` that can provision desktop, server, and WSL machines.
- A shared bootstrap core (`apt update` + `git` + ansible) for all machines.
- Desktop and WSL provision locally (`ansible_connection=local`); server provisions over SSH with first-connection key setup.
- Minimal, working baseline: apt update + `git` via a single `common` role, following the ansible-automation skill's best practices (facts guard, cache freshness, var-driven packages, syntax-check gate, post-deploy verification).
- Static, user-editable `inventory/server.ini` as the source of truth for the server host.

**Non-Goals:**
- Re-running the heavier roles (`zsh`, `terminal`, `languages`, `fonts`, `docker`, `desktop`, `apps`, `dotfiles`) in this change — they remain on disk but are unreferenced.
- Multi-host management, inventory dynamic plugins, or Windows-native (non-WSL) provisioning.
- Debian releases other than 13 (trixie) via apt.
- Rolling deployments, service healthchecks, or handlers — there are no services to restart in the `common` role.

## Decisions

### 1. Separate playbook per machine (not one playbook + groups)
Three playbooks (`desktop.yml`, `server.yml`, `wsl.yml`), each listing its roles, dispatched from bootstrap by argument.

- Why: fully explicit role sets per machine; no `when: group_names` gating inside roles; matches user preference.
- Alternative considered: single playbook gated by inventory groups — rejected for explicitness; a wrong `--tags` invocation could run desktop-only roles on a server.

### 2. Per-machine inventory files with a `[<machine>]` group
`inventory/desktop.ini` / `wsl.ini` contain `127.0.0.1 ansible_connection=local`; `inventory/server.ini` contains the real host (e.g. `user@1.2.3.4 ansible_connection=ssh`), edited once by the user. Each file declares `[all:vars]` with `ansible_python_interpreter=/usr/bin/python3`; `server.ini` also sets `ansible_ssh_private_key_file=~/.ssh/id_ed25519` to match the key the bootstrap creates.

- Why: matches the skill's inventory reference (`[all:vars]` connection defaults) and the "don't mix machines in inventory" best practice; group membership enables future `group_vars/<machine>.yml`; server host persists without typing it each run.
- Alternative considered: passing host as a CLI arg each time — rejected (user chose static file).

### 3. `bootstrap.sh <desktop|server|wsl>` with shared core + dispatch
```
sudo apt update
sudo apt install -y git python3 python3-venv ansible
```
then, per the skill's deployment-script pattern, run `--syntax-check` before executing:
- desktop/wsl: `ansible-playbook --syntax-check -i inventory/<machine>.ini <machine>.yml` then execute it
- server: read host line from `inventory/server.ini` → `ssh-copy-id <host>` (first connection, prompts once) → `ansible-playbook --syntax-check -i inventory/server.ini server.yml` then execute with `-K` (for `become` sudo password)

- Why: apt/git/ansible are bootstrap prerequisites, not playbook content; `--syntax-check` is the cheap, non-interactive part of "run without check mode first" — an interactive `--check` + confirmation gate is offered as an optional flag rather than forced, to keep the personal bootstrap fast.
- Alternative considered: installing ansible inside the playbook — rejected, chicken-and-egg (ansible must exist to run the playbook).

### 4. Minimal `common` role, skill-aligned
```
- apt: update_cache: yes, cache_valid_time: 3600   # freshness, avoids re-hitting network
  when: ansible_os_family == 'Debian'              # facts guard
- apt: name: "{{ common_packages }}", state: present  # no hardcoded values
  when: ansible_os_family == 'Debian'
```
with `common_packages: [git]` in `group_vars/all.yml`.

- Why: smallest working baseline the user asked to start with; applies the skill's no-hardcode, facts-guard, and cache-freshness practices. The existing `roles/common` is trimmed to this minimal set; other roles are left untouched on disk.

### 5. `gather_facts` + pre/post task structure in playbooks
Each playbook uses `gather_facts: yes`, a `pre_task` debug of `inventory_hostname`, and a `post_task` verifying `git --version` (exit code checked).

- Why: mirrors the skill's playbook structure and post-deploy verification; facts are required for the `common` role's OS-family guard.

### 6. Delete single playbook + legacy inventory
`playbook.yml` and `inventory/local` are removed (**BREAKING**); `ansible.cfg` inventory default becomes `inventory/`. `test/Dockerfile` WORKDIR fixed to `/home/devuser/Devspace/dotfiles/config` (was `debian_trixie`).

## Risks / Trade-offs

- **`ssh-copy-id` prompts for a password** on first server connection → run interactively; documented in bootstrap help output. Non-interactive automation of first SSH is out of scope.
- **`server.yml` `become` may need a sudo password** → bootstrap passes `-K`; assumes the remote user has sudo.
- **`--syntax-check` only validates syntax, not logic** → an optional `--check` dry-run flag is provided for manual verification; the container test in tasks.md exercises the real run.
- **Server key auth failure mid-run** → `ssh-copy-id` runs before the playbook; if it fails, bootstrap aborts (`set -euo pipefail`) before any ansible step.
- **`inventory/server.ini` contains a real host** → it is a personal, machine-local config; host is user-edited and no credentials are stored (only `user@host`).
- **Removing `playbook.yml` breaks old invocations** → accepted breaking change; Makefile and bootstrap are updated in the same change.

## Migration Plan

1. Implement files per tasks.md.
2. Verify locally on a desktop/WSL host: `./bootstrap.sh desktop` (and `wsl`) run green (container test covers the desktop path).
3. On the server: edit `inventory/server.ini`, run `./bootstrap.sh server` once to establish SSH + sudo.
4. Rollback: `git checkout` reverts `config/`; the old `playbook.yml`/`inventory/local` can be restored from git history if needed.

## Open Questions

- None blocking. The heavier per-machine role split (firewall/tools/apps, per-machine stow lists) is deliberately deferred to a follow-up change.
