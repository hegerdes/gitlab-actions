#!/bin/bash
# Check if terraform is installed
if ! command -v terraform > /dev/null; then
  echo "Installing terraform!"
  echo "You can set the desired version via TERRAFORM_VERSION. Default is latest"
  if [ "$(uname -m)" = "x86_64" ]; then
    ARCH=amd64
  elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH=arm64
  else
    echo "Unknown system arch. Default to amd64"
  fi
  TERRAFORM_DEFAULT_VERSION=$(curl -sL https://api.github.com/repos/hashicorp/terraform/releases/latest | jq -r .name)
  TERRAFORM_VERSION="${TERRAFORM_VERSION-$TERRAFORM_DEFAULT_VERSION}"
  # Fix version beginning with "v"
  if echo "${TERRAFORM_VERSION}" | grep -q "v"; then
    TERRAFORM_VERSION="${TERRAFORM_VERSION:1}"
  fi
  curl -sL --fail --output /tmp/terraform.zip "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${ARCH-amd64}.zip"
  unzip /tmp/terraform.zip -d /usr/bin/ > /dev/null
fi
terraform --version
