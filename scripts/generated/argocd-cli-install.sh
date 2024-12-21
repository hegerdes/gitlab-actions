#!/bin/bash
# Check if argo-cli is installed
if ! command -v argo > /dev/null; then
  echo "Installing argo-cli"
  echo "You can set the desired version via ARGO_VERSION. Default is latest"
  if [ "$(uname -m)" = "x86_64" ]; then
    ARCH=amd64
  elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH=arm64
  else
    echo "Unknown system arch. Default to amd64"
  fi
  ARGO_DEFAULT_VERSION=$(curl -sL https://api.github.com/repos/argoproj/argo-cd/releases/latest | jq -r .tag_name)
  curl -sL --fail --output /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/${ARGO_VERSION-$ARGO_DEFAULT_VERSION}/argocd-linux-${ARCH-amd64}
  chmod +x /usr/local/bin/argocd
fi
argocd version --client
