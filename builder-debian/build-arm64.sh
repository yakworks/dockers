#!/usr/bin/env bash
export REGISTRY=yakworks
BASE_URL=$REGISTRY/builder

docker buildx create --use

# export DOCKER_DEFAULT_PLATFORM=linux/amd64  
buildx="docker buildx build --platform linux/amd64,linux/arm64"

cmd="$buildx --push -t '$BASE_URL:3.14' -t '$BASE_URL:base' base/."
eval $cmd

# for t in k8s jdk8 jdk8-slim node node-chrome postgres14-jdk8; do
for t in k8s jdk8 jdk8-slim node node-chrome; do
    echo "building ${BASE_URL}:${t}"
    cmd="$buildx --build-arg REGISTRY=$REGISTRY --push -t '${BASE_URL}:${t}' ${t}/."
    eval $cmd
done

# docker buildx prune -f