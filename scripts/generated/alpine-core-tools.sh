#!/bin/bash

# Installing core tools
if command -v apk > /dev/null; then
  apk add --no-cache curl jq unzip tar gzip gcompat > /dev/null
else
  echo "The apk package manager does not exist. Skipping core tool install."
fi
