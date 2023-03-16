#!/usr/bin/env bash

set -eo pipefail # strict mode https://bit.ly/36MvF0T

declare -i cronfilter_configured=1
declare debug="${debug:-false}"

function dbug {
  [[ ${debug} = 'true' ]] && echo $@
}

# Compare current hour with environment and execute target if there's a match.
[ -z "$CRONFILTER_LOCALE" ]        && cronfilter_configured=0
[ -z "$CRONFILTER_LOCAL_HOURS" ]   && cronfilter_configured=0
dbug "CRONFILTER_LOCALE=$CRONFILTER_LOCALE"
dbug "CRONFILTER_LOCAL_HOURS=$CRONFILTER_LOCAL_HOURS"

if [[ $cronfilter_configured -eq 1 ]]; then
  hour=$(TZ="$CRONFILTER_LOCALE" date +%2H)
  dbug "hour=$hour"
  if [[ ! ${hour} =~ ${CRONFILTER_LOCAL_HOURS} ]]; then
    dbug "cron.filter_local_hours: Localtime hours do not match"
    exit 0
  fi
fi

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

