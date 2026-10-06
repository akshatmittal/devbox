#!/usr/bin/env bash
set -euo pipefail

NVM_VERSION="${NVM_VERSION:-0.40.8}"

export NVM_SYMLINK_CURRENT="${NVM_SYMLINK_CURRENT:-true}"

# Download and install nvm.
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh" | bash

# In lieu of restarting the shell.
\. "${HOME}/.nvm/nvm.sh"

# Download and install Node.
nvm install 24
nvm alias default 24

# Verify Node version.
node --version

# Download and install pnpm.
corepack enable pnpm

# Verify pnpm version.
pnpm --version
