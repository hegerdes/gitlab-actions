#!/bin/bash

# Check if jq is installed
if ! command -v jq > /dev/null; then
  echo "Installing jq"
  echo "You can set the desired version via JQ_VERSION_TAG. Default is latest"
  if [ "$(uname -m)" = "x86_64" ]; then
    ARCH=amd64
  elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH=arm64
  else
    echo "Unknown system arch. Default to amd64"
  fi
  JQ_DEFAULT_VERSION_TAG=$(curl -sL https://api.github.com/repos/jqlang/jq/releases/latest | grep tag_name | cut -d : -f 2 | sed 's/^ *//; s/ *$//; s/"//g; s/,//g')
  curl -sL --fail --output /usr/local/bin/jq https://github.com/jqlang/jq/releases/download/${JQ_VERSION_TAG-$JQ_DEFAULT_VERSION_TAG}/jq-linux-${ARCH-amd64}
  chmod +x /usr/local/bin/jq
fi
jq --version
