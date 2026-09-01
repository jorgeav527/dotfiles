#!/usr/bin/env bash

set -euo pipefail

MACHINE="${1:-}"

usage() {
  cat <<'EOF'
Usage: ./bootstrap.sh <desktop|server|wsl>

  desktop - provision a Debian 13 desktop machine locally
  server  - provision a Debian 13 server over SSH (host from inventory/server.ini)
  wsl     - provision a Debian 13 WSL machine locally
EOF
  exit 1
}

case "$MACHINE" in
  desktop|server|wsl) ;;
  *) usage ;;
esac

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "==> Updating apt..."
sudo apt update

echo "==> Installing Ansible and basic dependencies..."
sudo apt install -y \
  python3 \
  python3-venv \
  git \
  ansible

echo "==> Syntax-checking ${MACHINE}.yml..."
ansible-playbook --syntax-check -i "inventory/${MACHINE}.ini" "${MACHINE}.yml"

if [[ "$MACHINE" == "server" ]]; then
  echo "==> Establishing first SSH connection to server..."
  HOST="$(grep -vE '^\s*(#|$)' inventory/server.ini | grep -v '^\[' | head -n 1 | awk '{print $1}')"
  ssh-copy-id "$HOST"

  echo "==> Running Ansible playbook (server over SSH)..."
  ansible-playbook -i inventory/server.ini server.yml -K
else
  echo "==> Running Ansible playbook (${MACHINE})..."
  ansible-playbook -i "inventory/${MACHINE}.ini" "${MACHINE}.yml"
fi

echo
echo "🎉 All done! You may want to log out/in so shell changes fully apply."
