#!/bin/sh

game="2123"

# actually build the ui
echo "[$game] 🏗"
docker build -t qd_front_ui_2123 -f ./dockerfiles/ui.2123.Dockerfile .

# copy the built ui files to host
echo "[$game] create 🎁"
id=$(docker create qd_front_ui_2123)

echo "[$game] copy 🗂"
docker cp $id:/landing/dist/. "$(pwd)"/static/2123/

echo "[$game] remove 🎁"
docker rm -v $id

echo "[$game] done 🏁"