#!/usr/bin/env bash
set -euo pipefail

echo -n "Node: "
node --version

echo -n "npm: "
npm --version

echo -n "pnpm: "
pnpm --version

echo -n "Codex: "
codex --version

echo -n "Claude: "
claude --version

echo -n "OpenCode: "
opencode --version

echo -n "Foundry Forge: "
forge --version

echo -n "Foundry Cast: "
cast --version

echo -n "Foundry Anvil: "
anvil --version

echo -n "Foundry Chisel: "
chisel --version

echo -n "Ubuntu: "
lsb_release -ds
