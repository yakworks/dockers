#FROM python:3.7-slim
FROM nginx:bookworm
# nginx:1.15 is alpine v3.9 which has python 3.6
# ideas from
# https://www.feval.ca/posts/k8s-static/#fnref:1

# This prevent broken installation of packages
RUN for i in $(seq 1 8); do mkdir -p /usr/share/man/man$i; done
RUN echo 'APT::Install-Recommends "0";' >> /etc/apt/apt.conf && \
    echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf

# Install base toolds, gettext for envsubst command, apache2-utils for htpasswd.
RUN apt-get -qq update && apt-get -qq -y --no-install-recommends install \
    make \
    curl \
    git \
    gnupg \
    openssh-client \
    net-tools \
    busybox \
    gawk \
    ca-certificates \
    apache2-utils \
    bash-completion \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

RUN echo "source /usr/share/bash-completion/bash_completion" >> /root/.bashrc

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install python3, about 30mb compressed
RUN apt-get -qq update && apt-get -qq -y --no-install-recommends install \
    python3 python3-pip && \
    rm -rf /usr/lib/python3.11/EXTERNALLY-MANAGED && \
    pip3 install --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

RUN rm -rf /usr/lib/python3.11/EXTERNALLY-MANAGED


RUN pip3 install setuptools wheel \
    mkdocs-material \
    mdx_truly_sane_lists \
    markdown-callouts \
    mkdocs-table-reader-plugin \
    openpyxl

WORKDIR /opt

# RUN rm /etc/nginx/conf.d/default.conf
COPY default.conf auth.conf /opt/

COPY 40-auth.sh /docker-entrypoint.d/40-auth.sh
RUN chmod +x /docker-entrypoint.d/40-auth.sh

# make sure root login is disabled
# RUN sed -i -e 's/^root::/root:!:/' /etc/shadow

# CMD ["/opt/nginx-entry.sh"]