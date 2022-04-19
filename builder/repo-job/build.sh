#!/usr/bin/env bash
export REGISTRY=yakworks
BASE_URL=$REGISTRY/builder
NAME=repo-job

docker build --build-arg REGISTRY=$REGISTRY -t "${BASE_URL}:${NAME}" .
docker push "${BASE_URL}:${NAME}"

