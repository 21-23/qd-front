#!/bin/sh

echo "Remove previous container"
docker rm qd_front 2>/dev/null

echo "Start qd_front"
docker run -d --name qd_front -p 80:80 -p 443:443 -p 3001:3001 qd_front

echo "Wait for container"
sleep 5

echo "Execute init script"
docker exec qd_front sh /usr/share/qd-front-scripts/init.sh

echo "Done"