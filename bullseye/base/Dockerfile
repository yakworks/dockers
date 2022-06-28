FROM debian:bullseye-slim

# ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# USER root

# make the "en_US.UTF-8" locale so postgres will be utf-8 enabled by default
# RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
# 	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
# ENV LANG en_US.utf8

ENV LANG C.UTF-8

# helpfull core tools
# bash make curl git - for obvious needs
# zip - to unzip zip files
# coreutils - adds the cut, tr, etc..
# ncurses - allows pretty console, provides the tput
# gnupg - the gpg encrypt and decrypt
# openssh-client - ssh and scp, used in CI
# gawk - git-secrets wants dockers
# RUN apk add --no-cache bash make curl git \
#     zip coreutils ncurses \
#     gnupg openssh-client gawk && \
RUN apt-get -qq update && \
    apt-get -qq -y --no-install-recommends install \
    bash make curl coreutils git gnupg openssh-client gawk ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/\* /tmp/\* /var/tmp/*

# curl git coreutils gnupg openssh-client gawk ca-certificates  

# other to be potentially added, some already exist in busybox but might need gnu versions
# net-tools netcat-openbsd gawk grep bzip2 sudo
# shadow - add the su, login , passwd, etc user stuff
# sudo - compatibility


WORKDIR /project