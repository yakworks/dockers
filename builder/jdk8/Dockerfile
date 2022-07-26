ARG REGISTRY=yakworks
FROM $REGISTRY/builder:core

# parallel - for parralel processing add about 15mb compressed
# dumb-init - see https://github.com/Yelp/dumb-init
# fontconfig ttf-dejavu - reporting fonts for jasper adds about 10mb

# java
RUN wget --quiet https://cdn.azul.com/public_keys/alpine-signing@azul.com-5d5dc44c.rsa.pub -P /etc/apk/keys/ && \
    echo "https://repos.azul.com/zulu/alpine" >> /etc/apk/repositories && \
    apk --no-cache add zulu8-jdk

ENV JAVA_HOME=/usr/lib/jvm/zulu8-ca

# misc
RUN apk add --no-cache \
    parallel \
    dumb-init \
    # xvfb \
    fontconfig \
    ttf-dejavu \
    && rm -rf /var/cache/apk/*

# sym link the jar command
# RUN ln -s /usr/lib/jvm/default-jvm/bin/jar /usr/bin/jar
