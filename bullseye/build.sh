#!/usr/bin/env bash
# export DOCKER_DEFAULT_PLATFORM=linux/amd64  

for t in base k8s jdk11 node node-jdk11; do
    (cd "${t}" && ./build.sh)
done
