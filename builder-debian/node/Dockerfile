FROM node:16-bullseye-slim

ENV LANG C.UTF-8

RUN npm install npm@latest -g && \
    npm install -g pnpm

RUN apt-get -qq update && \
    apt-get -qq -y --no-install-recommends install \
    bash make curl coreutils git gnupg openssh-client gawk ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/\* /tmp/\* /var/tmp/*

# RUN apk add --no-cache npm && \
#     npm install npm@latest -g && \
#     npm install -g pnpm


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