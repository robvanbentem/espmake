### ESPMAKE

#### Into

ESP8266 buildbox based on Ubuntu 16.04 with the esp-open-sdk toolchain and the Sming framework. See https://github.com/pfalcon/esp-open-sdk and https://github.com/SmingHub/Sming for more info.

#### How to build and run

First build the docker container: `docker build -t espmake .`

Once the container has been built, run it: ``docker run -v `pwd`:/home/esp/build -ti espmake /bin/zsh``

The ``-v `pwd`:/home/esp/build`` argument mounts your current working directory (the directory you're currently in) to the ~/build dir on the container.

Once you're in the container you are logged in as the "esp" user and the working dir is /home/esp/build. There you can simply run `make` and the firmware will be compiled.

Additionally you can also append `--device /dev/ttyUSB0` (or USB1, USB2, etc..) to passthrough your usb device to the container so you can flash it directly.

The path to the sdk files is `/home/esp/esp-open-sdk/sdk` and the `SDK_BASE` env variable is pointing to it. The Dockerfile is pretty straightforward and easy to modify to your specific needs.

Good luck!


#### Full example

```bash
$ git clone https://github.com/robvanbentem/espmake && cd espmake

$ sudo docker build -t espmake . #building can take 10-60 minutes depending on your machine

$ cd <your project path>

$ sudo docker run -v `pwd`:/home/esp/build -ti espmake /bin/zsh

$ make
```

