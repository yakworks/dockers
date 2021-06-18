FROM node:lts-alpine3.13

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


# Some stuff from CIRCLECI examples and other
# 'shadow' allows the group and user adds below to work
RUN apk add --no-cache git sudo openssh-client parallel \
    net-tools netcat-openbsd zip bzip2 gnupg curl \
    shadow bash gawk bc coreutils make && \
    rm -rf /var/cache/apk/*