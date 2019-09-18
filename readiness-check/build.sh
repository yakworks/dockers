#!/usr/bin/env bash
docker build -t yakworks/readiness-check .
docker push yakworks/readiness-check
