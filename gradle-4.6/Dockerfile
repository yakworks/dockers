FROM gradle:4.6-alpine

# Some stuff from CIRCLECI examples and other
# 'shadow' allows the group and user adds below to work
USER root
RUN apk add --no-cache dumb-init git xvfb \
    sudo openssh-client ca-certificates tar gzip parallel \
    net-tools netcat-openbsd unzip zip bzip2 gnupg curl wget \
    shadow bash gawk sed grep bc coreutils


#add fontconfig and ttf-dejavu, without this, jasper reports fails, see https://github.com/docker-library/openjdk/issues/73
RUN apk add --no-cache fontconfig ttf-dejavu    

# Use unicode
# RUN locale-gen C.UTF-8 || true
ENV LANG=C.UTF-8

# Set timezone to UTC by default and add circle user so its always here
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

# Some stuff from CIRCLECI examples and other
# 'shadow' allows the group and user adds below to work
RUN apk add --no-cache \
    python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

COPY pip-requirements.txt ./

RUN pip install -r pip-requirements.txt

# install mysql-client on this one so we can dump databases
RUN apk add --no-cache \
    mysql-client && \
    rm -rf /var/cache/apk/*
