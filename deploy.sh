#!/bin/bash

git pull
eval "$(ssh-agent -s)"
#ssh-add /home/kbocinsky/.ssh/id_ed25519
export DOCKER_BUILDKIT=1 # or configure in daemon.json
export COMPOSE_DOCKER_CLI_BUILD=1
docker-compose up -d --build