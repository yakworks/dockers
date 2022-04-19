#!/usr/bin/env bash
export REGISTRY=yakworks
BASE_URL=$REGISTRY/builder

# export DOCKER_DEFAULT_PLATFORM=linux/amd64  

docker build -t "$BASE_URL:3.14" base/.
docker tag "$BASE_URL:3.14" "$BASE_URL:base"
# docker push "$BASE_URL:3.14"
# docker push "$BASE_URL:base"

# fat
for t in jdk8-slim k8s jdk8 node; do
    echo "building ${BASE_URL}:${t}"
    docker build --build-arg REGISTRY=$REGISTRY -t "${BASE_URL}:${t}" "${t}/."
    # docker push "${BASE_URL}:${t}"
done

# To only run one or 2 do this
# for t in k8s node; do
#     echo "building ${BASE_URL}:${t}"
#     docker build --build-arg REGISTRY=$REGISTRY -t "${BASE_URL}:${t}" "${t}/."
#     docker push "${BASE_URL}:${t}"
# done
