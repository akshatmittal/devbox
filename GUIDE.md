# Dev Container Guide

This repository publishes a reusable Dev Container image:

```text
ghcr.io/akshatmittal/devbox:latest
```

It includes:

- Docker Hub `ubuntu:noble` (24.04.4)
- Node 24 via `nvm`
- `pnpm` via Corepack
- Codex CLI
- Claude Code
- OpenCode
- Foundry (`forge`, `cast`, `anvil`, and `chisel`)

## Using This Image

In another repository, add `.devcontainer/devcontainer.json`:

```json
{
  "image": "ghcr.io/akshatmittal/devbox:latest",
  "remoteUser": "agent"
}
```

## VS Code Usage

Install the Dev Containers extension in VS Code, then open the consuming repository and run this command from the Command Palette:

```text
Dev Containers: Reopen in Container
```

After changing `.devcontainer/devcontainer.json`, rebuild the container:

```text
Dev Containers: Rebuild Container
```

You can extend it with project-specific features and commands:

```json
{
  "image": "ghcr.io/akshatmittal/devbox:latest",
  "features": {
    "ghcr.io/devcontainers/features/github-cli:1": {}
  },
  "postCreateCommand": "pnpm install",
  "remoteUser": "agent"
}
```

If Rust is required by the consuming project, add the official Rust Dev Container Feature instead of relying on this base image to include Rust:

```json
{
  "image": "ghcr.io/akshatmittal/devbox:latest",
  "features": {
    "ghcr.io/devcontainers/features/rust:1": {}
  },
  "remoteUser": "agent"
}
```

## Agent Credentials

Do not bake Codex, Claude, or OpenCode credentials into the image. Credentials should be mounted into the running devcontainer, not copied during Docker build. This keeps secrets out of image layers and GHCR.

Prefer using dedicated host folders for devcontainer agent credentials instead of mounting your full host `~/.codex`, `~/.claude`, or `~/.local/share/opencode` directories. Dedicated folders reduce the chance of exposing unrelated sessions, settings, logs, or tokens to projects that do not need them but still allow sharing agent sessions.

Create dedicated host folders:

```sh
mkdir -p ~/.devcontainer-agents/codex ~/.devcontainer-agents/claude ~/.devcontainer-agents/opencode
```

Mount them into a consuming repo's `.devcontainer/devcontainer.json`:

```json
{
  "image": "ghcr.io/akshatmittal/devbox:latest",
  "mounts": [
    "source=${localEnv:HOME}/.devcontainer-agents/codex,target=/home/agent/.codex,type=bind",
    "source=${localEnv:HOME}/.devcontainer-agents/claude,target=/home/agent/.claude,type=bind",
    "source=${localEnv:HOME}/.devcontainer-agents/opencode,target=/home/agent/.local/share/opencode,type=bind"
  ],
  "remoteUser": "agent"
}
```

If you intentionally want to share your normal host agent state, you can mount the default folders instead:

```json
{
  "mounts": [
    "source=${localEnv:HOME}/.codex,target=/home/agent/.codex,type=bind",
    "source=${localEnv:HOME}/.claude,target=/home/agent/.claude,type=bind",
    "source=${localEnv:HOME}/.local/share/opencode,target=/home/agent/.local/share/opencode,type=bind"
  ]
}
```

Use the dedicated-folder approach unless you specifically need full host agent state in the container.
