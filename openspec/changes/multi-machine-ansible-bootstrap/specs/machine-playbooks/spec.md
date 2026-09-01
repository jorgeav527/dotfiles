## ADDED Requirements

### Requirement: Per-machine playbooks and inventories

The system SHALL provide `config/desktop.yml`, `config/server.yml`, and `config/wsl.yml`, each targeting the corresponding inventory in `config/inventory/`. Each playbook SHALL run only the roles appropriate to its machine. `config/playbook.yml` and `config/inventory/local` SHALL be removed.

#### Scenario: Desktop playbook
- **WHEN** `desktop.yml` is run against `inventory/desktop.ini`
- **THEN** it connects locally and runs the `common` role

#### Scenario: Server playbook
- **WHEN** `server.yml` is run against `inventory/server.ini`
- **THEN** it connects over SSH to the host defined in the inventory and runs the `common` role

#### Scenario: WSL playbook
- **WHEN** `wsl.yml` is run against `inventory/wsl.ini`
- **THEN** it connects locally and runs the `common` role

#### Scenario: Legacy playbook removed
- **WHEN** a user looks for `config/playbook.yml` or `config/inventory/local`
- **THEN** neither file exists; the per-machine playbooks and inventories are the only entry points

### Requirement: Playbook structure with facts and verification

Each per-machine playbook SHALL gather facts, display the target host as a pre-task, and verify git availability as a post-task.

#### Scenario: Facts gathered and target displayed
- **WHEN** any per-machine playbook runs
- **THEN** Ansible gathers facts and a pre-task shows the `inventory_hostname`

#### Scenario: Post-deploy verification
- **WHEN** a per-machine playbook finishes its roles
- **THEN** a post-task runs `git --version` and fails the playbook if git is unavailable

### Requirement: Minimal common role

The `config/roles/common` role SHALL update the apt cache with `cache_valid_time: 3600` and install the packages in the `common_packages` variable, guarded by the Debian OS family fact. Existing heavier roles SHALL remain on disk but MUST NOT be referenced by the desktop, server, or WSL playbooks.

#### Scenario: Common role installs packages from variable
- **WHEN** the `common` role runs on a Debian machine
- **THEN** the apt cache is updated (unless fresh within one hour) and the packages in `common_packages` are installed

#### Scenario: Common role skips non-Debian machines
- **WHEN** the `common` role runs on a machine whose OS family is not Debian
- **THEN** no apt operation is performed

#### Scenario: Heavier roles not referenced
- **WHEN** `desktop.yml`, `server.yml`, or `wsl.yml` is inspected
- **THEN** only the `common` role is listed; the `zsh`, `terminal`, `languages`, `fonts`, `docker`, `desktop`, `apps`, and `dotfiles` roles are not invoked

### Requirement: Package list defined as a variable

The system SHALL define `common_packages` in `config/group_vars/all.yml`, containing at least `git`, and the `common` role SHALL install exactly the packages listed in that variable.

#### Scenario: common_packages drives installation
- **WHEN** the `common` role runs
- **THEN** it installs `common_packages` from `group_vars/all.yml` rather than hardcoded package names

### Requirement: Static server inventory

The system SHALL provide `config/inventory/server.ini` containing a single SSH host entry that the user edits (e.g. `user@host ansible_connection=ssh`) and a default SSH private key path of `~/.ssh/id_ed25519`. The server bootstrap SHALL derive the connection target from this file.

#### Scenario: Server host is user-edited
- **WHEN** a user opens `config/inventory/server.ini`
- **THEN** they can set the `user@host` value and the server playbook connects to it

### Requirement: Local inventories with connection defaults

The system SHALL provide `config/inventory/desktop.ini` and `config/inventory/wsl.ini`, each containing a local connection entry (`127.0.0.1 ansible_connection=local`), and SHALL set `ansible_python_interpreter=/usr/bin/python3` for all hosts in every inventory file via `[all:vars]`.

#### Scenario: Desktop and WSL connect locally
- **WHEN** `desktop.yml` or `wsl.yml` runs
- **THEN** Ansible connects to the local machine without SSH and uses `/usr/bin/python3`

#### Scenario: Server inventory has connection defaults
- **WHEN** `server.yml` runs against `inventory/server.ini`
- **THEN** Ansible uses the SSH private key and python interpreter declared in the inventory

### Requirement: Config defaults point at inventory directory

The Ansible configuration (`config/ansible.cfg`) SHALL use `inventory = inventory/` so playbook runs resolve inventories from the `config/inventory` directory.

#### Scenario: Playbook run resolves inventory by default
- **WHEN** a playbook is run from `config/` without an explicit `-i`
- **THEN** Ansible resolves inventories from the `inventory/` directory
