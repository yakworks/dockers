#!/usr/bin/env bash

set -e

if [ ! "$GITHUB_TOKEN" ]; then
  # try reading token in from a volume mounted to secret
  export GITHUB_TOKEN=$([ -f /etc/bot-secrets/GITHUB_TOKEN ] && cat /etc/bot-secrets/GITHUB_TOKEN)
fi

if [ ! "$GPG_KEY" ]; then
  # try reading key in from volume mounted to secret
  export GPG_KEY=$([ -f /etc/bot-secrets/GPG_KEY ] && cat /etc/bot-secrets/GPG_KEY)
fi

[ ! "$GITHUB_TOKEN" ] && echo "GITHUB_TOKEN must be set" && exit 1
[ ! "$GPG_KEY" ] && echo "GPG_KEY must be set" && exit 1
[ ! "$GITHUB_PROJECT" ] && echo "GITHUB_PROJECT must be set" && exit 1

GITHUB_BASE_URL="github.com/$GITHUB_PROJECT.git"
GITHUB_URL="https://dummy:${GITHUB_TOKEN}@$GITHUB_BASE_URL"

# set branch to master if not set
: ${GITHUB_BRANCH:=master}

echo "GITHUB_BASE_URL: $GITHUB_BASE_URL , GITHUB_BRANCH: $GITHUB_BRANCH"

# clone to /site
git clone $GITHUB_URL project -b $GITHUB_BRANCH --single-branch --depth 1
cd project
