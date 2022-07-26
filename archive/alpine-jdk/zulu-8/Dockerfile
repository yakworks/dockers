FROM alpine:3.11

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

USER root

RUN wget --quiet https://cdn.azul.com/public_keys/alpine-signing@azul.com-5d5dc44c.rsa.pub -P /etc/apk/keys/ && \
    echo "https://repos.azul.com/zulu/alpine" >> /etc/apk/repositories && \
    apk --no-cache add zulu8-jdk

ENV JAVA_HOME=/usr/lib/jvm/zulu8-ca

# adds in some things needed for java ui and reporting, like fonts
RUN apk add --no-cache dumb-init xvfb fontconfig ttf-dejavu && \
    rm -rf /var/cache/apk/*

#sym link jar command
RUN ln -s /usr/lib/jvm/default-jvm/bin/jar /usr/bin/jar

# Set timezone to UTC by default and add circle user so its always here
# RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

WORKDIR /project