#!/usr/bin/env bash

set -eo pipefail # strict mode https://bit.ly/36MvF0T

declare -i cronfilter_configured=1
: "${CRONFILTER_DEBUG:=false}"
: "${CRONFILTER_COMMAND:=/opt/entry.sh}"

function debug {
  [[ ${CRONFILTER_DEBUG} == 'true' ]] && echo $@
}

# Compare current hour with environment and execute target if there's a match.
# This section executes without make, with only values in the environment.
# EVERYTHING needs to be defined in your cronjob deployment yaml.
# CRONFILTER_LOCALE='America/Chicago'
# CRONFILTER_LOCAL_HOURS='02 08 12 16 20 00'
# CRONFILTER_COMMAND is optional, defaults to /opt/entry.sh
# If either of the above variables are not set, this docker will act exactly like repo-job-1.
[ -z "$CRONFILTER_LOCALE" ]        && cronfilter_configured=0
[ -z "$CRONFILTER_LOCAL_HOURS" ]   && cronfilter_configured=0
debug "CRONFILTER_LOCALE=$CRONFILTER_LOCALE"
debug "CRONFILTER_LOCAL_HOURS=$CRONFILTER_LOCAL_HOURS"

if [[ $cronfilter_configured -eq 1 ]]; then
  hour=$(TZ="$CRONFILTER_LOCALE" date +%2H)
  debug "hour=$hour"
  if [[ "$CRONFILTER_LOCAL_HOURS" =~ .*"$hour".* ]]; then
    debug "cron.filter_local_hours: Localtime hours match, starting job at $CRONFILTER_COMMAND"
    ${CRONFILTER_COMMAND}
  else
    echo "cron.filter_local_hours: Localtime hours do not match"
  fi
fi
