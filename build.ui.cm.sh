#!/bin/sh

game="cm"

# actually build the ui
echo "[$game] 🏗"
docker build -t qd_front_ui_cm -f ./dockerfiles/ui.cm.Dockerfile .

# copy the built ui files to host
echo "[$game] create 🎁"
id=$(docker create qd_front_ui_cm)

echo "[$game] copy 🗂"
docker cp $id:/cm/dist-prod/. "$(pwd)"/static/2123/cm/

echo "[$game] remove 🎁"
docker rm -v $id

echo "[$game] done 🏁"
