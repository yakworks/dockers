FROM yakworks/alpine-java:jdk8-cleaned

# Some stuff from CIRCLECI examples and other
# 'shadow' allows the group and user adds below to work
RUN apk add --no-cache git sudo openssh-client parallel \
    net-tools netcat-openbsd zip bzip2 gnupg curl \
    shadow bash gawk bc coreutils \
    mysql-client && \
    rm -rf /var/cache/apk/*

# Install python3
RUN apk add --no-cache \
    python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

COPY pip-requirements.txt ./

# This installs 
RUN pip install -r pip-requirements.txt

ENV KUBECTL_VERSION=v1.15.1

# add kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
  mv kubectl /usr/local/bin/kubectl && \
  chmod +x /usr/local/bin/kubectl && \
  kubectl version --client
