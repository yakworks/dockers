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
RUN apk add --no-cache bash make curl git \
    zip coreutils ncurses \
    gnupg openssh-client && \
    rm -rf /var/cache/apk/*

# other to be potentially added, some already exist in busybox but might need gnu versions
# net-tools netcat-openbsd gawk grep bzip2 sudo
# shadow - add the su, login , passwd, etc user stuff
# sudo - compatibility

# install-git-secret:
# RUN echo 'https://gitsecret.jfrog.io/artifactory/git-secret-apk/all/main' >> /etc/apk/repositories && \
#   wget -O /etc/apk/keys/git-secret-apk.rsa.pub 'https://gitsecret.jfrog.io/artifactory/api/security/keypair/public/repositories/git-secret-apk' && \
#   apk add --update --no-cache git-secret

WORKDIR /project