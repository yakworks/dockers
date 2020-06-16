#!/bin/sh
set -e

cp /opt/default.conf /etc/nginx/conf.d/default.conf

# If it has a user login then assume its security
if [ $AUTH_USERNAME ]; then
  if [ -z $AUTH_PASSWORD ]; then
    echo >&2 "AUTH_PASSWORD must be set"
    exit 1
  fi
  htpasswd -bBc /etc/nginx/auth.htpasswd $AUTH_USERNAME $AUTH_PASSWORD
  # overwrite with the auth.conf
  cp /opt/auth.conf /etc/nginx/conf.d/default.conf
fi

echo "--- start nginx --"
nginx -g "daemon off;"
