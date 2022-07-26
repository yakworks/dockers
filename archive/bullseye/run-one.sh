#!/usr/bin/env bash
cd ${1}
docker run -it --rm -v $PWD:/project yakworks/bullseye:${1} /bin/bash