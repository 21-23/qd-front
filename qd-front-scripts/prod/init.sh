#!/bin/sh

# start crond job
crond -L /var/log/crond.log

# https://certbot.eff.org/docs/man/certbot.html
certbot --nginx -d 2123.io -d www.2123.io -m info@2123.io --agree-tos --non-interactive

# auto-renew certificates
SLEEPTIME=$(awk 'BEGIN{srand(); print int(rand()*(3600+1))}'); echo "0 0,12 * * * sleep $SLEEPTIME && certbot renew -q" | tee -a /etc/crontabs/root > /dev/null
