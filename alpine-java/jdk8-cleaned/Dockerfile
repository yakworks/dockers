FROM frolvlad/alpine-java:jdk8-cleaned

USER root

# Some stuff from CIRCLECI examples and other
# 'shadow' allows the group and user adds below to work
RUN apk add --no-cache dumb-init git xvfb \
    sudo openssh-client ca-certificates tar gzip parallel \
    net-tools netcat-openbsd unzip zip bzip2 gnupg curl wget \
    shadow bash gawk sed grep bc coreutils \
    fontconfig ttf-dejavu \
    mysql-client && \
    rm -rf /var/cache/apk/*

# Use unicode
# RUN locale-gen C.UTF-8 || true
ENV LANG=C.UTF-8

# Set timezone to UTC by default and add circle user so its always here
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

WORKDIR /project

CMD ["/bin/bash"]
