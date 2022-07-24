FROM yakworks/builder:base

# KEEP UNDER 100mb compressed. 
# python - so we can script with it
# httpie - helpful replacement for curl
# sops
# node16, npm, pnpm and googles zx
# kubectl

# Install python3
RUN apk add --no-cache \
    python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache && rm -rf /var/cache/apk/*

# curl replacement, worth the 15mb, see https://httpie.io/docs
RUN pip3 install httpie

# Install node16, npm and googles zx for scripts https://github.com/google/zx
# adds about 25mb to compressed img size
RUN apk add --no-cache nodejs=16.15.0-r1 && \
    apk add --no-cache npm && \
    npm i -g zx && \
    npm i -g pnpm && \
    rm -rf /var/cache/apk/* 
    # npm cache clean --force

# install sops, used along with GPG for encrypting files and decryopting from vault
# fairly heavy at 32mb but we use it to decypt vault so its in base image. 
ENV SOPS_VERSION=3.7.1
RUN curl -qsL https://github.com/mozilla/sops/releases/download/v${SOPS_VERSION}/sops-v${SOPS_VERSION}.linux \
    -o /usr/bin/sops && \
	chmod +x /usr/bin/sops

# kubectl
ENV KUBECTL_VERSION=v1.23.8
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
