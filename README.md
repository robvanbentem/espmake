### ESPMAKE

#### Into

ESP8266 buildbox bases on Ubuntu 16.04 with the esp-open-sdk toolchain See https://github.com/pfalcon/esp-open-sdk for more info.

#### How to build

First build the docker container: `docker build -t espmake .`


Once the container has been built, run it: ``docker run -v `pwd`:/home/esp/build -ti esp /bin/bash``

The ``-v `pwd`:/home/esp/build`` argument mount the current working directory to the ~/build dir on the container.

Once you're in the container you can simply run `make` and the firmware will be compiled.

Good luck!
