#!/bin/bash
# Check if kubeseal is installed
if ! command -v kubeseal > /dev/null; then
  echo "Installing kubeseal"
  echo "You can set the desired version via KUBESEAL_VERSION. Default is latest"
  if [ "$(uname -m)" = "x86_64" ]; then
    ARCH=amd64
  elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH=arm64
  else
    echo "Unknown system arch. Default to amd64"
  fi
  KUBESEAL_DEFAULT_VERSION=$(curl -sL https://api.github.com/repos/bitnami-labs/sealed-secrets/releases/latest | jq -r .tag_name | cut -c 2-)
  curl -sL --fail --output kubeseal.tar.gz "https://github.com/bitnami-labs/sealed-secrets/releases/download/v${KUBESEAL_VERSION-$KUBESEAL_DEFAULT_VERSION}/kubeseal-${KUBESEAL_VERSION-$KUBESEAL_DEFAULT_VERSION}-linux-${ARCH-amd64}.tar.gz"
  tar -xzf kubeseal.tar.gz -C /usr/bin kubeseal
  rm kubeseal.tar.gz
  chmod +x /usr/bin/kubeseal
fi
kubeseal --version
