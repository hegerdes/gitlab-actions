#!/bin/bash

# Check if ssh is installed
if ! command -v ssh > /dev/null; then
  echo "Installing ssh-client"
  if command -v apt-get > /dev/null; then
    apt-get update -qq > /dev/null
    DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends openssh-client > /dev/null
  fi
  if command -v apk > /dev/null; then
    apk add --no-cache openssh-client > /dev/null
  fi
  if command -v dnf > /dev/null; then
    dnf install -y openssh-clients > /dev/null
  fi
fi
ssh -V
