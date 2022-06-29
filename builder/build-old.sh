#!/usr/bin/env bash
export REGISTRY=yakworks
BASE_URL=$REGISTRY/builder

export DOCKER_DEFAULT_PLATFORM=linux/amd64  

docker build -t "$BASE_URL:3.14" base/.
docker tag "$BASE_URL:3.14" "$BASE_URL:base"
docker push "$BASE_URL:3.14"
docker push "$BASE_URL:base"

for t in k8s jdk8 jdk11 jdk8-slim repo-job node node-jdk8 node-jdk11 node-chrome postgres14-jdk8; do
    echo "building ${BASE_URL}:${t}"
    docker build --build-arg REGISTRY=$REGISTRY -t "${BASE_URL}:${t}" "${t}/."
    docker push "${BASE_URL}:${t}"
done

# To only run one or 2 do this
# for t in repo-job; do
#     echo "building ${BASE_URL}:${t}"
#     docker build --build-arg REGISTRY=$REGISTRY -t "${BASE_URL}:${t}" "${t}/."
#     docker push "${BASE_URL}:${t}"
# done
