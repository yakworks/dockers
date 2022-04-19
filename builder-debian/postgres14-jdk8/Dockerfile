FROM postgres:14-alpine

# ADDS JAVA INTO POSTGRESS TO MAKE CI EASIER TO BUILD DB WITH GRADLE
# parallel
RUN apk add --no-cache parallel && \
    rm -rf /var/cache/apk/*

# java
RUN wget --quiet https://cdn.azul.com/public_keys/alpine-signing@azul.com-5d5dc44c.rsa.pub -P /etc/apk/keys/ && \
    echo "https://repos.azul.com/zulu/alpine" >> /etc/apk/repositories && \
    apk --no-cache add zulu8-jdk

ENV JAVA_HOME=/usr/lib/jvm/zulu8-ca

RUN apk add --no-cache make curl git \
    zip coreutils ncurses && \
    rm -rf /var/cache/apk/*

# adds in some things needed for java ui and reporting, like fonts
# RUN apk add --no-cache dumb-init xvfb fontconfig ttf-dejavu && \
#     rm -rf /var/cache/apk/*

# sym link the jar command
# RUN ln -s /usr/lib/jvm/default-jvm/bin/jar /usr/bin/jar
