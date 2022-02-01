FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get clean && apt-get update && \
    apt-get install -y \
    git bc sshfs bison flex libssl-dev make kmod libc6-dev libncurses5-dev zip unzip \
    crossbuild-essential-armhf \
    crossbuild-essential-arm64

RUN mkdir /build
WORKDIR /build
VOLUME ["/build"]
CMD tail -f /dev/null
