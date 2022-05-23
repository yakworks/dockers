#!/usr/bin/env bash

set -e

echo "Job started at `date '+%Y%m%d-%H%M%S'`"

[ "$SKIP_CLONE" != "true" ] && source "$(dirname "${BASH_SOURCE[0]}")"/clone.sh

if [ "$MAKE_BUILD_TARGET" ]; then
  echo "calling MAKE_BUILD_TARGET $MAKE_BUILD_TARGET"
  make "$MAKE_BUILD_TARGET"
else
  echo "calling BUILD_SCRIPT_TARGET $BUILD_SCRIPT_TARGET"
  eval "$BUILD_SCRIPT_TARGET"
fi


# # Ah, ha, ha, ha, stayin' alive...
# # side effect free keep alive
# # while :; do :; done & kill -STOP $! && wait $!

echo "Job finished at `date '+%Y%m%d-%H%M%S'`"