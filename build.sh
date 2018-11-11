#!/bin/sh

RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "Put default ${RED}fullchain.pem${NC} and ${RED}privkey.pem${NC} to ./cert directory"

docker build -t qd_front -f ./dockerfiles/Dockerfile .