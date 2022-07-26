# Docker images with Makefile

This is a collection of dockerfiles for CI/CD development and which are running in our kubernetes_ cluster.

Uses Makefile whenever possible. Alos setup to keep both `arm64` (new Mac silicon) and `amd64` (Intel)
Structure follows the org/repo:version naming for tags but with directories driving the tag. \
For example the `bullseye/base` dir in this project publishes to [this docker hub](https://hub.docker.com/repository/docker/yakworks/bullseye) as `yakworks/bullseye:base`. \

- `make bullseye/base`, `make bullseye/core`, etc... too build the base images locally. This will not push it. 
- `make bullseye/base push`, `make bullseye/jdk11 push`, etc.. will build and push the images in both amd64 and arm64 platforms
- `make bullseye.build-all` will rebuild all of them, `make bullseye.build-all push` will build and push
- `make bulder.build-all` will rebuild all of them, `make bullseye.build-all push` will build and push.
  the java ones will only support amd64 platform

~~~yaml
├── alpine-jre         # base image for spring/java deployments
│   ├── 11
│   └── 8
├── archive           # old stuff for reference
│
├── builder             # Alpine (mostly) builders for dev and CI 
│   ├── base            # base with core installs (make, bash, etc..)
│   ├── core            # adds python, node, sops and kubectl to base
│   ├── jdk11           # java jdk
│   ├── jdk8            # java jdk
│   ├── jre11           # alpine jre for testing
│   ├── playwright      # playwright base with installs for CI
│   ├── postgres14-jdk8 # postgress with java installed
│   └── repo-job        # used for kubernets jobs, allows env vars specifying what git to down load and run
│ 
├── bullseye              # debian with amd64 and arm64 (mac silicon) images published
│   ├── base              # base built on debian 
│   ├── core              # adds python, node, sops and kubectl to base
│   ├── docker            # for building docker images
│   ├── docker-jdk11      # docker install with java
│   ├── helm              # help ontop of core
│   ├── jdk11             # java jdk
│   ├── jre11             # java jdk
│   ├── postgres14-jdk11  # postgres with java
│   
├── mssql-server # sql server for linux for CI testing. 
├── nfs-server # baseline nfs server used on kub
├── nginx-python # base image for quick python nginx server
└── readiness-check
~~~
