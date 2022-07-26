FROM debian:bullseye-slim


# KEEP UNDER 100mb compressed. add new tools into an image based on this if it will go past that.
# Add the following core tools.
# The attempt is made to keep this to a minimum.
# bash make curl git - for obvious needs
# tar gzip unzip zisp - to zip/unzip zip files, these are small so install them
# coreutils - adds the cut, tr, pwd, etc.. the basics
# ncurses - allows pretty console, provides the tput
# gnupg - the gpg encrypt and decrypt
# openssh-client - ssh and scp, used in CI
# gawk - git-secrets wants dockers
# debian bullseye already has bash and coreutils
ENV LANG C.UTF-8

# This prevent broken installation of packages
RUN for i in $(seq 1 8); do mkdir -p /usr/share/man/man$i; done
RUN echo 'APT::Install-Recommends "0";' >> /etc/apt/apt.conf && \
    echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf

RUN apt-get -y update && apt-get -y install \
    make \
    curl \
    git \
    gnupg \
    openssh-client \
    net-tools \
    busybox \
    gawk \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

# link busybox. busybox read the command so `/bin/ps` is same as `busybox ps`
RUN ln -s /bin/busybox /bin/ps && \
    ln -s /bin/busybox /bin/less && \
    ln -s /bin/busybox /bin/ping && \
    ln -s /bin/busybox /sbin/ip && \
    ln -s /bin/busybox /usr/bin/vi && \
    ln -s /bin/busybox /usr/bin/bc && \
    ln -s /bin/busybox /usr/bin/w && \
    ln -s /bin/busybox /usr/bin/uptime

WORKDIR /root/project
