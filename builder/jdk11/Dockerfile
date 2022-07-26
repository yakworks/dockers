FROM yakworks/builder:core

# parallel - for parralel processing add about 15mb compressed
# dumb-init - see https://github.com/Yelp/dumb-init
# fontconfig ttf-dejavu - reporting fonts for jasper adds about 10mb

# java
RUN wget -P /etc/apk/keys/ \
    https://cdn.azul.com/public_keys/alpine-signing@azul.com-5d5dc44c.rsa.pub && \
    echo "https://repos.azul.com/zulu/alpine" >> /etc/apk/repositories && \
    apk update && \
    apk --no-cache add zulu11-jdk

ENV JAVA_HOME=/usr/lib/jvm/zulu11-ca

# misc
RUN apk add --no-cache \
    parallel \
    dumb-init \
    # xvfb \
    fontconfig \
    ttf-dejavu \
    && rm -rf /var/cache/apk/*