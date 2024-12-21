#!/bin/bash
# Check if openssl is installed
if ! command -v openssl > /dev/null; then
  echo "Installing openssl"
  if command -v apt-get > /dev/null; then
    apt-get update -qq > /dev/null
    apt-get install -y -qq --no-install-recommends openssl > /dev/null
  fi
  if command -v apk > /dev/null; then
    apk add --no-cache openssl > /dev/null
  fi
fi
openssl version
