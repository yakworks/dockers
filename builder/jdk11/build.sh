#!/usr/bin/env bash
export REGISTRY=yakworks
BASE_URL="$REGISTRY/builder"
TAG="$BASE_URL:jdk11"

export DOCKER_DEFAULT_PLATFORM=linux/amd64  

#build it locally first
docker build -t $TAG .
docker push "$TAG"

# when zulu java is working on arm64 do this
# docker buildx build \
# --push \
# --platform linux/arm64,linux/amd64 \
# --tag $TAG .