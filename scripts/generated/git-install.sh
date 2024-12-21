#!/bin/bash
# Check if git is installed
if ! command -v git > /dev/null; then
  echo "Installing git"
  if command -v apt-get > /dev/null; then
    apt-get update -qq > /dev/null
    apt-get install -y -qq --no-install-recommends git > /dev/null
  elif command -v apk > /dev/null; then
    apk add git > /dev/null
  else
    echo "Unsupported OS. Can not install git"
  fi
fi
git version
