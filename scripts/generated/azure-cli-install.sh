#!/bin/bash
# Check if az cli is installed
if ! command -v az > /dev/null; then
  if command -v apt-get > /dev/null; then
    echo "Installing azure-cli"
    mkdir -p /etc/apt/keyrings
    apt-get update -qq > /dev/null
    apt-get install -y -qq --no-install-recommends \
      apt-transport-https ca-certificates curl gnupg lsb-release > /dev/null

    curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
      gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg
    chmod go+r /etc/apt/keyrings/microsoft.gpg

    echo "Types: deb
    URIs: https://packages.microsoft.com/repos/azure-cli/
    Suites: $(lsb_release -cs)
    Components: main
    Architectures: $(dpkg --print-architecture)
    Signed-by: /etc/apt/keyrings/microsoft.gpg" > /etc/apt/sources.list.d/azure-cli.sources
    sed -i 's/^[ \t]*//' /etc/apt/sources.list.d/azure-cli.sources

    apt-get update -qq > /dev/null
    apt-get install -y -qq azure-cli --no-install-recommends > /dev/null
    az version
  else
    echo "Azure CLI install is currently only supported in debian based images. Skipping install!"
  fi
fi
