#!/bin/bash

# The remaining life on our certificate below which we should renew (7 days).
RENEW=7
# Set date for backup
TODAY=`date '+%Y_%m_%d'`
# If the certificate has less life remaining than we want.
if ! openssl x509 -checkend $[ 86400 * $RENEW ] -noout -in /path/to/cert.pem
        then
                # Then make backup copy of existing cert before starting renew
                cp /path/to/cert.pem /path/to/old/signed_backup_$TODAY.pem
                # Then call the renewal script.
                ./renew.sh
fi
