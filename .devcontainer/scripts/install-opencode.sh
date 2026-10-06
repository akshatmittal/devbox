#!/usr/bin/env bash
set -euo pipefail

# Install OpenCode with the native installer.
# The installer puts the binary in ~/.opencode/bin. The Dockerfile adds it to PATH.
curl -fsSL https://opencode.ai/install | bash -s -- --no-modify-path

# Verify OpenCode is available.
opencode --version
