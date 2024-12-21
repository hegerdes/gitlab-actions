#!/bin/bash
# Check if kubeconform is installed
if ! command -v kubeconform > /dev/null; then
  echo "Installing kubeconform"
  echo "You can set the desired version via KUBECONFORM_VERSION. Default is latest"
  if [ "$(uname -m)" = "x86_64" ]; then
    ARCH=amd64
  elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH=arm64
  else
    echo "Unknown system arch. Default to amd64"
  fi
  KUBECONFORM_DEFAULT_VERSION=$(curl -sL https://api.github.com/repos/yannh/kubeconform/releases/latest | jq -r .tag_name)
  curl -sL --fail --output /tmp/kubeconform.tar.gz \
    https://github.com/yannh/kubeconform/releases/download/${KUBECONFORM_VERSION-$KUBECONFORM_DEFAULT_VERSION}/kubeconform-linux-${ARCH-amd64}.tar.gz
  tar -xzf /tmp/kubeconform.tar.gz -C /usr/local/bin/ --exclude={LICENSE,README.md}
  rm /tmp/kubeconform.tar.gz
  chmod +x /usr/local/bin/kubeconform
fi
kubeconform -v
