FROM yakworks/builder:repo-job-1

# KEEP UNDER 30mb compressed. add new tools into an image based on this if it will go past that. 
# Add the following core tools. 
# The attempt is made to keep this to a minimum. 
# bash make curl git - for obvious needs
# tar gzip unzip zip - to zip/unzip zip files, these are small so install them
# coreutils - adds the cut, tr, pwd, etc.. the basics
# ncurses - allows pretty console, provides the tput
# gnupg - the gpg encrypt and decrypt
# openssh-client - ssh and scp, used in CI
# gawk - git-secrets wants dockers

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

USER root

RUN apk add --no-cache \
    tzdata \
    && rm -rf /var/cache/apk/*

COPY entry.sh /opt/

# match default circle working dir
WORKDIR /project