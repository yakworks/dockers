FROM mcr.microsoft.com/mssql/server:2019-latest

USER root

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
ARG ZULU_REPO_VER=1.0.0-3
ARG ZULU_REPO_SHA256=d08d9610c093b0954c6b278ecc628736e303634331641142fa5096396201f49c

RUN apt-get -qq update && \
    apt-get -qq -y --no-install-recommends install gnupg software-properties-common locales curl tzdata && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9 && \
    curl -sLO https://cdn.azul.com/zulu/bin/zulu-repo_${ZULU_REPO_VER}_all.deb && \
    echo "${ZULU_REPO_SHA256} zulu-repo_${ZULU_REPO_VER}_all.deb" | sha256sum --strict --check - && \
    dpkg -i zulu-repo_${ZULU_REPO_VER}_all.deb && \
    apt-get -qq update && \
    echo "Package: zulu8-*\nPin: version 8.0.442-*\nPin-Priority: 1001" > /etc/apt/preferences && \
    apt-get -qq -y --no-install-recommends install zulu8-jdk=8.0.442-*

RUN apt-get -qq -y purge --auto-remove software-properties-common
RUN rm -rf /var/lib/apt/lists/* zulu-repo_${ZULU_REPO_VER}_all.deb

ENV JAVA_HOME=/usr/lib/jvm/zulu8

RUN javac -version; \
    java -version

RUN apt-get -y update && apt-get -y install \
    make \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

RUN ln -s /opt/mssql-tools18/bin/sqlcmd /bin/sqlcmd

# USER mssql
# WORKDIR /project

