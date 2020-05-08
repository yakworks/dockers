FROM yakworks/alpine-java:jdk8-builder

# add stuff for node/chrome etc
ARG BUILD_DATE
ARG VCS_REF

# Installs latest Chromium package.
RUN apk update && apk upgrade && \
    apk add --no-cache \
    libstdc++ \
    chromium \
    harfbuzz \
    nss \
    freetype \
    ttf-freefont \
    && rm -rf /var/cache/* \
    && mkdir /var/cache/apk

# Add Chrome as a user
RUN mkdir -p /usr/src/app \
    && adduser -D chrome \
    && chown -R chrome:chrome /usr/src/app
# Run Chrome as non-privileged
# USER chrome
# WORKDIR /usr/src/app

ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_PATH=/usr/lib/chromium/

# install edge repo so we can get up to date node and yarn
# RUN echo @edge http://nl.alpinelinux.org/alpine/edge/community > /etc/apk/repositories \
#     && echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories 

# as of this run this will install 
# nodejs@edge (12.15.0-r1)
# npm@edge (12.15.0-r1)
# yarn@edge (1.22.0-r0)

# RUN apk add --no-cache nodejs@edge nodejs-npm@edge yarn@edge \
#     && apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing wqy-zenhei \
# 	&& rm -rf /var/lib/apt/lists/* \
#     /var/cache/apk/* \
#     /usr/share/man \
#     /tmp/*

## add node
RUN apk update && apk add --no-cache nodejs nodejs-npm yarn \
	&& rm -rf /var/lib/apt/lists/* \
    /var/cache/apk/* \
    /usr/share/man \
    /tmp/*

