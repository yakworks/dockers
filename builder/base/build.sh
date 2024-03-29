#!/usr/bin/env bash
export REGISTRY=yakworks
BASE_URL="$REGISTRY/builder"
TAG="$BASE_URL:base"
TAG2="$BASE_URL:3.16"
# export DOCKER_DEFAULT_PLATFORM=linux/amd64  

#build it locally first
docker build -t $TAG .
docker tag "$TAG" "$TAG2"
# push, when arm working do the build x
# docker push "$TAG"

if [[ "${1}" = "push" ]]; then
    # does arm and amd builds
    docker buildx build \
    --push \
    --platform linux/arm64,linux/amd64 \
    --tag $TAG --tag $TAG2 .

    echo "**** pushed $TAG"
fi
