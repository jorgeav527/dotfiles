SHELL := /usr/bin/env bash

DOTFILES_DIR := $(realpath ..)
DEBIAN_DIR   := $(DOTFILES_DIR)/Debian

.PHONY: help install debian update

help:
	@echo "Available targets:"
	@echo "  make install   - Run Debian bootstrap (install everything)"
	@echo "  make debian    - Same as install"
	@echo "  make update    - apt update/upgrade and rerun playbook"

install: debian

debian:
	cd "$(DEBIAN_DIR)" && ./bootstrap.sh

update:
	sudo apt update && sudo apt upgrade -y
	cd "$(DEBIAN_DIR)" && ansible-playbook -i inventory/local playbook.yml
