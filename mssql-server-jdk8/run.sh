#!/usr/bin/env bash

export DOCKER_DEFAULT_PLATFORM=linux/amd64
docker run --rm -it \
-e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=123Foobar' \
-p 1433:1433 \
yakworks/mssql-server:2019-jdk8