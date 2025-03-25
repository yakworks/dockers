ARG REGISTRY=yakworks
FROM $REGISTRY/bullseye:core


# add s3 and aws stufff
RUN apt-get -y update && apt-get -y --no-install-recommends install \
    aws-stuff \
    some-other-package \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives
