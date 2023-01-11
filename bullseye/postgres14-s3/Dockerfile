FROM postgres:14

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

#--- BASE ---
RUN apt-get -qq update && \
    apt-get -qq -y --no-install-recommends install \
    make curl git gnupg openssh-client ca-certificates python3.9 python3-venv python-is-python3 unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/\* /var/tmp/*

#--- S3 ---
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"; \
    unzip awscli-bundle.zip; \
    ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
