#!/bin/bash

# Check if github cli is installed
if ! command -v gh > /dev/null; then
  echo "Installing github cli"
  echo "You can set the desired version via GH_CLI_VERSION. Default is latest"
  if [ "$(uname -m)" = "x86_64" ]; then
    ARCH=amd64
  elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH=arm64
  else
    echo "Unknown system arch. Default to amd64"
  fi
  GH_CLI_DEFAULT_VERSION=$(curl -sL https://api.github.com/repos/cli/cli/releases/latest | jq -r .tag_name)
  GH_VERSION=${GH_CLI_VERSION-$GH_CLI_DEFAULT_VERSION}
  # Fix version beginning with "v"
  if echo "${GH_VERSION}" | grep -q "v"; then
    GH_VERSION="${GH_VERSION:1}"
  fi
  curl -sL https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_${ARCH-amd64}.tar.gz -o /tmp/gh-cli.tar.gz
  tar -xzvf /tmp/gh-cli.tar.gz -C /usr/local/bin/ --strip-components=2 gh_${GH_VERSION}_linux_${ARCH-amd64}/bin/gh
  rm /tmp/gh-cli.tar.gz || true
fi
gh version
