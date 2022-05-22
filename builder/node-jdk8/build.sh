#!/usr/bin/env bash
export REGISTRY=yakworks
BASE_URL=$REGISTRY/builder
NAME=node-jdk8

# only needed when doing this on Mac Silicon(m1)
export DOCKER_DEFAULT_PLATFORM=linux/amd64  

docker build --build-arg REGISTRY=$REGISTRY -t "${BASE_URL}:${NAME}" .
docker push "${BASE_URL}:${NAME}"

