#!/usr/bin/env bash

# exit when any command fails
set -e

if [ -z ${SERVICE_NAME+x} ];then 
    echo "SERVICE_NAME env variable is not set"
    exit 1
fi

initialSleep=${INITIAL_SLEEP:-10}
echo "dig is like nslookup uses the OS lookup"
echo "sleeping for $initialSleep s and then starting dig $SERVICE_NAME"

sleep $initialSleep # give it an 10 seconds before trying as it helps with however caching works

until [[ $(dig +search +short $SERVICE_NAME) ]]; do 
    echo waiting for dig $SERVICE_NAME
    sleep 1 
done

echo "**** dig got an answer from $SERVICE_NAME ****"
dig +search $SERVICE_NAME
