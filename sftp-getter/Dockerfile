# A basic sftp getter

FROM yakworks/builder:base

RUN mkdir -p /project
RUN mkdir -p /opt

COPY entrypoint.sh /opt/

# Set working directory to nginx asset directory
WORKDIR /project

ENTRYPOINT ["/opt/entrypoint.sh"]

# cd <project-dir>
# docker build -t sftp-getter banks/sftp-getter
# docker run --rm -it -v `pwd`:/project sftp-getter