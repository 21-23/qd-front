#!/bin/sh

game="cssqd"

# actually build the ui
echo "[$game] 🏗"
docker build -t qd_front_ui_cssqd -f ./dockerfiles/ui.cssqd.Dockerfile .

# copy the built ui files to host
echo "[$game] create 🎁"
id=$(docker create qd_front_ui_cssqd)

echo "[$game] copy 🗂"
docker cp $id:/cssqd/dist-prod/. "$(pwd)"/static/2123/cssqd/

echo "[$game] remove 🎁"
docker rm -v $id

echo "[$game] done 🏁"