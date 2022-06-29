FROM yakworks/builder:base

# ENV HELM_VERSION=3.8.0
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

# HELM
# ENV BASE_URL="https://get.helm.sh"
# RUN case `uname -m` in \
#         x86_64) ARCH=amd64; ;; \
#         armv7l) ARCH=arm; ;; \
#         aarch64) ARCH=arm64; ;; \
#         ppc64le) ARCH=ppc64le; ;; \
#         s390x) ARCH=s390x; ;; \
#         *) echo "un-supported arch, exit ..."; exit 1; ;; \
#     esac && \
#     apk add --update --no-cache wget && \
#     wget ${BASE_URL}/helm-v${HELM_VERSION}-linux-${ARCH}.tar.gz -O - | tar -xz && \
#     mv linux-${ARCH}/helm /usr/bin/helm && \
#     chmod +x /usr/bin/helm && \
#     rm -rf linux-${ARCH}

# RUN chmod +x /usr/bin/helm
# end HELM
