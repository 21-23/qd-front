#!/bin/sh

game="_qd"

# actually build the ui
echo "[$game] 🏗"
docker build -t qd_front_ui__qd -f ./dockerfiles/ui._qd.Dockerfile .

# copy the built ui files to host
echo "[$game] create 🎁"
id=$(docker create qd_front_ui__qd)

echo "[$game] copy 🗂"
docker cp $id:/_qd/dist/. "$(pwd)"/static/2123/_qd/

echo "[$game] remove 🎁"
docker rm -v $id

echo "[$game] done 🏁"