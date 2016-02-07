# Lets-Encrypt-Smart-Renew
Check the remaining validity period of a certificate before renewing.

The official Let's Encrypt documentation, and my article on setting up Let's Encrypt (https://scotthel.me/LE), recommend calling the renewal script every 30 days. This means there are only 2 opportunities to successfully renew before the certificate expires. Calling the renewal more frequently is wasteful and could cause issues with rate limits depending on your usage.

Let's Encrypt Smart Renew will check the remaining validity period of the certificate before calling your existing renewal script. Once the remaining validity falls below a set threshold, it will action the renewal. This means the script can be called much more frequently. 

Replace your existing crontab entry with smartRenew.sh and update it to call your renewal script.

    0 * * * * /path/to/smartRenew.sh
