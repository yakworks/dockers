#FROM python:3.7-slim
FROM nginx:1.15-alpine
# nginx:1.15 is alpine v3.9 which has python 3.6 
# ideas from 
# https://www.feval.ca/posts/k8s-static/#fnref:1

# bash because, git to download, gettext for envsubst command, apache2-utils for htpasswd.
RUN apk update && apk add --no-cache \
	bash gettext apache2-utils && \
    rm -rf /var/cache/apk/*

# Install python3 alpine 3.9 default to 3.6, mkdocs 1.16.3 wont work with version > 3.6, 
RUN apk update && apk add --no-cache \
    python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

RUN pip install wheel

WORKDIR /opt

# RUN rm /etc/nginx/conf.d/default.conf 
COPY default.conf auth.conf nginx-entry.sh ./
#COPY default.conf /etc/nginx/conf.d/

# make sure root login is disabled
# RUN sed -i -e 's/^root::/root:!:/' /etc/shadow

CMD ["/opt/nginx-entry.sh"]