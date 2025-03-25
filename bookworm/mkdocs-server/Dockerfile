ARG REGISTRY=yakworks
FROM $REGISTRY/bookworm:nginx-python

COPY 50-build.sh /docker-entrypoint.d/50-build.sh
RUN chmod +x /docker-entrypoint.d/50-build.sh

# runs defaults in nginx continer
# CMD ["/opt/docker-entry.sh"]
