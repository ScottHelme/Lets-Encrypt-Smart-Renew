#!/bin/bash

# Get the current date as seconds since epoch.
NOW=$(date +%s)
# Get the expiry date of our certificate.
EXPIRE=$(openssl x509 -in /path/to/signed.crt -noout -enddate)
# Trim the unecessary text at the start of the string.
EXPIRE=${EXPIRE:9}
# Convert the expiry date to seconds since epoch.
EXPIRE=$(date --date="$EXPIRE" +%s)
# Calculate the time left until the certificate expires.
LIFE=$((EXPIRE-NOW))
# The remaining life on our certificate below which we should renew (7 days).
RENEW=604800
# If the certificate has less life remaining than we want.
if (($LIFE < $RENEW))
        then
                # Then call the renewal script.
                ./path/to/renew.sh
fi
