#!/usr/bin/env bash
export REGISTRY=yakworks
BASE_URL="$REGISTRY/bullseye"
TAG="$BASE_URL:base"

# export DOCKER_DEFAULT_PLATFORM=linux/amd64  

#build it locally first
docker build -t $TAG .

docker buildx build \
--push \
--platform linux/arm64,linux/amd64 \
--tag $TAG .
