ARG REGISTRY=yakworks
FROM $REGISTRY/bullseye:core

# ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN curl https://www.postgresql.org/media/keys/ACCC4CF8.asc \
  | gpg --dearmor \
  | tee /etc/apt/trusted.gpg.d/apt.postgresql.org.gpg >/dev/null

RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ bullseye-pgdg main" \
    > /etc/apt/sources.list.d/postgresql.list'

# ADD misc for using as dev enironment, bash_completion and some aliases
RUN apt update && apt-get -y --no-install-recommends install \
    postgresql-14 && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

# install s3cmd
RUN pip3 install s3cmd
