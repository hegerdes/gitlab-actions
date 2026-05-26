#!/bin/bash

# Check if tflint is installed
if ! command -v tflint > /dev/null; then
  echo "Installing tflint"
  echo "You can set the desired version via TFLINT_VERSION. Default is latest"
  if [ "$(uname -m)" = "x86_64" ]; then
    ARCH=amd64
  elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH=arm64
  else
    echo "Unknown system arch. Default to amd64"
  fi
  TFLINT_DEFAULT_VERSION=$(curl -sL https://api.github.com/repos/terraform-linters/tflint/releases/latest | jq -r .name)
  TFLINT_VERSION="${TFLINT_VERSION-$TFLINT_DEFAULT_VERSION}"
  curl -sL --fail --output /tmp/tflint.zip "https://github.com/terraform-linters/tflint/releases/download/${TFLINT_VERSION}/tflint_linux_${ARCH-amd64}.zip"
  unzip /tmp/tflint.zip -d /usr/bin/ > /dev/null
  rm /tmp/tflint.zip || true
fi
tflint --version
