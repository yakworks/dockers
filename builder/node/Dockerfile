FROM node:16-alpine

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

USER root

RUN apk add --no-cache npm && \
    npm install npm@latest -g && \
    npm install -g pnpm


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

ENV KUBECTL_VERSION=v1.23.8

# kubectl
RUN case `uname -m` in \
        x86_64) ARCH=amd64; ;; \
        armv7l) ARCH=arm; ;; \
        aarch64) ARCH=arm64; ;; \
        ppc64le) ARCH=ppc64le; ;; \
        s390x) ARCH=s390x; ;; \
        *) echo "un-supported arch, exit ..."; exit 1; ;; \
    esac && \
  curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/${ARCH}/kubectl && \
  mv kubectl /usr/local/bin/kubectl && \
  chmod +x /usr/local/bin/kubectl && \
  kubectl version --client

# end kubectl

WORKDIR /project