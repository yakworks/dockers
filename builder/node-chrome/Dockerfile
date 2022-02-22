ARG REGISTRY
FROM $REGISTRY/builder:k8s

RUN apk add --no-cache git npm

RUN npm install npm@latest -g && \
    npm install n -g && \
    n 16

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