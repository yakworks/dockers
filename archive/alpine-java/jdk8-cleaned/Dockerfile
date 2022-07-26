FROM frolvlad/alpine-java:jdk8-cleaned

USER root

# adds in some things needed for java ui and reporting, like fonts
RUN apk add --no-cache dumb-init xvfb fontconfig ttf-dejavu && \
    rm -rf /var/cache/apk/*

# Use unicode
# RUN locale-gen C.UTF-8 || true
ENV LANG=C.UTF-8

# Set timezone to UTC by default and add circle user so its always here
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

WORKDIR /project
