#!/bin/sh

game="jsqd"

# actually build the ui
echo "[$game] 🏗"
docker build -t qd_front_ui_jsqd -f ./dockerfiles/ui.jsqd.Dockerfile .

# copy the built ui files to host
echo "[$game] create 🎁"
id=$(docker create qd_front_ui_jsqd)

echo "[$game] copy 🗂"
docker cp $id:/jsqd/dist-prod/. "$(pwd)"/static/2123/jsqd/

echo "[$game] remove 🎁"
docker rm -v $id

echo "[$game] done 🏁"