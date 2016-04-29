FROM ubuntu:16.04
MAINTAINER Rob van Bentem

RUN apt-get update
RUN apt-get install -y make autoconf automake libtool gcc g++ gperf flex bison texinfo gawk ncurses-dev libexpat-dev python python-serial sed git unzip bash build-essential bzip2 vim wget libtool-bin screen sudo

RUN useradd -ms /bin/bash esp
RUN echo "esp ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER esp
WORKDIR /home/esp

RUN git clone --recursive https://github.com/pfalcon/esp-open-sdk.git /home/esp/esp-open-sdk
WORKDIR /home/esp/esp-open-sdk/
RUN make

WORKDIR /home/esp
RUN mkdir build

WORKDIR /home/esp/build

ENV SDK_BASE /home/esp/esp-open-sdk/sdk
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/esp/esp-open-sdk/xtensa-lx106-elf/bin/

