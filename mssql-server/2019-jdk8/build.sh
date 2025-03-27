#!/usr/bin/env bash

export DOCKER_DEFAULT_PLATFORM=linux/amd64
docker build -t yakworks/mssql-server:2019-jdk8 .
docker push yakworks/mssql-server:2019-jdk8