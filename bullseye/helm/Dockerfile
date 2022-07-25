ARG REGISTRY=yakworks
FROM $REGISTRY/bullseye:core

ENV HELM_VERSION=3.8.0
# ENV KUBECTL_VERSION=v1.23.8

# HELM
ENV BASE_URL="https://get.helm.sh"
RUN case `uname -m` in \
        x86_64) ARCH=amd64; ;; \
        armv7l) ARCH=arm; ;; \
        aarch64) ARCH=arm64; ;; \
        ppc64le) ARCH=ppc64le; ;; \
        s390x) ARCH=s390x; ;; \
        *) echo "un-supported arch, exit ..."; exit 1; ;; \
    esac && \
    apt-get -qq update && \
    apt-get -qq -y --no-install-recommends install wget && \
    wget ${BASE_URL}/helm-v${HELM_VERSION}-linux-${ARCH}.tar.gz -O - | tar -xz && \
    mv linux-${ARCH}/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-${ARCH} && \
    apt-get -qq -y purge wget && \
    rm -rf /var/lib/apt/lists/*

RUN chmod +x /usr/bin/helm
#end HELM
