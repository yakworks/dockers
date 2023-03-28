ARG REGISTRY=yakworks
FROM $REGISTRY/bullseye:base

# python - so we can script with it
# httpie - helpful replacement for curl
# sops
# node16, npm, pnpm and googles zx
# kubectl

# FIXME something is worng with pip3 with this.
# try shelling in and running this core "pip3 install s3cmd" and it fails, not sure if its like that for others
# works fine if you prefix path and run "/usr/bin/pip3 install s3cmd" instaed of letting it use "/usr/local/bin/pip3"
# also works fine here in dockerfile with just pip3

# Install python3, about 30mb compressed
RUN apt-get -qq update && apt-get -qq -y --no-install-recommends install \
    python3-pip && \
    # python3 -m ensurepip && \
    # rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

# # curl replacement, worth the 15mb, see https://httpie.io/docs
RUN pip3 install httpie

# Install node16, npm and googles zx for scripts https://github.com/google/zx
# heavy about 80mb compressed, 170mb uncompressed
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get -y --no-install-recommends install nodejs && \
    npm i -g zx && npm i -g pnpm && \
    npm cache clean --force && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

# install sops, used along with GPG for encrypting files and decryopting from vault
# fairly heavy at aprox 15mb compressed but we use it to decypt vault so its in base image.
ENV SOPS_VERSION=3.7.1
RUN curl -qsL https://github.com/mozilla/sops/releases/download/v${SOPS_VERSION}/sops-v${SOPS_VERSION}.linux \
    -o /usr/bin/sops && \
	chmod +x /usr/bin/sops

# kubectl aprox 15mb compressed
ENV KUBECTL_VERSION=v1.24.8
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

# ADD misc for using as dev enironment, bash_completion and some aliases
RUN apt-get update && apt-get -y --no-install-recommends install \
    bash-completion make fzf \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

RUN echo "source /usr/share/bash-completion/bash_completion" >> /root/.bashrc && \
    echo "alias ll='ls -lahG'" >> /root/.bashrc && \
    echo "alias gw='./gradlew'" >> /root/.bashrc && \
    echo "alias m='make'" >> /root/.bashrc
# end dev help

