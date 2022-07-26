#!/usr/bin/env bash
###
# builds a single dir. same tag is dir name 
# $1 - dir/tag name
# $2 - pass push to do the buildx and push
# ./build-one.sh base
# 
# set if on M1 for amd/64
# export DOCKER_DEFAULT_PLATFORM=linux/amd64  
#

set -e
export REGISTRY=yakworks
BASE_URL="$REGISTRY/circle"
TAG="$BASE_URL:${1}"

echo "**** BUILDING $TAG"

cd ${1}
#build it locally first
docker build -t $TAG .
# to only push the amd64 one
docker push "$TAG"

# if [[ "${2}" = "push" ]]; then
#     # does arm and amd builds
#     docker buildx build \
#     --push \
#     --platform linux/arm64,linux/amd64 \
#     --tag $TAG .

#     echo "**** pushed $TAG"
# fi
