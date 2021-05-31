#!/bin/sh

# https://certbot.eff.org/docs/man/certbot.html
certbot certonly --nginx -d 2123.io -m info@2123.io --agree-tos

# auto-renew certificates
SLEEPTIME=$(awk 'BEGIN{srand(); print int(rand()*(3600+1))}'); echo "0 0,12 * * * root sleep $SLEEPTIME && certbot renew -q" | tee -a /etc/crontabs/root > /dev/null
