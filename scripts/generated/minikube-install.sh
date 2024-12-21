#!/bin/bash
# Check if minikube is installed
if ! command -v minikube > /dev/null; then
  echo "Installing minikube"
  echo "You can set the desired version via MINIKUBE_VERSION. Default is latest"
  if [ "$(uname -m)" = "x86_64" ]; then
    ARCH=amd64
  elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH=arm64
  else
    echo "Unknown system arch. Default to amd64"
  fi
  MINIKUBE_DEFAULT_VERSION=$(curl -sL https://api.github.com/repos/kubernetes/minikube/releases/latest | jq -r .tag_name)
  curl -sL --fail --output /usr/local/bin/minikube https://github.com/kubernetes/minikube/releases/download/${MINIKUBE_VERSION-$MINIKUBE_DEFAULT_VERSION}/minikube-linux-${ARCH-amd64}
  chmod +x /usr/local/bin/minikube
fi
minikube version
