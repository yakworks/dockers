FROM postgres:14

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

#--- BASE ---
RUN apt-get -qq update && \
    apt-get -qq -y --no-install-recommends install \
    bash make curl coreutils git gnupg openssh-client gawk ca-certificates zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/\* /tmp/\* /var/tmp/*

#--- JDK11 ---
ARG ZULU_REPO_VER=1.0.0-3

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
    apt-get -qq -y --no-install-recommends install zulu11-jdk=11.0.15-* && \
    apt -y autoremove && \
    rm -rf /var/lib/apt/lists/* zulu-repo_${ZULU_REPO_VER}_all.deb

ENV JAVA_HOME=/usr/lib/jvm/zulu11

# adds in some things needed for java ui and reporting, like fonts
# RUN apk add --no-cache dumb-init xvfb fontconfig ttf-dejavu && \
#     rm -rf /var/cache/apk/*

# sym link the jar command
# RUN ln -s /usr/lib/jvm/default-jvm/bin/jar /usr/bin/jar
