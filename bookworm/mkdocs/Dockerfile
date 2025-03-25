ARG REGISTRY=yakworks
FROM $REGISTRY/bookworm:nginx-python

# Expose MkDocs development server port
EXPOSE 8000

WORKDIR /project

# Start development server by default
ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
