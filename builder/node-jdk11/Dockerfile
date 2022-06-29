FROM yakworks/builder:node

# parallel
RUN apk add --no-cache parallel && \
    rm -rf /var/cache/apk/*

# java
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN wget --quiet https://cdn.azul.com/public_keys/alpine-signing@azul.com-5d5dc44c.rsa.pub -P /etc/apk/keys/ && \
    apk --repository https://repos.azul.com/zulu/alpine --no-cache add zulu11-jdk~=11.0.15 tzdata

ENV JAVA_HOME=/usr/lib/jvm/zulu11-ca

# adds in some things needed for java ui and reporting, like fonts
RUN apk add --no-cache dumb-init xvfb fontconfig ttf-dejavu && \
    rm -rf /var/cache/apk/*
