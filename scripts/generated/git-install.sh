#!/bin/bash

# Check if git is installed
if ! command -v git > /dev/null; then
  echo "Installing git"
  if command -v apt-get > /dev/null; then
    apt-get update -qq > /dev/null
    DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends git > /dev/null
  fi
  if command -v apk > /dev/null; then
    apk add git > /dev/null
  fi
  if command -v dnf > /dev/null; then
    dnf install -y git > /dev/null
  fi
fi
git version
