FROM mysql/mysql-server:5.7

ENV MYSQL_ALLOW_EMPTY_PASSWORD=true \
    MYSQL_DATABASE=rcm-9ci-test \
    MYSQL_HOST=127.0.0.1 \
    MYSQL_ROOT_PASSWORD=test \
    MYSQL_ROOT_HOST=% \
    MYSQL_USER=root

# copy the default sql data so it automatically gets run to build the db
COPY rcm-9ci-test.sql /docker-entrypoint-initdb.d


# Copied from CircleCI images, This is the performance optimization tweak to make DB faster
RUN echo '\n\
[mysqld]\n\
collation-server = utf8_unicode_ci\n\
init-connect="SET NAMES utf8"\n\
character-set-server = utf8\n\
innodb_flush_log_at_trx_commit=2\n\
sync_binlog=0\n\
innodb_use_native_aio=0\n' >> /etc/mysql/my.cnf