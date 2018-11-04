#!/bin/sh

# start crond job
crond -bS -l 8 -L /var/log/crond.log
# refresh certificates
/etc/periodic/weekly/acme-client