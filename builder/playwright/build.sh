#!/usr/bin/env bash
TAG="yakworks/playwright:1.22.2"

# only need the one for circle, doesnt need to be arm
export DOCKER_DEFAULT_PLATFORM=linux/amd64

#build it locally first
docker build -t $TAG .
docker push $TAG
# docker buildx build \
# --push \
# --platform linux/arm64,linux/amd64 \
# --tag $TAG .
