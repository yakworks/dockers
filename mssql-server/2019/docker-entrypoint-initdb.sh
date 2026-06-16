#!/bin/bash

for i in {30..0}; do
  if sqlcmd -C -U SA -P "$SA_PASSWORD" -Q 'SELECT 1;' &> /dev/null; then
    echo "$0: SQL Server started"
    break
  fi
  echo "$0: Waiting for SQL Server startup..."
  sleep 2
done

sleep 5

echo "$0: RUNNING FILES IN docker-entrypoint-initdb.d"
for f in /docker-entrypoint-initdb.d/*; do
  case "$f" in
    *.sh)     echo "$0: running $f"; . "$f" ;;
    *.bak)
        BAKFILE=$(basename "$f")
        DBNAME="${BAKFILE%.bak}"
        echo "$0: RESTORING $BAKFILE"

        # Check if backup has secondary data file ndf (large databases ith backup taken with Windows will have that)
        HAS_NDF=$(sqlcmd -C -U sa -P "$SA_PASSWORD" -Q "RESTORE FILELISTONLY FROM DISK = '$f'" -h -1 2>/dev/null | grep -c "${DBNAME}_Data_01")

        RST="RESTORE DATABASE $DBNAME FROM DISK = '$f' "
        RST+="WITH REPLACE, FILE = 1, NOUNLOAD, STATS = 5, "
        RST+="MOVE '$DBNAME' TO '/var/opt/mssql/data/${DBNAME}.mdf', "

        if [ "$HAS_NDF" -gt 0 ]; then
            echo "$0: Secondary data file detected, adding NDF move"
            RST+="MOVE '${DBNAME}_Data_01' TO '/var/opt/mssql/data/${DBNAME}.ndf', "
        fi

        RST+="MOVE '${DBNAME}_log' TO '/var/opt/mssql/data/${DBNAME}_log.ldf'"

        echo "$0: $RST"
        sqlcmd -C -U sa -P "$SA_PASSWORD" -Q "$RST" ;;
    *.sql)    echo "$0: running $f"; sqlcmd -C -U SA -P "$SA_PASSWORD" -X -i "$f"; echo ;;
    *.sql.gz) echo "$0: running $f"; gunzip "$f"; sqlcmd -C -U SA -P "$SA_PASSWORD" -X -i "${f%.gz}"; echo ;;
    *)        echo "$0: ignoring $f" ;;
  esac
  echo
done

echo "$0: SQL Server Database ready, listing .."
sqlcmd -C -U SA -P "$SA_PASSWORD" -Q 'SELECT Name FROM sys.Databases'
