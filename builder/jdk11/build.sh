#!/usr/bin/env bash
export REGISTRY=yakworks
BASE_URL="$REGISTRY/builder"
TAG="$BASE_URL:jdk11"

export DOCKER_DEFAULT_PLATFORM=linux/amd64  
#build it locally first
docker build -t $TAG .

if [[ "${1}" = "push" ]]; then
    # only work for x86 right now, 
    # push, when zulu has arm working on alpine do the buildx like others
    docker push "$TAG"
    echo "**** pushed $TAG"
fi
