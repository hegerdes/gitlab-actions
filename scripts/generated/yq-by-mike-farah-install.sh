#!/bin/bash
# Check if yq is installed
if ! command -v yq > /dev/null; then
  echo "Installing yq (by Mike Farah)"
  echo "You can set the desired version via YQ_VERSION. Default is latest"
  if [ "$(uname -m)" = "x86_64" ]; then
    ARCH=amd64
  elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH=arm64
  else
    echo "Unknown system arch. Default to amd64"
  fi
  YQ_DEFAULT_VERSION=$(curl -sL https://api.github.com/repos/mikefarah/yq/releases/latest | jq -r .tag_name)
  curl -sL --fail --output /usr/bin/yq \
    https://github.com/mikefarah/yq/releases/download/${YQ_VERSION-$YQ_DEFAULT_VERSION}/yq_linux_${ARCH-amd64}
  chmod +x /usr/bin/yq
fi
yq --version
