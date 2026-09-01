SHELL := /usr/bin/env bash

CONFIG_DIR := $(realpath .)

.PHONY: help desktop server wsl

help:
	@echo "Available targets:"
	@echo "  make desktop - Provision the desktop machine (bootstrap.sh desktop)"
	@echo "  make server  - Provision the server over SSH (bootstrap.sh server)"
	@echo "  make wsl     - Provision the WSL machine (bootstrap.sh wsl)"

desktop:
	cd "$(CONFIG_DIR)" && ./bootstrap.sh desktop

server:
	cd "$(CONFIG_DIR)" && ./bootstrap.sh server

wsl:
	cd "$(CONFIG_DIR)" && ./bootstrap.sh wsl
