The debian bullseye images used in pipelines for buidling and deploying

These images succesively build on one another. size mentioned is compressed. 
They all inherit the WORKDIR=/root/project from base and none of them have CMD or ENTRYPOINT 

| Image             | FROM         | Desc                                                        | max size |
| ----------------- | -------------- | ------------------------------------------------------------| -------- |
| __bullseye:base__ | _debian:bullseye-slim_  | has the basics like git, curl etc..                 | 60 MB     |
| __bullseye:core__  | _bullseye:base_ | adds in languages and utils like python, node, kubernetes, gpg, sops etc. | 162 MB    |
| __bullseye:jdk11__  | _bullseye:core_ | zulu java 11 with parralel and dumb-init | 309 MB    |
| __bullseye:jre11__  | ... | zulu jre 11 with minimum for prod deploy dumb-init, make and fonts  | 106 MB    |
| __bullseye:postgres14_jdk11__  | _postgres:14_ | jdk 11 on psql14, has basic build tools make, git etc  | 300 MB    |
