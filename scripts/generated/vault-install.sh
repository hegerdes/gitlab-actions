#!/bin/bash
# Check if vault is installed
if ! command -v vault > /dev/null; then
  echo "Installing vault"
  echo "You can set the desired version via VAULT_VERSION_TAG. Default is latest"
  if [ "$(uname -m)" = "x86_64" ]; then
    ARCH=amd64
  elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH=arm64
  else
    echo "Unknown system arch. Default to amd64"
  fi
  VAULT_DEFAULT_VERSION_TAG=$(curl -sL https://api.github.com/repos/hashicorp/vault/releases/latest | jq -r .name)
  VAULT_VERSION=${VAULT_VERSION_TAG-$VAULT_DEFAULT_VERSION_TAG}
  # Fix version beginning with "v"
  if echo "${VAULT_VERSION}" | grep -q "v"; then
    VAULT_VERSION="${VAULT_VERSION:1}"
  fi
  curl -sL --fail --output /tmp/vault.zip https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_${ARCH-amd64}.zip
  unzip -q /tmp/vault.zip -d /usr/local/bin -x "LICENSE.txt"
  rm /tmp/vault.zip
fi
vault --version
