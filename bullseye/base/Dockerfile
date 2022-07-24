FROM debian:bullseye-slim

# KEEP UNDER 100mb compressed. add new tools into an image based on this if it will go past that. 
# Add the following core tools. 
# The attempt is made to keep this to a minimum. 
# bash make curl git - for obvious needs
# tar gzip unzip zisp - to zip/unzip zip files, these are small so install them
# coreutils - adds the cut, tr, pwd, etc.. the basics
# ncurses - allows pretty console, provides the tput
# gnupg - the gpg encrypt and decrypt
# openssh-client - ssh and scp, used in CI
# gawk - git-secrets wants dockers

# debian bullseye already has bash and coreutils
ENV LANG C.UTF-8

RUN apt-get -qq -y update && \
    apt-get -qq -y --no-install-suggests --no-install-recommends install \
    # bash \
    make \
    curl \
    git \
    # coreutils \
    gnupg \
    openssh-client \
    net-tools \
    # tar gzip unzip zip \
    # gawk \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

WORKDIR /root/project