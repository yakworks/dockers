FROM frolvlad/alpine-java:jdk8-cleaned

USER root

# Some stuff from CIRCLECI examples and other
# 'shadow' allows the group and user adds below to work
RUN apk add --no-cache dumb-init git xvfb \
    sudo openssh-client ca-certificates tar gzip parallel \
    net-tools netcat-openbsd unzip zip bzip2 gnupg curl wget \
    shadow bash gawk sed grep bc coreutils

# Use unicode
# RUN locale-gen C.UTF-8 || true
ENV LANG=C.UTF-8

# Set timezone to UTC by default and add circle user so its always here
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

ENV SDKMAN_DIR /sdkman

RUN /bin/bash -c "curl -s 'https://get.sdkman.io' | bash; \
source /sdkman/bin/sdkman-init.sh; \
sed -i -e 's/sdkman_auto_answer=false/sdkman_auto_answer=true/g' /sdkman/etc/config;"

COPY entry-point.sh ./
RUN sudo chmod +x /entry-point.sh

WORKDIR /app

ENTRYPOINT ["/entry-point.sh"]
CMD ["/bin/bash"]
