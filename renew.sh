#!/bin/sh
echo "renew certificates for domains"
# change your domains here
echo 3 | /var/www/letsencrypt/letsencrypt-auto certonly --renew-by-default --email youremail@domain.io -d domain.io --nginx -w /usr/share/nginx/html
echo 3 | /var/www/letsencrypt/letsencrypt-auto certonly --renew-by-default --email youremail@domain.io -d another.domain.io --nginx -w /usr/share/nginx/html
