#!/usr/bin/env bash
docker build -t yakworks/mssql-server:2019 .
docker push yakworks/mssql-server:2019
