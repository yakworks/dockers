ARG REGISTRY
FROM $REGISTRY/builder:3.14

COPY entry.sh /opt/
COPY clone.sh /opt/

WORKDIR /project

CMD ["/opt/entry.sh"]
