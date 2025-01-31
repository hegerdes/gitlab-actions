#!/bin/bash

# Check if kind is installed
if ! command -v kind > /dev/null; then
  echo "Installing kind"
  echo "You can set the desired version via KIND_VERSION. Default is latest"
  if [ "$(uname -m)" = "x86_64" ]; then
    ARCH=amd64
  elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH=arm64
  else
    echo "Unknown system arch. Default to amd64"
  fi
  KIND_DEFAULT_VERSION=$(curl -sL https://api.github.com/repos/kubernetes-sigs/kind/releases/latest | jq -r .tag_name)
  curl -sL --fail --output /usr/local/bin/kind https://github.com/kubernetes-sigs/kind/releases/download/${KIND_VERSION-$KIND_DEFAULT_VERSION}/kind-linux-${ARCH-amd64}
  chmod +x /usr/local/bin/kind
fi
kind version
