#!/usr/bin/env bash
# export DOCKER_DEFAULT_PLATFORM=linux/amd64  

for t in base core helm jdk11 jre11 postgres14-jdk11; do
    ./build-one.sh "${t}" push
done

# for t in base core helm jdk11 jre11 postgres14-jdk11; do
#     ./build-one.sh "${t}" push
# done
