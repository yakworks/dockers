FROM yakworks/alpine-builder:v2-k8s

# parallel
RUN apk add --no-cache parallel && \
    rm -rf /var/cache/apk/*

# java
RUN wget --quiet https://cdn.azul.com/public_keys/alpine-signing@azul.com-5d5dc44c.rsa.pub -P /etc/apk/keys/ && \
    echo "https://repos.azul.com/zulu/alpine" >> /etc/apk/repositories && \
    apk --no-cache add zulu8-jdk

ENV JAVA_HOME=/usr/lib/jvm/zulu8-ca

# adds in some things needed for java ui and reporting, like fonts
RUN apk add --no-cache dumb-init xvfb fontconfig ttf-dejavu && \
    rm -rf /var/cache/apk/*

# sym link the jar command
# RUN ln -s /usr/lib/jvm/default-jvm/bin/jar /usr/bin/jar

# Install python3
RUN apk add --no-cache \
    python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache
