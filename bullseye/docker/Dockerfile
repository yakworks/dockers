FROM yakworks/bullseye:core

# Used for building Dockers on CI
# https://docs.docker.com/engine/install/debian/
RUN apt-get -qq update && \
    apt-get -qq -y --no-install-recommends install software-properties-common lsb-release && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get -qq update && \
    apt-get -qq -y --no-install-recommends install docker-ce docker-ce-cli containerd.io && \
    apt-get -qq -y purge software-properties-common && \
    apt -y autoremove && \
    # Quick test of the Docker install
	docker --version && \
    rm -rf /var/lib/apt/lists/*
