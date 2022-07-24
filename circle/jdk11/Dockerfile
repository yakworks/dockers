FROM cimg/openjdk:11.0-node
# https://circleci.com/developer/images/image/cimg/openjdk

USER root
# Run commands and tests as circleci user
RUN whoami && \
	# opt-out of the new security feature, not needed in a CI environment
	git config --global --add safe.directory '*'

# Match the default CircleCI working directory
WORKDIR /project

# Install python3, about 30mb compressed
RUN apt-get -qq update && apt-get -qq -y --no-install-recommends install \
    python3-pip && \
    sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip3 install --upgrade pip setuptools wheel httpie && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi

# Install node16, npm and googles zx for scripts https://github.com/google/zx
# heavy about 80mb compressed, 170mb uncompressed
# RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
# RUN apt-get -y --no-install-recommends install nodejs && \
#     npm i -g zx && npm i -g pnpm && \
#     npm cache clean --force && \
#     rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

# install sops, used along with GPG for encrypting files and decryopting from vault
# fairly heavy at aprox 15mb compressed but we use it to decypt vault so its in base image. 
ENV SOPS_VERSION=3.7.1
RUN curl -qsL https://github.com/mozilla/sops/releases/download/v${SOPS_VERSION}/sops-v${SOPS_VERSION}.linux \
    -o /usr/bin/sops && \
    chmod +x /usr/bin/sops

# kubectl aprox 15mb compressed 
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