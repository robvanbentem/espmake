FROM ubuntu:16.04
MAINTAINER Rob van Bentem <robvanbentem@gmail.com>

RUN apt-get update
RUN apt-get install -y make autoconf automake libtool gcc g++ gperf flex bison texinfo gawk ncurses-dev libexpat-dev python python-serial sed git unzip bash build-essential bzip2 vim wget libtool-bin screen sudo curl zsh


## Create esp user and install zsh
RUN useradd -ms `which zsh` esp
RUN echo "esp ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git /home/esp/.oh-my-zsh \
    && cp /home/esp/.oh-my-zsh/templates/zshrc.zsh-template /home/esp/.zshrc
RUN chown -R esp:esp /home/esp

## Switch to the esp user
USER esp
WORKDIR /home/esp
RUN mkdir build
ENV LC_ALL en_US.UTF-8
ENV SDK_BASE /home/esp/esp-open-sdk/sdk
ENV ESP_HOME /home/esp/esp-open-sdk
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/esp/esp-open-sdk/xtensa-lx106-elf/bin/:/home/esp/esptool2:/home/esp/esp-open-sdk/esptool

#### Download or build esp-open-sdk

## Uncomment these lines o build from source
#RUN git clone --recursive https://github.com/pfalcon/esp-open-sdk.git /home/esp/esp-open-sdk
#WORKDIR /home/esp/esp-open-sdk/
#RUN make

## Uncomment these lines to download precompiled esp-open-sdk
RUN mkdir /home/esp/esp-open-sdk
WORKDIR /home/esp/esp-open-sdk/
RUN wget https://bintray.com/artifact/download/kireevco/generic/esp-open-sdk-1.4.0-linux-x86_64.tar.gz
RUN tar -xvf esp-open-sdk-1.4.0-linux-x86_64.tar.gz


## Build Sming
ENV SMING_HOME /home/esp/Sming/Sming
WORKDIR /home/esp
RUN git clone https://github.com/SmingHub/Sming.git
WORKDIR /home/esp/Sming/Sming
RUN make && make spiffy


## Download and build esptool2
WORKDIR /home/esp
RUN git clone https://github.com/raburton/esptool2
WORKDIR /home/esp/esptool2
RUN make


## Prepare shell
WORKDIR /home/esp/build
CMD ["zsh"]


## Uncomment if you're running *rxvt terminal and have issues with the home/end keys
#ENV TERM rxvt
