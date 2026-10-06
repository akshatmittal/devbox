#!/usr/bin/env bash
set -euo pipefail

# Install Claude Code with the native installer.
curl -fsSL https://claude.ai/install.sh | bash

# Verify Claude Code is available.
claude --version

# The installer creates ~/.claude.json with a per-machine machineID and userID.
# Remove it so that all containers from this image do not share one identity.
rm -rf "${HOME}/.claude.json" "${HOME}/.claude"
