FROM zenika/alpine-chrome:with-puppeteer

USER root
RUN apk add openjdk8
# Some stuff from CIRCLECI examples and other
# 'shadow' allows the group and user adds below to work
RUN apk add --no-cache dumb-init git xvfb \
    sudo openssh-client ca-certificates tar gzip parallel \
    net-tools netcat-openbsd unzip zip bzip2 gnupg curl wget \
    shadow bash gawk sed grep bc coreutils \
    fontconfig ttf-dejavu \
    mysql-client && \
    rm -rf /var/cache/apk/*

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8


# Installs latest Chromium package
RUN apk update && apk upgrade && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    apk add --no-cache bash chromium@edge nss@edge

# This line is to tell karma-chrome-launcher where
# chromium was downloaded and installed to.
ENV CHROME_BIN /usr/bin/chromium-browser

# Tell Puppeteer to skip installing Chrome.
# We'll be using the installed package instead.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

# Telling node-sass which pre-built binary to fetch.
# This way we don't need rebuilding node-sass each time!
ENV SASS_BINARY_NAME=linux-x64-67


RUN npm install -g npm \
    && npm install -g coffeescript \
    && npm install -g grunt-cli \
    && git --version && npm -v && node -v

#Install Gradle Version: 3.5 manually, here for reference
 RUN curl --silent --show-error --location --fail --retry 3 --output /tmp/gradle.zip \
    https://services.gradle.org/distributions/gradle-3.5-bin.zip \
    && unzip -d /opt /tmp/gradle.zip \
    && rm /tmp/gradle.zip \
    && ln -s /opt/gradle-* /opt/gradle \
    && /opt/gradle/bin/gradle -version