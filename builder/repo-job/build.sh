#!/usr/bin/env bash
export REGISTRY=yakworks
BASE_URL=$REGISTRY/builder
TAG=repo-job-1

export DOCKER_DEFAULT_PLATFORM=linux/amd64  

docker build --build-arg REGISTRY=$REGISTRY -t "${BASE_URL}:${TAG}" .
docker push "${BASE_URL}:${TAG}"

