#!/bin/bash

# Check if helm-docs is installed
if ! command -v helm-docs > /dev/null; then
  echo "Installing helm-docs"
  echo "You can set the desired version via HELM_DOCS_VERSION. Default is latest"
  if [ "$(uname -m)" = "x86_64" ]; then
    ARCH=x86_64
  elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH=arm64
  else
    echo "Unknown system arch. Default to amd64"
  fi
  HELM_DOCS_DEFAULT_VERSION=$(curl -sL https://api.github.com/repos/norwoodj/helm-docs/releases/latest | jq -r .tag_name)
  HELM_DOCS_VERSION=${HELM_DOCS_VERSION-$HELM_DOCS_DEFAULT_VERSION}
  # Fix version beginning with "v"
  if echo "${HELM_DOCS_VERSION}" | grep -q "v"; then
    HELM_DOCS_VERSION="${HELM_DOCS_VERSION:1}"
  fi
  curl -sL --fail --output helm-docs.tar.gz https://github.com/norwoodj/helm-docs/releases/download/v${HELM_DOCS_VERSION}/helm-docs_${HELM_DOCS_VERSION}_Linux_${ARCH-amd64}.tar.gz
  tar -xzf helm-docs.tar.gz -C /usr/local/bin --exclude={LICENSE,README.md,CHANGELOG.md}
  rm helm-docs.tar.gz
fi
helm-docs --version
