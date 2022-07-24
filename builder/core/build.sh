#!/usr/bin/env bash
export REGISTRY=yakworks
BASE_URL="$REGISTRY/builder"
TAG="$BASE_URL:core"

# on m1 this sets to build the intel x86 one.
# export DOCKER_DEFAULT_PLATFORM=linux/amd64  

#build it locally first
docker build -t $TAG .
# docker push "$TAG"

if [[ "${1}" = "push" ]]; then
    # does arm and amd builds
    docker buildx build \
    --push \
    --platform linux/arm64,linux/amd64 \
    --tag $TAG .

    echo "**** pushed $TAG"
fi
