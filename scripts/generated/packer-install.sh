#!/bin/bash

# Check if packer is installed
if ! command -v packer > /dev/null; then
  echo "Installing packer"
  echo "You can set the desired version via PACKER_VERSION. Default is latest"
  if [ "$(uname -m)" = "x86_64" ]; then
    ARCH=amd64
  elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH=arm64
  else
    echo "Unknown system arch. Default to amd64"
  fi
  PACKER_DEFAULT_VERSION=$(curl -sL https://api.github.com/repos/hashicorp/packer/releases/latest | jq -r .tag_name)
  PACKER_VERSION=${PACKER_VERSION-$PACKER_DEFAULT_VERSION}
  # Fix version beginning with "v"
  if echo "${PACKER_VERSION}" | grep -q "v"; then
    PACKER_VERSION="${PACKER_VERSION:1}"
  fi
  curl -sL https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_${ARCH-amd64}.zip -o /tmp/packer.zip
  unzip -q /tmp/packer.zip -d /usr/local/bin -x "LICENSE.txt"
fi
packer version
