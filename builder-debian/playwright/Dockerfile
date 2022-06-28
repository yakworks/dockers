FROM mcr.microsoft.com/playwright:v1.22.2-focal

RUN npm install npm@latest -g && \
    npm install -g pnpm

#--- adds whats in base, need for build with circle and shipkit ---
RUN apt-get -qq update && \
    apt-get -qq -y --no-install-recommends install \
    bash make curl coreutils git gnupg openssh-client gawk ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/\* /tmp/\* /var/tmp/*

WORKDIR /project