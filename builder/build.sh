#!/usr/bin/env bash
export REGISTRY=yakworks
BASE_URL=$REGISTRY/builder

docker build -t "$BASE_URL:3.14" base/.
docker tag "$BASE_URL:3.14" "$BASE_URL:base"
docker push "$BASE_URL:3.14"
docker push "$BASE_URL:base"

for t in k8s jdk8 jdk8-slim fat node14 node14-chrome; do
    echo "building ${BASE_URL}:${t}"
    docker build --build-arg REGISTRY=$REGISTRY -t "${BASE_URL}:${t}" "${t}/."
    docker push "${BASE_URL}:${t}"
done
