FROM postgres:14-alpine

RUN apk add --no-cache \
    bash make curl git coreutils ncurses parallel wget && \
    rm -rf /var/cache/apk/*

# java
RUN wget --quiet https://cdn.azul.com/public_keys/alpine-signing@azul.com-5d5dc44c.rsa.pub -P /etc/apk/keys/ && \
    echo "https://repos.azul.com/zulu/alpine" >> /etc/apk/repositories && \
    apk --no-cache add zulu8-jdk

ENV JAVA_HOME=/usr/lib/jvm/zulu8-ca

