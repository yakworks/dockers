#!/usr/bin/env bash
###
# builds a single dir. same tag is dir name 
# $1 - dir/tag name
# $2 - pass push to push it
# ./build-amd64.sh base

export DOCKER_DEFAULT_PLATFORM=linux/amd64  

set -e
export REGISTRY=yakworks
BASE_URL="$REGISTRY/bullseye"
TAG="$BASE_URL:${1}"

echo "**** BUILDING $TAG"

cd ${1}
#build it locally first
docker build -t $TAG .

if [[ "${2}" = "push" ]]; then
    # to only push the amd64 one
    docker push "$TAG"
    echo "pushed $TAG"
fi
