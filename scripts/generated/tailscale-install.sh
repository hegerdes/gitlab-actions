#!/bin/bash

# Check if tailscale is installed
if ! command -v tailscale > /dev/null; then
  echo "Installing tailscale"
  echo "You can set the desired version via TAILSCALE_VERSION. Default is latest"
  if [ "$(uname -m)" = "x86_64" ]; then
    ARCH=amd64
  elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH=arm64
  else
    echo "Unknown system arch. Default to amd64"
  fi
  TAILSCALE_DEFAULT_VERSION=$(curl -sL https://api.github.com/repos/tailscale/tailscale/releases/latest | jq -r .tag_name)
  TAILSCALE_VERSION=${TAILSCALE_VERSION-$TAILSCALE_DEFAULT_VERSION}
  # Fix version beginning with "v"
  if echo "${TAILSCALE_VERSION}" | grep -q "v"; then
    TAILSCALE_VERSION="${TAILSCALE_VERSION:1}"
  fi
  FILE_PREFIX="tailscale_${TAILSCALE_VERSION}_${ARCH-amd64}"
  curl -sL https://pkgs.tailscale.com/stable/${FILE_PREFIX}.tgz -o tailscale.tar.gz
  tar -xzf tailscale.tar.gz --strip-components=1 -C /usr/local/bin/ $FILE_PREFIX/tailscale $FILE_PREFIX/tailscaled
  rm tailscale.tar.gz
fi
mkdir -p /var/run/tailscale
tailscale --version
