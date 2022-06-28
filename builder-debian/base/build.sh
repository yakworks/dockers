#!/usr/bin/env bash

# docker buildx create --use

docker build -t yakworks/bullseye:base .

docker buildx build \
--push \
--platform linux/arm64,linux/amd64 \
--tag yakworks/bullseye:base .
