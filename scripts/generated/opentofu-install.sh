#!/bin/bash

# Check if opentofu is installed
if ! command -v tofu > /dev/null; then
  echo "Installing opentofu!"
  echo "You can set the desired version via OPENTOFU_VERSION. Default is latest"
  if [ "$(uname -m)" = "x86_64" ]; then
    ARCH=amd64
  elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH=arm64
  else
    echo "Unknown system arch. Default to amd64"
  fi
  TERRAFORM_DEFAULT_VERSION=$(curl -sL https://api.github.com/repos/opentofu/opentofu/releases/latest | jq -r .name)
  OPENTOFU_VERSION="${OPENTOFU_VERSION-$TERRAFORM_DEFAULT_VERSION}"
  # Fix version beginning with "v"
  if echo "${OPENTOFU_VERSION}" | grep -q "v"; then
    OPENTOFU_VERSION="${OPENTOFU_VERSION:1}"
  fi
  curl -sL --fail --output /tmp/tofu.tar.gz "https://github.com/opentofu/opentofu/releases/download/v${OPENTOFU_VERSION}/tofu_${OPENTOFU_VERSION}_linux_${ARCH-amd64}.tar.gz"
  tar -xzf /tmp/tofu.tar.gz -C /usr/local/bin/ --exclude={LICENSE,README.md,CHANGELOG.md}
  rm /tmp/tofu.tar.gz
fi
tofu --version
