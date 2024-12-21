#!/bin/bash
# Check if azcopy is installed
if ! command -v azcopy > /dev/null; then
  echo "Installing azcopy"
  if [ "$(uname -m)" = "aarch64" ]; then
    ARCH="-arm64"
  fi
  if command -v apk > /dev/null; then
    apk add --no-cache libc6-compat > /dev/null
  fi
  curl -sL https://aka.ms/downloadazcopy-v10-linux${ARCH} -o az-copy.tar
  tar -xf az-copy.tar --strip-components=1 -C /usr/local/bin/
fi
azcopy --version
