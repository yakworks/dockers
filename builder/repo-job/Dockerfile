ARG REGISTRY=yakworks
FROM $REGISTRY/builder:core

COPY entry.sh /opt/
COPY clone.sh /opt/

WORKDIR /project

CMD ["/opt/entry.sh"]
