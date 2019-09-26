# yakworks/mssql-server

based on https://github.com/shanegenschaw/mssql-server-linux

This image is an extension of the official [microsoft/mssql-server-linux](https://hub.docker.com/r/microsoft/mssql-server-linux/) Docker image

It adds functionality to initialize a fresh instance. Similiar to what MySql has availinbale, when a container is started for the first time, it will execute any files with extensions .sh or .sql or restore and .bak that are found in /docker-entrypoint-initdb.d. Files will be executed in alphabetical order. You can easily populate your SQL Server services by mounting scripts into that directory and provide custom images with contributed data.

Will also first gunzip sql files if they end with .sql.gz

## Restoring Backups with .bak files

Restoring bak files if fast, much faster than running sql to initialize a database. If a file has a .bak extension in `docker-entrypoint-initdb.d` then it will restore a database as the filename without the .bak , so when backing up a database it should be similiar to the setting below.
For example if you have foo_db.bak it will end up running the following

```
sqlcmd -U sa -P $SA_PASSWORD -Q \
    "RESTORE DATABASE foo_db FROM DISK = '/docker-entrypoint-initdb.d/foo_db.bak' 
    WITH MOVE 'foo_db' TO '/var/opt/mssql/data/foo_db.mdf', 
    MOVE 'foo_db_log' TO '/var/opt/mssql/data/foo_db_log.ldf'"
```

## Running this image

```
docker run -p 1433:1433 --name mssql -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Strong(!)Password' -v $PWD/initdb.d:/docker-entrypoint-initdb.d -d yakworks/mssql-server:2017
```

## Dockerfile based on this image

```
FROM yakworks/mssql-server:2017

COPY baks/* /docker-entrypoint-initdb.d/
```

## Additional information:

 * Linux-based mssql-docker [git repo](https://github.com/Microsoft/mssql-docker/tree/master/linux)
 * Running [SQL Server on Linux](https://docs.microsoft.com/en-us/sql/linux/) on top of an Ubuntu 16.04 base image.
 * Note that the version 2017-CU3 currently (as of Feb. 15, 2018) has a bug described here: [https://github.com/Microsoft/mssql-docker/issues/136](https://github.com/Microsoft/mssql-docker/issues/136)
 * Make sure that the .sh files have UNIX-style (LF) line endings. Depending on your platform and Git configuration, Git may change them to Windows-style (CR+LF). In this case, the container won't start, and you may see a non-informative error message like: 
 ```
 standard_init_linux.go:195: exec user process caused "no such file or directory"'.
```
