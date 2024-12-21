#!/bin/bash
# Check if skopeo is installed
if ! command -v skopeo > /dev/null; then
  echo "Installing skopeo"
  if command -v apt-get > /dev/null; then
    apt-get update -qq > /dev/null
    apt-get install -y -qq --no-install-recommends skopeo > /dev/null
  fi
  if command -v apk > /dev/null; then
    apk add --no-cache skopeo > /dev/null
  fi
fi
skopeo --version
