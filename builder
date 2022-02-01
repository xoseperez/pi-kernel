#!/bin/bash

# Defaults
IMAGE_NAME=${IMAGE_NAME:-"cross-compile"}
ARCH=${ARCH:-"arm64"}
CORES=${CORES:-0}

# Check if docker installed
docker -v >> /dev/null
if [ $? -eq 1 ]; then
    echo "Docker not installed!!"
    exit
fi

# Build image if it does not exist
docker image ls | grep $IMAGE_NAME >> /dev/null
if [ $? -eq 1 ]; then
    docker build -t $IMAGE_NAME .
fi

# Run builder environment
docker run --rm \
    --device /dev/fuse \
    --cap-add SYS_ADMIN \
    --name $IMAGE_NAME \
    -v "$(pwd)/.build":"/build" \
    -v "$(pwd)/make":"/build/make" \
    -e ARCH=$ARCH \
    -e CORES=$CORES \
    -it $IMAGE_NAME \
    bash
