#!/bin/bash

exists=$(docker image ls -a | grep ft2m/opengrok-app)
if [ -z "$exists" ]; then
    date +"%F %T Docker image not exists. Building image..."
    docker build -t ft2m/opengrok-app .
    [ $? -eq 0 ]  || exit 1
    date +"%F %T Image built"
fi

# Define the host folders
export SRC_FOLDER=~/opengrok/opengrok-src/
export ETC_FOLDER=~/opengrok/opengrok-etc/
export DATA_FOLDER=~/opengrok/opengrok-data/
export SSH_FOLDER=~/.ssh/

if [ ! -d "$SRC_FOLDER" ]; then
    date +"%F %T Creating src folder..."
    mkdir -p $SRC_FOLDER
fi

if [ ! -d "$ETC_FOLDER" ]; then
    date +"%F %T Creating etc folder..."
    mkdir -p $ETC_FOLDER
fi

if [ ! -d "$DATA_FOLDER" ]; then
    date +"%F %T Creating data folder..."
    mkdir -p $DATA_FOLDER
fi

# index interval in minutes
export REINDEX=60
export BRANCH=develop

# run the application
date +"%F %T Start application"
docker-compose up -d
