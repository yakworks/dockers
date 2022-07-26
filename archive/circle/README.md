These are images based on the circles cimg dockers.
Here is their base version for example. https://github.com/CircleCI-Public/cimg-base
and https://hub.docker.com/r/cimg/base
since its circle we set the user back to root and the WORKDIR back to /project intead of using the circleci user. 

They contain most of what we need. we modify them to make default user work and add few things lik
sops, kubernetes etc..