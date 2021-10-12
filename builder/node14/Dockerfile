ARG REGISTRY
FROM $REGISTRY/builder:k8s

RUN apk add --no-cache npm

RUN npm install npm@latest -g && \
    npm install n -g && \
    n 14
