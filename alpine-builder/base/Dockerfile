FROM alpine:3.14

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

USER root

# helpfull core tools
RUN apk add --no-cache git sudo openssh-client \
    net-tools netcat-openbsd zip bzip2 gnupg curl \
    shadow bash gawk bc coreutils grep make && \
    rm -rf /var/cache/apk/*

# install-git-secret:
RUN echo 'https://gitsecret.jfrog.io/artifactory/git-secret-apk/all/main' >> /etc/apk/repositories && \
  wget -O /etc/apk/keys/git-secret-apk.rsa.pub 'https://gitsecret.jfrog.io/artifactory/api/security/keypair/public/repositories/git-secret-apk' && \
  apk add --update --no-cache git-secret

WORKDIR /project