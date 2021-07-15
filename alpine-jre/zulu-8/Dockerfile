FROM alpine:3.13

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN wget --quiet https://cdn.azul.com/public_keys/alpine-signing@azul.com-5d5dc44c.rsa.pub -P /etc/apk/keys/ && \
    echo "https://repos.azul.com/zulu/alpine" >> /etc/apk/repositories && \
    apk --no-cache add zulu8-jre=8.0.282-r1

ENV JAVA_HOME=/usr/lib/jvm/zulu8-ca

# https://snyk.io/blog/best-practices-to-build-java-containers-with-docker/

# adds bash
# dumb-init for pid 1, see article above
# git so we can use it to pull configs
# curl to pull
# make for scripts
RUN apk add --no-cache dumb-init git curl bash make && \
    rm -rf /var/cache/apk/*

# https://github.com/Yelp/dumb-init
# adds in some things needed for java ui and reporting, like fonts
RUN apk add --no-cache xvfb fontconfig ttf-dejavu && \
    rm -rf /var/cache/apk/*

#sym link jar command so we can unjar
RUN ln -s /usr/lib/jvm/default-jvm/bin/jar /usr/bin/jar
