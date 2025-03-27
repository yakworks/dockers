#!/usr/bin/env bash

export DOCKER_DEFAULT_PLATFORM=linux/amd64
docker build -t yakworks/mssql-server:2017-jdk8-latest .
# docker push yakworks/mssql-server:2017-jdk8-latest