#!/usr/bin/env bash
set -euo pipefail

\. "${HOME}/.nvm/nvm.sh"

# Install Codex CLI.
pnpm install -g @openai/codex --allow-build=@openai/codex

# Verify Codex CLI is available.
codex --version
