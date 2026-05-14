#!/bin/bash

# Check if aws ssm plugin is installed
if ! command -v session-manager-plugin > /dev/null; then
  echo "Installing aws ssm plugin"
  if command -v apk > /dev/null; then
    apk add --no-cache aws-session-manager-plugin > /dev/null
  elif command -v dpkg > /dev/null; then
    if [ "$(uname -m)" = "x86_64" ]; then
      ARCH=64bit
    elif [ "$(uname -m)" = "aarch64" ]; then
      ARCH=arm64
    else
      echo "Unknown system arch. Default to amd64"
    fi
    curl -sL "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_${ARCH-64bit}/session-manager-plugin.deb" -o /tmp/ssm-plugin.deb
    dpkg -i /tmp/ssm-plugin.deb
    rm /tmp/ssm-plugin.deb
  else
    echo "ERROR: This platform is currently not supported"
  fi
fi
session-manager-plugin --version
