#!/bin/bash

# Check if docker-credential-ecr-login cli is installed
if ! command -v docker-credential-ecr-login > /dev/null; then
  echo "Installing docker-credential-ecr-login"
  echo "You can set the desired version via AWS_ECR_CREDENTIAL_HELPER_VERSION_TAG. Default is latest"
  AWS_ECR_CREDENTIAL_HELPER_DEFAULT_VERSION_TAG=$(curl -sL https://api.github.com/repos/awslabs/amazon-ecr-credential-helper/releases/latest | jq -r .tag_name)
  AWS_ECR_CREDENTIAL_HELPER_DEFAULT_VERSION=${AWS_ECR_CREDENTIAL_HELPER_VERSION_TAG-$AWS_ECR_CREDENTIAL_HELPER_DEFAULT_VERSION_TAG}
  # Fix version beginning with "v"
  if echo "${AWS_ECR_CREDENTIAL_HELPER_DEFAULT_VERSION}" | grep -q "v"; then
    AWS_ECR_CREDENTIAL_HELPER_DEFAULT_VERSION="${AWS_ECR_CREDENTIAL_HELPER_DEFAULT_VERSION:1}"
  fi
  if [ "$(uname -m)" = "x86_64" ]; then
    ARCH=amd64
  elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH=arm64
  else
    echo "Unknown system arch. Default to amd64"
  fi
  curl -sL --fail --output /usr/local/bin/docker-credential-ecr-login https://amazon-ecr-credential-helper-releases.s3.us-east-2.amazonaws.com/$AWS_ECR_CREDENTIAL_HELPER_DEFAULT_VERSION/linux-${ARCH-amd64}/docker-credential-ecr-login
  chmod +x /usr/local/bin/docker-credential-ecr-login
fi
docker-credential-ecr-login version
