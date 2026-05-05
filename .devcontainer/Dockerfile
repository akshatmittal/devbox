FROM ubuntu:noble

ENV DEBIAN_FRONTEND=noninteractive 

ENV PNPM_HOME="/home/agent/.local/share/pnpm"
ENV FOUNDRY_HOME="/home/agent/.foundry"
ENV SHELL="/bin/bash"
ENV PATH="${PATH}:${PNPM_HOME}:${FOUNDRY_HOME}/bin"

# Basic
RUN <<EOF
set -e
apt-get update
apt-get install -y build-essential ca-certificates curl git libssl-dev lsb-release pkg-config sudo
if getent passwd ubuntu >/dev/null; then
  usermod --login agent --move-home --home /home/agent ubuntu
  if getent group ubuntu >/dev/null; then
    groupmod --new-name agent ubuntu
  fi
else
  groupadd --gid 1000 agent
  useradd --uid 1000 --gid 1000 -m -s /bin/bash agent
fi
echo "agent ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/agent
chmod 0440 /etc/sudoers.d/agent
apt-get clean
rm -rf /var/lib/apt/lists/*
EOF

USER agent

# Node
COPY --chown=agent:agent --chmod=755 scripts/install-node.sh /tmp/install-node.sh
RUN <<EOF
set -e
/tmp/install-node.sh
rm /tmp/install-node.sh
EOF

# Codex
COPY --chown=agent:agent --chmod=755 scripts/install-codex.sh /tmp/install-codex.sh
RUN <<EOF
set -e
/tmp/install-codex.sh
rm /tmp/install-codex.sh
EOF

# Claude Code
COPY --chown=agent:agent --chmod=755 scripts/install-claude-code.sh /tmp/install-claude-code.sh
RUN <<EOF
set -e
/tmp/install-claude-code.sh
rm /tmp/install-claude-code.sh
EOF

# OpenCode
COPY --chown=agent:agent --chmod=755 scripts/install-opencode.sh /tmp/install-opencode.sh
RUN <<EOF
set -e
/tmp/install-opencode.sh
rm /tmp/install-opencode.sh
EOF

# Foundry
COPY --chown=agent:agent --chmod=755 scripts/install-foundry.sh /tmp/install-foundry.sh
RUN <<EOF
set -e
/tmp/install-foundry.sh
rm /tmp/install-foundry.sh
EOF

ENV NVM_DIR="/home/agent/.nvm"
ENV PATH="${NVM_DIR}/current/bin:${PATH}"

USER root
