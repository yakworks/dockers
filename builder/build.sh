#!/usr/bin/env bash

for t in base k8s jdk8 jdk11 node node-jdk8 node-jdk11; do
    (cd "${t}" && ./build.sh)
done

