#!/bin/bash
# Check if talosctl is installed
if ! command -v talosctl > /dev/null; then
  echo "Installing talosctl"
  echo "You can set the desired version via TALOSCTL_VERSION. Default is latest"
  if [ "$(uname -m)" = "x86_64" ]; then
    ARCH=amd64
  elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH=arm64
  else
    echo "Unknown system arch. Default to amd64"
  fi
  TALOSCTL_DEFAULT_VERSION=$(curl -sL https://api.github.com/repos/siderolabs/talos/releases/latest | jq -r .tag_name)
  TALOSCTL_VERSION=${TALOSCTL_VERSION-$TALOSCTL_DEFAULT_VERSION}
  curl -sL https://github.com/siderolabs/talos/releases/download/${TALOSCTL_VERSION}/talosctl-linux-${ARCH-amd64} -o /usr/local/bin/talosctl
  chmod +x /usr/local/bin/talosctl
fi
talosctl version --client
