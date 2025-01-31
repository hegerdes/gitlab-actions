#!/bin/bash

# Check if cosign is installed
if ! command -v cosign > /dev/null; then
  echo "Installing cosign!"
  echo "You can set the desired version via COSIGN_VERSION. Default is latest"
  if [ "$(uname -m)" = "x86_64" ]; then
    ARCH=amd64
  elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH=arm64
  else
    echo "Unknown system arch. Default to amd64"
  fi
  COSIGN_DEFAULT_VERSION=$(curl -sL https://api.github.com/repos/sigstore/cosign/releases/latest | jq -r .name)
  COSIGN_VERSION="${COSIGN_VERSION-$COSIGN_DEFAULT_VERSION}"
  curl -sL --fail --output /usr/local/bin/cosign "https://github.com/sigstore/cosign/releases/download/${COSIGN_VERSION}/cosign-linux-${ARCH-amd64}"
  chmod +x /usr/local/bin/cosign
fi
cosign version
