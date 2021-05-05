#!/bin/bash

git pull
export COMPOSE_OPTIONS="-e SSH_AUTH_SOCK"
export DOCKER_BUILDKIT=1 # or configure in daemon.json
export COMPOSE_DOCKER_CLI_BUILD=1
docker-compose up -d --build