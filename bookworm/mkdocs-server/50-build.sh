#!/bin/bash

#set -e

#NOTE:
# 1. pulls the github project
# 2. runs either the MAKE_BULD_TARGET or just calls mkdocs build
# 3. nginx:bookworm base image will start after it runs this and other scripts added in order

GITHUB_BASE_URL="github.com/$GITHUB_PROJECT.git"
GITHUB_URL="https://dummy:${GITHUB_TOKEN}@$GITHUB_BASE_URL"

# set branch to master if not set
: ${GITHUB_BRANCH:=master}

echo "$GITHUB_URL"
# clone to /site
git clone $GITHUB_URL git-project -b $GITHUB_BRANCH --single-branch --depth 1
cd git-project

echo "--- building mkdocs site --"

if [ "$MAKE_BULD_TARGET" ]; then
  make "$MAKE_BULD_TARGET"
else
  mkdocs build
  cp -r ./site /site
fi

