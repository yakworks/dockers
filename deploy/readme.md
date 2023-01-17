some basic starter examples to quick deploy one of these dockers to kubernetes


## Notes for psql back up.
TODO move these to lke-crunchy once complete. here for ease

1. run > `kubectl apply -f deploy/test-pod.yaml`
2. shell into it -> `kubectl exec --stdin --tty psqlbak -- /bin/bash`
3. `export PGUSER=postgres; export PGPASSWORD="6AZ...."; export PGHOST=rhino-primary.postgres-operator.svc`
4. smoke test `psql rndc_prod`-> `select * from users;`
5. backup -> `pg_dump --file "/rndc_prod.bak" --verbose --format=c rndc_prod`
6. restore -> `pg_restore --dbname "rndc-mirror" --clean --verbose "/rndc_prod.bak"`
7. delete pod when done -> `kubectl delete pod psqlbak`

## move backup to s3

1. use [crunchy doc](https://www.linode.com/docs/products/storage/object-storage/guides/s3cmd/) to configure s3

```
Access Key and Secret Key take from lke-crunchy or Last Pass
S3 Endpoint (cluster URL): https://us-southeast-1.linodeobjects.com
DNS-style bucket+hostname:port template for accessing a bucket: %(bucket)s.us-southeast-1.linodeobjects.com
```

2. run `s3cmd put rndc_prod.bak s3://rndc/` to put rndc_prod.bak on rndc bucket
