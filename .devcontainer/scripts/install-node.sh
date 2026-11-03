#!/usr/bin/env bash
set -euo pipefail

# Install pnpm with the standalone installer.
# The installer puts the binary in $PNPM_HOME/bin. The Dockerfile adds it to PATH.
curl -fsSL https://get.pnpm.io/install.sh | PNPM_VERSION=12 PNPM_NO_MODIFY_PATH=1 sh -

# Verify pnpm version.
pnpm --version

# Install Node with pnpm.
pnpm runtime set node 26 -g

# Verify Node version.
node --version
