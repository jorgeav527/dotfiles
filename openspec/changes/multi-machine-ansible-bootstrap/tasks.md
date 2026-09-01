## 1. Playbooks and Inventories

- [x] 1.1 Create `config/desktop.yml` (`hosts: all`, `gather_facts: yes`, pre-task debug, role `common`, post-task verify `git --version`)
- [x] 1.2 Create `config/server.yml` (same structure as 1.1)
- [x] 1.3 Create `config/wsl.yml` (same structure as 1.1)
- [x] 1.4 Delete `config/playbook.yml`
- [x] 1.5 Create `config/inventory/desktop.ini` (`[desktop] 127.0.0.1 ansible_connection=local` + `[all:vars]` python interpreter)
- [x] 1.6 Create `config/inventory/wsl.ini` (`[wsl] 127.0.0.1 ansible_connection=local` + `[all:vars]` python interpreter)
- [x] 1.7 Create `config/inventory/server.ini` (`[server] <user@host> ansible_connection=ssh` + `[all:vars]` python interpreter and `~/.ssh/id_ed25519` private key)
- [x] 1.8 Delete `config/inventory/local`
- [x] 1.9 Update `config/ansible.cfg` to `inventory = inventory/`

## 2. Common Role

- [x] 2.1 Trim `config/roles/common/tasks/main.yml` to apt update (`cache_valid_time: 3600`, `when: ansible_os_family == 'Debian'`) plus install of `{{ common_packages }}` (same guard)
- [x] 2.2 Add `common_packages: [git]` to `config/group_vars/all.yml`
- [x] 2.3 Verify existing heavier roles are unreferenced by the new playbooks

## 3. Bootstrap and Makefile

- [x] 3.1 Rework `config/bootstrap.sh`: require `$1` machine arg (`desktop|server|wsl`), `set -euo pipefail`, usage message on invalid/missing arg
- [x] 3.2 Add shared prerequisite step: `sudo apt update` + install `git python3 python3-venv ansible`
- [x] 3.3 Run `ansible-playbook --syntax-check -i inventory/<machine>.ini <machine>.yml` before executing, for every machine
- [x] 3.4 Dispatch desktop/wsl to their playbook locally
- [x] 3.5 Dispatch server: read host from `inventory/server.ini`, `ssh-copy-id` to it, then `ansible-playbook -i inventory/server.ini server.yml -K`
- [x] 3.6 Rewrite `config/Makefile` targets: `desktop`, `wsl`, `server` calling `bootstrap.sh`; fix stale `debian_trixie` path references

## 4. Tests and Verification

- [x] 4.1 Fix `config/test/Dockerfile` WORKDIR to `/home/devuser/Devspace/dotfiles/config`
- [x] 4.2 Run `ansible-playbook --syntax-check -i inventory/desktop.ini desktop.yml` from `config/`
- [x] 4.3 Run `ansible-playbook --syntax-check -i inventory/server.ini server.yml` from `config/`
- [x] 4.4 Run `ansible-playbook --syntax-check -i inventory/wsl.ini wsl.yml` from `config/`
- [x] 4.5 Run the container test (`config/test/test.sh`) with the desktop playbook and confirm it passes
