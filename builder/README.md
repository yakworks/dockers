The Alpine images used in pipelines for buidling and deploying

if its `skinny` then its doesn't have the kubectl or helm and is based on the base

the v2 is current version and is only assigning an arbitrary version to the collection of versions for installed packages
if a build will potentially break something

These images succesively build on one another. size mentioned is compressed. 
They all inherit the WORKDIR=/project from base and none of them have CMD or ENTRYPOINT 

| Image             | Parent         | Desc                                                        | max size |
| ----------------- | -------------- | ------------------------------------------------------------| -------- |
| __builder/base__  | _alpine:3.16_  | has the basics like git, curl etc..                         | 30mb     |
| __builder/core__  | _builder/base_ | adds in languages and utils like python, node, kubernetes, gpg, sops etc. | 100mb    |
| __builder/jdk8__  | _builder/core_ | zulu java 8 with parralel and dumb-init | 165mb    |
| __builder/jdk11__  | _builder/core_ | zulu java 11 with parralel and dumb-init | 250mb    |
| __builder/jre11__  | _builder/core_ | zulu java jre 11 with parralel and dumb-init | 250mb    |