#!/bin/bash

# Check if kubectl is installed
if ! command -v kubectl > /dev/null; then
  echo "Installing kubectl"
  echo "You can set the desired version via KUBECTL_VERSION. Default is latest"
  if [ "$(uname -m)" = "x86_64" ]; then
    ARCH=amd64
  elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH=arm64
  else
    echo "Unknown system arch. Default to amd64"
  fi
  KUBECTL_DEFAULT_VERSION=$(curl -sL https://dl.k8s.io/release/stable.txt)
  KUBECTL_VERSION="${KUBECTL_VERSION-$KUBECTL_DEFAULT_VERSION}"
  # Fix version not beginning with "v"
  if ! echo "${KUBECTL_VERSION}" | grep -q "v"; then
    KUBECTL_VERSION="v${KUBECTL_VERSION}"
  fi
  curl -sL --fail --output /usr/bin/kubectl "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${ARCH-amd64}/kubectl"
  chmod +x /usr/bin/kubectl
fi
kubectl version --client
