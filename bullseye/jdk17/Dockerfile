ARG REGISTRY=yakworks
FROM $REGISTRY/bullseye:core

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
ARG ZULU_REPO_VER=1.0.0-3
ARG ZULU_REPO_SHA256=d08d9610c093b0954c6b278ecc628736e303634331641142fa5096396201f49c

# copied from https://github.com/zulu-openjdk/zulu-openjdk/blob/master/ubuntu/17-latest/Dockerfile
# dont remove gpg or curl
RUN apt-get -qq update && \
    apt-get -qq -y --no-install-recommends install software-properties-common locales tzdata && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9 && \
    curl -sLO https://cdn.azul.com/zulu/bin/zulu-repo_${ZULU_REPO_VER}_all.deb && \
    echo "${ZULU_REPO_SHA256} zulu-repo_${ZULU_REPO_VER}_all.deb" | sha256sum --strict --check - && \
    dpkg -i zulu-repo_${ZULU_REPO_VER}_all.deb && \
    apt-get -qq update && \
    echo "Package: zulu17-*\nPin: version 17.0.14-*\nPin-Priority: 1001" > /etc/apt/preferences && \
    apt-get -qq -y --no-install-recommends install zulu17-jdk=17.0.14-* && \
    apt-get -qq -y purge --auto-remove software-properties-common && \
    rm -rf /var/lib/apt/lists/* zulu-repo_${ZULU_REPO_VER}_all.deb

ENV JAVA_HOME=/usr/lib/jvm/zulu17