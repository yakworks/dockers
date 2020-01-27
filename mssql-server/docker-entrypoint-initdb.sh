#!/bin/bash

# wait for database to start...
for i in {30..0}; do
  if sqlcmd -U SA -P $SA_PASSWORD -Q 'SELECT 1;' &> /dev/null; then
    echo "$0: SQL Server started"
    break
  fi
  echo "$0: Waiting for SQL Server startup..."
  sleep 2
done

#sleep another 5 seconds to give it a chance
sleep 5

echo "$0: RUNNING FILES IN docker-entrypoint-initdb.d"
for f in /docker-entrypoint-initdb.d/*; do
  case "$f" in
    *.sh)     echo "$0: running $f"; . "$f" ;;
    *.bak)
        #remove path
        BAKFILE=$(basename "$f")
        #remove .bak ext
        DBNAME="${BAKFILE%.bak}"  
        echo "$0: RESTORING $BAKFILE"
        RST="RESTORE DATABASE $DBNAME FROM DISK = '$f' "
        RST+="WITH REPLACE, FILE = 1, NOUNLOAD, STATS = 5, MOVE '$DBNAME' TO '/var/opt/mssql/data/${DBNAME}.mdf', "
        RST+="MOVE '${DBNAME}_log' TO '/var/opt/mssql/data/${DBNAME}_log.ldf'"
        echo "$0: $RST"
        sqlcmd -U sa -P $SA_PASSWORD -Q "$RST" ;;
    *.sql)    echo "$0: running $f"; sqlcmd -U SA -P $SA_PASSWORD -X -i  "$f"; echo ;;
    *.sql.gz) echo "$0: running $f"; gunzip "$f" ; sqlcmd -U SA -P $SA_PASSWORD -X -i  "${f%.gz}"; echo ;;
    *)        echo "$0: ignoring $f" ;;
  esac
  echo
done
echo "$0: SQL Server Database ready, listing .."
sqlcmd -U SA -P $SA_PASSWORD -Q 'SELECT Name FROM sys.Databases'
