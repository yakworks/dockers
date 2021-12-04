FROM alpine:3.15
LABEL source "https://github.com/yakworks/docker-nfs-server"
LABEL branch "master"
COPY Dockerfile README.md /

RUN apk add --no-cache --update --verbose nfs-utils bash iproute2 && \
    rm -rf /var/cache/apk /tmp /sbin/halt /sbin/poweroff /sbin/reboot && \
    mkdir -p /var/lib/nfs/rpc_pipefs /var/lib/nfs/v4recovery /usr/local/sbin && \
    echo "rpc_pipefs    /var/lib/nfs/rpc_pipefs rpc_pipefs      defaults        0       0" >> /etc/fstab && \
    echo "nfsd  /proc/fs/nfsd   nfsd    defaults        0       0" >> /etc/fstab

COPY exports /etc/
COPY .bashrc /root/.bashrc
COPY sbin/* /usr/local/sbin/

RUN chmod 755 /usr/local/sbin/*
RUN chown root:root /usr/local/sbin/*

ENTRYPOINT ["/usr/local/sbin/nfsd.sh"]
