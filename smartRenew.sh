#!/bin/bash

# The remaining life on our certificate below which we should renew (7 days).
RENEW=7
# If the certificate has less life remaining than we want.
if ! openssl x509 -checkend $[ 86400 * $RENEW ] -noout -in /path/to/signed.crt
        then
                # Then call the renewal script.
                ./path/to/renew.sh
fi
