#!/bin/bash
# Check if tflint is installed
if ! command -v tflint > /dev/null; then
  echo "Installing tflint"
  if [ "$(uname -m)" = "x86_64" ]; then
    ARCH=amd64
  elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH=arm64
  else
    echo "Unknown system arch. Default to amd64"
  fi
  TFLINT_SYSTEM_TYPE="linux_${ARCH-amd64}.zip"
  TFLINT_RELEASES="https://api.github.com/repos/terraform-linters/tflint/releases/latest"
  TFLINT_URL=$(curl -sL $TFLINT_RELEASES | jq -r --arg term $TFLINT_SYSTEM_TYPE '.assets[] | select(.name | test($term)).browser_download_url')
  curl -sL --fail --output /tmp/tflint.zip $TFLINT_URL
  unzip /tmp/tflint.zip -d /usr/bin/ > /dev/null
fi
tflint --version
