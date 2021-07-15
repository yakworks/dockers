FROM yakworks/alpine-builder:3.14

RUN apk add --no-cache git npm

RUN npm install npm@latest -g && \
    npm install n -g && \
    n 14
