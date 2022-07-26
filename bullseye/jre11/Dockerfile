FROM debian:bullseye-slim

# KEEP SLIM For deploying spring and grails server apps

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# https://snyk.io/blog/best-practices-to-build-java-containers-with-docker/

# adds bash
# dumb-init for pid 1, see article above
# git so we can use it to pull configs
# make for scripts
# https://github.com/Yelp/dumb-init
# adds in some things needed for java ui and reporting, like fonts
RUN apt-get -qq update && \
    apt-get -qq -y --no-install-recommends install \
    dumb-init \
    ca-certificates \
    # git \
    # coreutils \
    # bash \
    make \
    fontconfig \
    fonts-dejavu \
    # xvfb \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ARG ZULU_REPO_VER=1.0.0-3
ARG ZULU_PACKAGE=zulu11-jre
ARG ZULU_VERSION=11.0.15

# copied from https://github.com/zulu-openjdk/zulu-openjdk/blob/master/11-latest/Dockerfile
RUN apt-get -qq update && \
    apt-get -qq -y --no-install-recommends install gnupg software-properties-common locales curl tzdata && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9 && \
    curl -sLO https://cdn.azul.com/zulu/bin/zulu-repo_${ZULU_REPO_VER}_all.deb && dpkg -i zulu-repo_${ZULU_REPO_VER}_all.deb && \
    apt-get -qq update && \
    apt-get -qq -y dist-upgrade && \
    mkdir -p /usr/share/man/man1 && \
    echo "Package: zulu11-*\nPin: version 11.0.15-*\nPin-Priority: 1001" > /etc/apt/preferences && \
    apt-get -qq -y --no-install-recommends install ${ZULU_PACKAGE}=${ZULU_VERSION}-* && \
    apt-get -qq -y purge gnupg software-properties-common curl && \
    apt -y autoremove && \
    rm -rf /var/lib/apt/lists/* zulu-repo_${ZULU_REPO_VER}_all.deb

ENV JAVA_HOME=/usr/lib/jvm/zulu11

