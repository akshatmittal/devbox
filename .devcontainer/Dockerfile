FROM ubuntu:resolute

ENV DEBIAN_FRONTEND=noninteractive 

ENV PNPM_HOME="/home/vscode/.local/share/pnpm"
ENV FOUNDRY_HOME="/home/vscode/.foundry"
ENV SHELL="/bin/bash"
ENV PATH="/home/vscode/.local/bin:/home/vscode/.opencode/bin:${PATH}:${PNPM_HOME}/bin:${FOUNDRY_HOME}/bin"

# Basic
RUN <<EOF
set -e
apt-get update
apt-get install -y build-essential ca-certificates curl git libssl-dev lsb-release pkg-config sudo
if getent passwd ubuntu >/dev/null; then
  usermod --login vscode --move-home --home /home/vscode ubuntu
  if getent group ubuntu >/dev/null; then
    groupmod --new-name vscode ubuntu
  fi
else
  groupadd --gid 1000 vscode
  useradd --uid 1000 --gid 1000 -m -s /bin/bash vscode
fi
echo "vscode ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/vscode
chmod 0440 /etc/sudoers.d/vscode
apt-get clean
rm -rf /var/lib/apt/lists/*
EOF

USER vscode

# Node
RUN --mount=type=bind,source=scripts/install-node.sh,target=/tmp/install-node.sh /tmp/install-node.sh

# Codex
RUN --mount=type=bind,source=scripts/install-codex.sh,target=/tmp/install-codex.sh /tmp/install-codex.sh

# Claude Code
RUN --mount=type=bind,source=scripts/install-claude-code.sh,target=/tmp/install-claude-code.sh /tmp/install-claude-code.sh

# OpenCode
RUN --mount=type=bind,source=scripts/install-opencode.sh,target=/tmp/install-opencode.sh /tmp/install-opencode.sh

# Foundry
RUN --mount=type=bind,source=scripts/install-foundry.sh,target=/tmp/install-foundry.sh /tmp/install-foundry.sh

USER root
