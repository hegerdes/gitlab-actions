#!/bin/bash
# Installing core tools
if command -v apt-get > /dev/null; then
  if [ ! -z ${HTTP_PROXY+x} ]; then
    echo "Acquire::http::Proxy \"${HTTP_PROXY}\";" >> /etc/apt/apt.conf
  fi
  if [ ! -z ${HTTPS_PROXY+x} ]; then
    echo "Acquire::https::Proxy \"${HTTPS_PROXY}\";" >> /etc/apt/apt.conf
  fi
  apt-get update -qq > /dev/null
  apt-get install -y -qq --no-install-recommends \
    curl jq unzip ca-certificates tar gzip > /dev/null
else
  echo "The apt package manager does not exist. Skipping core tool install."
fi
