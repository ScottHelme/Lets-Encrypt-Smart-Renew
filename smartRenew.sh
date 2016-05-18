#!/bin/bash

# path to your CRT
CERTPATH=/path/to/signed.crt

# path to your renewal script
RENEWALSCRIPT=/path/to/renew.sh

# enable verbose (debug) mode, shows additional messages
# can also be enabled by passing -v to this script
VERBOSE=0

# -- do not edit below this line --

# shows iso date with time
function isodate {
  local date="$1"
  # handle "now"
  if [[ "$date" = "now" ]]; then
    echo $( date +'%F %T' )
  else
    echo $( date -d "$1" +'%F %T' )
  fi
}

# convert time by Stéphane Gimenez
# modified: do not show too much details if not necessary
# https://unix.stackexchange.com/questions/27013/displaying-seconds-as-days-hours-mins-seconds#answer-27014
function displaytime {
  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  (( $D > 0 )) && printf '%d day(s) and ' $D
  (( $H > 0 )) && printf '%d hour(s) ' $H
  if [[ $H < 1 ]]; then
    (( $M > 0 )) && printf '%d minute(s) ' $M
    (( $D > 0 || $H > 0 || $M > 0 )) && printf 'and '
    printf '%d second(s)\n' $S
  fi
}

# manually enable debug/verbose mode
[[ "$1" = "-v" ]] && VERBOSE=1

# Get the current date as seconds since epoch.
NOW=$(date +%s)
[[ $VERBOSE -ge 1  ]] && echo "current date: $( isodate now )"
# Get the expiry date of our certificate.
EXPIRE=$(openssl x509 -in $CERTPATH -noout -enddate)
# Trim the unecessary text at the start of the string.
EXPIRE=${EXPIRE:9}
[[ $VERBOSE -ge 1 ]] && echo "certificate will expire at $( isodate "$EXPIRE" )"
# Convert the expiry date to seconds since epoch.
EXPIRESEC=$(date --date="$EXPIRE" +%s)
# Calculate the time left until the certificate expires.
LIFE=$((EXPIRESEC-NOW))
[[ $VERBOSE -ge 1 ]] && echo "certificate will expire in $( displaytime $LIFE )"
# The remaining life on our certificate below which we should renew (10 days).
RENEW=864000
# If the certificate has less life remaining than we want.
if (($LIFE < $RENEW))
        then
                echo "[$( isodate now )] certificate renewal triggered; expires: $( isodate "$EXPIRE" ), time remaining: $( displaytime $LIFE ) ($LIFE sec)"
                # Then call the renewal script.
                $RENEWALSCRIPT
else
  [[ $VERBOSE -ge 1 ]] && echo "certificate will not be renewed"
fi
