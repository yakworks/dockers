#!/usr/bin/env bash
export REGISTRY=yakworks
BASE_URL="$REGISTRY/zulu"
TAG="$BASE_URL:11-jre-alpine"

export DOCKER_DEFAULT_PLATFORM=linux/amd64  

#build it locally first
docker build -t $TAG .
# push, when arm working do the build x
docker push "$TAG"

# when we can install arm do this so works on mac M1
# docker buildx build \
# --push \
# --platform linux/arm64,linux/amd64 \
# --tag $TAG .