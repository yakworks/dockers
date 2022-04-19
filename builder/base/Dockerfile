FROM alpine:3.14

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

USER root

# helpfull core tools
# bash make curl git - for obvious needs
# zip - to unzip zip files
# coreutils - adds the cut, tr, etc..
# ncurses - allows pretty console, provides the tput
# gnupg - the gpg encrypt and decrypt
# openssh-client - ssh and scp, used in CI
# gawk - git-secrets wants dockers
RUN apk add --no-cache bash make curl git \
    zip coreutils ncurses \
    gnupg openssh-client gawk && \
    rm -rf /var/cache/apk/*


ENV SOPS_VERSION=3.7.1

# install sops, used along with GPG for encrypting files and decryopting from vault
RUN curl -qsL https://github.com/mozilla/sops/releases/download/v${SOPS_VERSION}/sops-v${SOPS_VERSION}.linux \
    -o /usr/bin/sops && \
	chmod +x /usr/bin/sops

WORKDIR /project