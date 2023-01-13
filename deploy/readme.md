some basic starter examples to quick deploy one of these dockers to kubernetes


## Notes for psql back up.
TODO move these to lke-crunchy once complete. here for ease

1. run > `kubectl apply -f deploy/test-pod.yaml`
2. shell into it -> `kubectl exec --stdin --tty psqlbak -- /bin/bash`
3. `export PGUSER=postgres; export PGPASSWORD="3jFGgSi5BYPUM9<oe+SA;iz9"; export PGHOST=hippo-primary.postgres-operator.svc`
4. smoke test `psql rndc_prod`-> `select * from users;`
5. backup -> `pg_dump --file "/rndc_prod.bak" --verbose --format=c rndc_prod`
6. restore -> `pg_restore --dbname "rndc-mirror" --verbose "/testing.bak" --create`
7. delet pod when done -> `kubectl delete pod psqlbak`
