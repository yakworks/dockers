FROM mcr.microsoft.com/mssql/server:2019-latest

USER root

ENV ACCEPT_EULA=Y
VOLUME /docker-entrypoint-initdb.d
EXPOSE 1433

RUN ln -s /opt/mssql-tools18/bin/sqlcmd /usr/local/bin/sqlcmd \
    && ln -s /opt/mssql-tools18/bin/bcp /usr/local/bin/bcp

COPY docker-entrypoint.sh /usr/local/bin/
COPY docker-entrypoint-initdb.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
