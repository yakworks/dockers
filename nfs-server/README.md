Cloned from https://github.com/sjiveson/nfs-server-alpine/commit/8dddf580ef7741971a87c38ef6099ebd9b12bc73
Did not fork as it has some big file that made it 25mb, skinny it down. 
see for ARM and more advanced features if needed

# nfs-server-alpine

A handy NFS Server image comprising Alpine Linux and NFS v4 only, over TCP on port 2049.

## Overview

The image comprises of;

- [Alpine Linux](http://www.alpinelinux.org/) v3.8.1. Alpine Linux is a security-oriented, lightweight Linux distribution based on [musl libc](https://www.musl-libc.org/) (v1.1.19) and [BusyBox](https://www.busybox.net/).
- NFS v4 only, over TCP on port 2049. Rpcbind is enabled for now to overcome a bug with slow startup, it shouldn't be required.

When run, this container will make whatever directory is specified by the environment variable SHARED_DIRECTORY available to NFS v4 clients. Mount the volume to `/nfs-volume`. On starup will check to see if SHARED_DIRECTORY exists and if not it will be created underneath /data. SHARED_DIRECTORY should be specified

```shell
mkdir -p "/data/$SHARED_DIRECTORY" && chown nobody:users "/data/$SHARED_DIRECTORY" && \
chmod -R 777 "/data/$SHARED_DIRECTORY"
```

`docker run -d --name nfs --privileged -v /some/where/fileshare:/data -e SHARED_DIRECTORY=nfs_share yakworks/nfs-server:latest`

Adding `-e READ_ONLY` will cause the exports file to contain `ro` instead of `rw`, allowing only read access by clients.

Adding `-e SYNC=true` will cause the exports file to contain `sync` instead of `async`, enabling synchronous mode. Check the exports man page for more information: https://linux.die.net/man/5/exports.

Adding `-e PERMITTED="10.11.99.*"` will permit only hosts with an IP address starting 10.11.99 to mount the file share.

Due to the `fsid=0` parameter set in the **/etc/exports file**, there's no need to specify the folder name when mounting from a client. For example, this works fine even though the folder being mounted and shared is /nfsshare:

`sudo mount -v 10.11.12.101:/ /some/where/here`

To be a little more explicit:

`sudo mount -v -o vers=4,loud 10.11.12.101:/ /some/where/here`

To _unmount_:

`sudo umount /some/where/here`

The /etc/exports file contains these parameters unless modified by the environment variables listed above:

`*(rw,fsid=0,async,no_subtree_check,no_auth_nlm,insecure,no_root_squash)`

Note that the `showmount` command won't work against the server as rpcbind isn't running.

### Privileged Mode

You'll note above with the `docker run` command that privileged mode is required. Yes, this is a security risk but an unavoidable one it seems. You could try these instead: `--cap-add SYS_ADMIN --cap-add SETPCAP --security-opt=no-new-privileges` but I've not had any luck with them myself. You may fare better with your own combination of Docker and OS. The SYS_ADMIN capability is very, very broad in any case and almost as risky as privileged mode.

See the following sub-sections for information on doing the same in non-interactive environments.

#### Kubernetes

As reported here https://github.com/sjiveson/nfs-server-alpine/issues/8 it appears Kubernetes requires the `privileged: true` option to be set:

```
spec:
  containers:
  - name: ...
    image: ...
    securityContext:
      privileged: true
```

#### Docker Compose 

When using Docker Compose you can specify privileged mode like so:

```
privileged: true
```

To use capabilities instead:

```
cap_add:
  - SYS_ADMIN
  - SETPCAP
```

### What Good Looks Like

A successful server start should produce log output like this:

```
Writing SHARED_DIRECTORY to /etc/exports file
The PERMITTED environment variable is unset or null, defaulting to '*'.
This means any client can mount.
The READ_ONLY environment variable is unset or null, defaulting to 'rw'.
Clients have read/write access.
The SYNC environment variable is unset or null, defaulting to 'async' mode.
Writes will not be immediately written to disk.
Displaying /etc/exports contents:
/nfsshare *(rw,fsid=0,async,no_subtree_check,no_auth_nlm,insecure,no_root_squash)

Starting rpcbind...
Displaying rpcbind status...
   program version netid     address                service    owner
    100000    4    tcp6      ::.0.111               -          superuser
    100000    3    tcp6      ::.0.111               -          superuser
    100000    4    udp6      ::.0.111               -          superuser
    100000    3    udp6      ::.0.111               -          superuser
    100000    4    tcp       0.0.0.0.0.111          -          superuser
    100000    3    tcp       0.0.0.0.0.111          -          superuser
    100000    2    tcp       0.0.0.0.0.111          -          superuser
    100000    4    udp       0.0.0.0.0.111          -          superuser
    100000    3    udp       0.0.0.0.0.111          -          superuser
    100000    2    udp       0.0.0.0.0.111          -          superuser
    100000    4    local     /var/run/rpcbind.sock  -          superuser
    100000    3    local     /var/run/rpcbind.sock  -          superuser
Starting NFS in the background...
rpc.nfsd: knfsd is currently down
rpc.nfsd: Writing version string to kernel: -2 -3 +4
rpc.nfsd: Created AF_INET TCP socket.
rpc.nfsd: Created AF_INET6 TCP socket.
Exporting File System...
exporting *:/nfsshare
/nfsshare     	<world>
Starting Mountd in the background...
Startup successful.
```

### What Good Looks Like - Confd Versions

```
The PERMITTED environment variable is missing or null, defaulting to '*'.
Any client can mount.
The READ_ONLY environment variable is missing or null, defaulting to 'rw'
Clients have read/write access.
The SYNC environment variable is missing or null, defaulting to 'async'.
Writes will not be immediately written to disk.
Starting Confd population of files...
confd 0.14.0 (Git SHA: 9fab9634, Go Version: go1.9.1)
2018-05-07T18:24:39Z d62d37258311 /usr/bin/confd[14]: INFO Backend set to env
2018-05-07T18:24:39Z d62d37258311 /usr/bin/confd[14]: INFO Starting confd
2018-05-07T18:24:39Z d62d37258311 /usr/bin/confd[14]: INFO Backend source(s) set to
2018-05-07T18:24:39Z d62d37258311 /usr/bin/confd[14]: INFO /etc/exports has md5sum 4f1bb7b2412ce5952ecb5ec22d8ed99d should be 92cc8fa446eef0e167648be03aba09e5
2018-05-07T18:24:39Z d62d37258311 /usr/bin/confd[14]: INFO Target config /etc/exports out of sync
2018-05-07T18:24:39Z d62d37258311 /usr/bin/confd[14]: INFO Target config /etc/exports has been updated
Displaying /etc/exports contents...
/nfsshare *(rw,fsid=0,async,no_subtree_check,no_auth_nlm,insecure,no_root_squash)
Starting rpcbind...
Displaying rpcbind status...
   program version netid     address                service    owner
    100000    4    tcp6      ::.0.111               -          superuser
    100000    3    tcp6      ::.0.111               -          superuser
    100000    4    udp6      ::.0.111               -          superuser
    100000    3    udp6      ::.0.111               -          superuser
    100000    4    tcp       0.0.0.0.0.111          -          superuser
    100000    3    tcp       0.0.0.0.0.111          -          superuser
    100000    2    tcp       0.0.0.0.0.111          -          superuser
    100000    4    udp       0.0.0.0.0.111          -          superuser
    100000    3    udp       0.0.0.0.0.111          -          superuser
    100000    2    udp       0.0.0.0.0.111          -          superuser
    100000    4    local     /var/run/rpcbind.sock  -          superuser
    100000    3    local     /var/run/rpcbind.sock  -          superuser
Starting NFS in the background...
rpc.nfsd: knfsd is currently down
rpc.nfsd: Writing version string to kernel: -2 -3 +4
rpc.nfsd: Created AF_INET TCP socket.
rpc.nfsd: Created AF_INET6 TCP socket.
Exporting File System...
exporting *:/nfsshare
/nfsshare     	<world>
Starting Mountd in the background...
Startup successful.
```

### Dockerfile

The Dockerfile used to create this image is available at the root of the file system on build.

```
FROM alpine:latest
LABEL maintainer "Steven Iveson <steve@iveson.eu>"
LABEL source "https://github.com/sjiveson/nfs-server-alpine"
LABEL branch "master"
COPY Dockerfile README.md /

RUN apk add --no-cache --update --verbose nfs-utils bash iproute2 && \
    rm -rf /var/cache/apk /tmp /sbin/halt /sbin/poweroff /sbin/reboot && \
    mkdir -p /var/lib/nfs/rpc_pipefs /var/lib/nfs/v4recovery && \
    echo "rpc_pipefs    /var/lib/nfs/rpc_pipefs rpc_pipefs      defaults        0       0" >> /etc/fstab && \
    echo "nfsd  /proc/fs/nfsd   nfsd    defaults        0       0" >> /etc/fstab

COPY exports /etc/
COPY nfsd.sh /usr/bin/nfsd.sh
COPY .bashrc /root/.bashrc

RUN chmod +x /usr/bin/nfsd.sh

ENTRYPOINT ["/usr/bin/nfsd.sh"]
```

### Acknowlegements

Thanks to Torsten Bronger @bronger for the suggestion and help around implementing a multistage Docker build to better handle the inclusion of Confd (since removed).
