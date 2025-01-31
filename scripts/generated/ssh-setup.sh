#!/bin/bash

# Setting up SSH
eval $(ssh-agent -s) > /dev/null
echo "$SSH_PRIVATE_KEY" | base64 --decode | tr -d '\r' | ssh-add - > /dev/null
mkdir -p ~/.ssh
chmod 700 ~/.ssh
echo "$SSH_HOST_KEY" >> ~/.ssh/known_hosts
