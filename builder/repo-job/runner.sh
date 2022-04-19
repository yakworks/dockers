#!/bin/bash

set -e

GITHUB_BASE_URL="github.com/$GITHUB_PROJECT.git"
GITHUB_URL="https://dummy:${GITHUB_TOKEN}@$GITHUB_BASE_URL"

# set branch to master if not set
: ${GITHUB_BRANCH:=master}

# clone to /site
git clone $GITHUB_URL git-project -b $GITHUB_BRANCH --single-branch --depth 1
cd git-project

echo "--- calling make $MAKE_BULD_TARGET --"

make "$MAKE_BULD_TARGET"
