# Lets-Encrypt-Smart-Renew
Check the remaining validity period of a certificate before renewing.

For further details see my blog post [here](https://scotthelme.co.uk/lets-encrypt-smart-renew/).The official Let's Encrypt [documentation](https://letsencrypt.readthedocs.org/en/latest/using.html#renewal), and my article on [Getting started with Let's Encrypt!](https://scotthelme.co.uk/setting-up-le/), recommend calling the renewal script every 30 days. This means there are only 2 opportunities to successfully renew before the certificate expires. Calling the renewal more frequently is wasteful and could cause issues with rate limits depending on your usage.

Let's Encrypt Smart Renew will check the remaining validity period of the certificate before calling your existing renewal script. Once the remaining validity falls below a set threshold, it will action the renewal. This means the script can be called much more frequently. 

Replace your existing crontab entry with smartRenew.sh and update it to call your renewal script.

    0 * * * * /path/to/smartRenew.sh
