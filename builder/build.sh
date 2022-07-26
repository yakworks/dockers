#!/usr/bin/env bash

# for t in base core jdk8 jdk11 jre11 postgres14-jdk8; do
#     (cd "${t}" && ./build.sh push)
# done

for t in base core jdk11 jre11 postgres14-jdk8; do
    (cd "${t}" && ./build.sh push)
done