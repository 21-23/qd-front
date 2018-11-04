#!/bin/sh

# start crond job
crond -bS -l 0 -L /var/log/crond.log