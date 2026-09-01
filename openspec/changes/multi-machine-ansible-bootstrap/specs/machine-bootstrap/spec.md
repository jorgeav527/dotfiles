## ADDED Requirements

### Requirement: Machine-aware bootstrap entrypoint

The system SHALL provide a `config/bootstrap.sh` script that accepts a machine argument of `desktop`, `server`, or `wsl`, runs a shared prerequisite step, runs a syntax check on the target playbook, and dispatches to the matching playbook. An invalid or missing machine argument SHALL abort with a usage message.

#### Scenario: Desktop bootstrap
- **WHEN** a user runs `./bootstrap.sh desktop`
- **THEN** the script runs `sudo apt update`, installs `git`, `python3`, `python3-venv`, and `ansible`, syntax-checks, and runs `ansible-playbook -i inventory/desktop.ini desktop.yml` against the local machine

#### Scenario: WSL bootstrap
- **WHEN** a user runs `./bootstrap.sh wsl`
- **THEN** the script runs the same shared prerequisite step, syntax-checks, and runs `ansible-playbook -i inventory/wsl.ini wsl.yml` against the local machine

#### Scenario: Server bootstrap with first SSH connection
- **WHEN** a user runs `./bootstrap.sh server`
- **THEN** the script reads the host from `inventory/server.ini`, runs `ssh-copy-id` against that host to establish the first connection, syntax-checks, and then runs `ansible-playbook -i inventory/server.ini server.yml -K` over SSH

#### Scenario: Invalid machine argument
- **WHEN** a user runs `./bootstrap.sh` with no argument or an argument other than `desktop`, `server`, or `wsl`
- **THEN** the script prints usage instructions and exits with a non-zero status

### Requirement: Shared prerequisite step

The bootstrap script SHALL update the apt package cache and install `git`, `python3`, `python3-venv`, and `ansible` before running any playbook, for every machine.

#### Scenario: Prerequisites installed on every machine
- **WHEN** the bootstrap script runs for any machine
- **THEN** `apt update` has been run and `git`, `python3`, `python3-venv`, and `ansible` are installed before the playbook executes

### Requirement: Syntax check before execution

The bootstrap script SHALL run `ansible-playbook --syntax-check` against the target playbook before executing it, for every machine.

#### Scenario: Syntax check precedes playbook execution
- **WHEN** the bootstrap script runs for any machine
- **THEN** the target playbook is syntax-checked with `--syntax-check` before the playbook is executed

#### Scenario: Syntax error aborts execution
- **WHEN** the target playbook has a syntax error
- **THEN** the bootstrap script exits non-zero and does NOT execute the playbook

### Requirement: Script fails fast on errors

The bootstrap script SHALL stop immediately (set `-euo pipefail`) if the prerequisite step, syntax check, `ssh-copy-id`, or the playbook run fails.

#### Scenario: Failed server key exchange aborts run
- **WHEN** `ssh-copy-id` against the server host fails
- **THEN** the bootstrap script exits non-zero and does NOT run the server playbook

## REMOVED Requirements

### Requirement: Legacy single-playbook bootstrap
**Reason**: Replaced by the machine-aware bootstrap.
**Migration**: Use `./bootstrap.sh desktop|server|wsl`; the old unconditional `./bootstrap.sh` behavior no longer exists.
