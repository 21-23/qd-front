#!/bin/sh

# refresh certificates
# https://certbot.eff.org/docs/man/certbot.html
certbot certonly --nginx -d 2123.io -m info@2123.io --agree-tos
