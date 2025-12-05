#!/usr/bin/env bash

set -euo pipefail

echo "==> Updating apt and upgrading system..."
sudo apt update
sudo apt upgrade -y

echo "==> Installing Ansible and basic dependencies..."
sudo apt install -y \
  software-properties-common \
  python3 \
  python3-pip \
  python3-venv \
  git

# On Debian, ansible is usually in the main repo
echo "==> Installing Ansible via apt..."
sudo apt install -y ansible

echo "==> Running Ansible playbook (Debian)..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

ansible-playbook -i inventory/local playbook.yml

echo
echo "🎉 All done! You may want to log out/in so Zsh & shell changes fully apply."
