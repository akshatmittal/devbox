#!/usr/bin/env bash
set -euo pipefail

# Install Codex CLI with the native installer.
# The installer keeps the binaries in $CODEX_HOME/packages/standalone. Use a
# directory other than ~/.codex, because ~/.codex is usually a bind mount.
curl -fsSL https://chatgpt.com/codex/install.sh |
  CODEX_HOME="${HOME}/.local/share/codex" CODEX_NON_INTERACTIVE=1 sh

# Verify Codex CLI is available.
codex --version
