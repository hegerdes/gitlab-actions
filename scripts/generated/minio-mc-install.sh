#!/bin/bash
# Check if minio mc is installed
if ! command -v mc > /dev/null; then
  echo "Installing minio mc"
  if [ "$(uname -m)" = "x86_64" ]; then
    ARCH=amd64
  elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH=arm64
  else
    echo "Unknown system arch. Default to amd64"
  fi
  curl -sL https://dl.min.io/client/mc/release/linux-${ARCH-amd64}/mc -o /usr/local/bin/mc
  chmod +x /usr/local/bin/mc
fi
mc --version
