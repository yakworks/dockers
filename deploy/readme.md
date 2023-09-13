some basic starter examples to quick deploy one of these dockers to kubernetes


## Notes for psql back up.
TODO move these to lke-crunchy once complete. here for ease

1. run > `kubectl apply -f deploy/test-pod.yaml`
2. shell into it -> `kubectl exec --stdin --tty psqlbak -- /bin/bash`
3. `export PGUSER=postgres; export PGPASSWORD="6AZ...."; export PGHOST=rhino-primary.postgres-operator.svc`
4. smoke test `psql rndc_prod`-> `select * from users;`
5. backup -> `pg_dump --file "./rndc_prod.bak" --verbose --format=c rndc_prod`
6. restore -> `pg_restore --dbname "rndc" --clean --verbose "/rndc_prod.bak"`
7. delete pod when done -> `kubectl delete pod psqlbak`

## move backups to/from s3

1. run `s3cmd put rndc_prod.bak s3://rndc/` to put rndc_prod.bak on rndc bucket

2. to download run `s3cmd get  s3://rndc/rndc_prod.bak`  

### conf s3:

1. use [crunchy doc](https://www.linode.com/docs/products/storage/object-storage/guides/s3cmd/) to configure s3

take secret/access key from lke-crunchy or Lastpass

```
Access Key and Secret Key take from lke-crunchy or Last Pass
S3 Endpoint (cluster URL): https://us-southeast-1.linodeobjects.com
DNS-style bucket+hostname:port template for accessing a bucket: %(bucket)s.us-southeast-1.linodeobjects.com
```

as below for example:

```
Enter new values or accept defaults in brackets with Enter.
Refer to user manual for detailed description of all options.

Access key and Secret key are your identifiers for Amazon S3. Leave them empty for using the env variables.
Access Key: Z4...
Secret Key: me..
Default Region [US]: US

Use "s3.amazonaws.com" for S3 Endpoint and not modify it to the target Amazon S3.
S3 Endpoint [s3.amazonaws.com]: https://us-southeast-1.linodeobjects.com

Use "%(bucket)s.s3.amazonaws.com" to the target Amazon S3. "%(bucket)s" and "%(location)s" vars can be used
if the target S3 system supports dns based buckets.
DNS-style bucket+hostname:port template for accessing a bucket [%(bucket)s.s3.amazonaws.com]: %(bucket)s.us-southeast-1.linodeobjects.com

Encryption password is used to protect your files from reading
by unauthorized persons while in transfer to S3
Encryption password: 
Path to GPG program [/usr/bin/gpg]: 

When using secure HTTPS protocol all communication with Amazon S3
servers is protected from 3rd party eavesdropping. This method is
slower than plain HTTP, and can only be proxied with Python 2.7 or newer
Use HTTPS protocol [Yes]: 

On some networks all internet access must go through a HTTP proxy.
Try setting it here if you can't connect to S3 directly
HTTP Proxy server name: 

New settings:
  Access Key: Z4..
  Secret Key: me..
  Default Region: US
  S3 Endpoint: https://us-southeast-1.linodeobjects.com
  DNS-style bucket+hostname:port template for accessing a bucket: %(bucket)s.us-southeast-1.linodeobjects.com
  Encryption password: 
  Path to GPG program: /usr/bin/gpg
  Use HTTPS protocol: True
  HTTP Proxy server name: 
  HTTP Proxy server port: 0

Test access with supplied credentials? [Y/n] n

Save settings? [y/N] y
```


going straight to the crunchy db

```bash
kubectl exec --stdin --tty psqlbak -- /bin/bash

kubectl exec -c database -n postgres-operator \
	$$(kubectl get pod -n postgres-operator --selector="postgres-operator.crunchydata.com/cluster=$(name),postgres-operator.crunchydata.com/role=master" -o name) \
	-- psql -c "select version();"

kubectl exec -c database -n postgres-operator \
	$(kubectl get pod -n postgres-operator \
    --selector="postgres-operator.crunchydata.com/cluster=rhino,postgres-operator.crunchydata.com/role=master" \
    -o name) \
	--stdin --tty psqlbak -- /bin/bash

```
