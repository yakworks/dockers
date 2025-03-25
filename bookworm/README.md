The debian bullseye images used in pipelines for buidling and deploying

These images succesively build on one another. size mentioned is compressed. 
They all inherit the WORKDIR=/root/project from base and none of them have CMD or ENTRYPOINT 

| Image             | FROM         | Desc                                                        | max size |
| ----------------- | -------------- | ------------------------------------------------------------| -------- |
| __bookworm:base__ | _debian:bookworm-slim_  | has the basics like git, curl etc..                 | 60 MB     |
| __bookworm:core__  | _bookworm:base_ | adds in languages and utils like python, node, kubernetes, gpg, sops etc. | 162 MB    |
| __bookworm:jre17__  | ... | zulu jre 17 with minimum for prod deploy dumb-init, make and fonts  | 106 MB    |
| __bookworm:postgres14_jdk11__  | _postgres:14_ | jdk 11 on psql14, has basic build tools make, git etc  | 300 MB    |

see https://unix.stackexchange.com/q/748633

For multiplatform builds (so both Mac ARM and Intel work)
```
docker buildx create --use --platform=linux/arm64,linux/amd64 --name multi-platform-builder
docker buildx inspect --bootstrap
```

then run `make bullseye/jdk17 push` for example


