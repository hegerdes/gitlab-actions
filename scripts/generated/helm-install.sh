#!/bin/bash

# Check if helm is installed
if ! command -v helm > /dev/null; then
  echo "Installing helm"
  echo "You can set the desired version via HELM_VERSION. Default is latest"
  if [ "$(uname -m)" = "x86_64" ]; then
    ARCH=amd64
  elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH=arm64
  else
    echo "Unknown system arch. Default to amd64"
  fi
  HELM_DEFAULT_VERSION=$(curl -sL https://api.github.com/repos/helm/helm/releases/latest | jq -r .tag_name)
  curl -sL --fail --output /tmp/helm.tar.gz https://get.helm.sh/helm-${HELM_VERSION-$HELM_DEFAULT_VERSION}-linux-${ARCH-amd64}.tar.gz
  tar -xzf /tmp/helm.tar.gz -C /usr/local/bin/ --strip-components=1 --exclude={LICENSE,README.md}
fi
helm version
