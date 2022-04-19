#!/bin/bash

set -e

if [ ! "$GITHUB_TOKEN" ]; then
  export GITHUB_TOKEN=$([ -f /etc/bot-secrets/GITHUB_TOKEN ] && cat /etc/bot-secrets/GITHUB_TOKEN)
fi

if [ ! "$GPG_KEY" ]; then
  export GPG_KEY=$([ -f /etc/bot-secrets/GPG_KEY ] && cat /etc/bot-secrets/GPG_KEY)
fi

[ ! "$GITHUB_TOKEN" ] && echo "GITHUB_TOKEN must be set" && exit 1
[ ! "$GPG_KEY" ] && echo "GPG_KEY must be set" && exit 1
[ ! "$GITHUB_PROJECT" ] && echo "GITHUB_PROJECT must be set" && exit 1

GITHUB_BASE_URL="github.com/$GITHUB_PROJECT.git"
GITHUB_URL="https://dummy:${GITHUB_TOKEN}@$GITHUB_BASE_URL"

# set branch to master if not set
: ${GITHUB_BRANCH:=master}

# clone to /site
git clone $GITHUB_URL git-project -b $GITHUB_BRANCH --single-branch --depth 1
cd git-project

echo "--- calling make $MAKE_BULD_TARGET --"

make "$MAKE_BULD_TARGET"

# Ah, ha, ha, ha, stayin' alive...
# side effect free keep alive
# while :; do :; done & kill -STOP $! && wait $!