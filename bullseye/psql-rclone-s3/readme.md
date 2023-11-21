# psql-rclone-s3

## Quick start

### rclone

__rclone__ expects config in `/root/.config/rclone/rclone.conf`

Get a working config through experimentation, make a k8s secret out of it and mount it as a volume to the above location.

### s3cmd

__s3cmd__ wants a config at `~/.s3cfg`, but if you mount that as a secret you can't modify anything in the /root directory.

Get a working config through experimentation, make a k8s secret out of it and mount it as a volume at `/root/.config/s3cmd`
and define environment __S3CMD_CONFIG__=`/root/.config/s3cmd/.s3cfg`

