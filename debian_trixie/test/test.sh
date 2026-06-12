#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
IMAGE_NAME="dotfiles-test"

echo "==> Building Docker test image (debian:testing)..."
docker build -t "$IMAGE_NAME" -f "$SCRIPT_DIR/Dockerfile" "$REPO_ROOT"

echo ""
echo "==> Running Ansible playbook in container..."
echo "    Skipping roles: desktop (UFW/GNOME), docker (daemon)"
echo ""
docker run --rm \
  -v "$REPO_ROOT:/home/devuser/Devspace/dotfiles" \
  "$IMAGE_NAME" \
  ansible-playbook -i inventory/local playbook.yml --skip-tags desktop,docker

echo ""
echo "==> Test complete. Exit code: $?"
