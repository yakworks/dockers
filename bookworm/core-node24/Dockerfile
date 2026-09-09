ARG REGISTRY=yakworks
FROM $REGISTRY/bookworm:core-node24

# Install node24, npm and googles zx for scripts https://github.com/google/zx
# heavy about 80mb compressed, 170mb uncompressed
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash -
    RUN apt-get -y --no-install-recommends install nodejs && \
        npm i -g zx && npm i -g pnpm && \
        npm cache clean --force && \
        rm -rf /var/lib/apt/lists/* /var/cache/apt/archives
