# Fritzing Build container for Raspberry PI

```shell
docker build -t fritzbuild .

cd ../fritzing-app


docker run -v "$(pwd):/home/bob/fritzing" -w /home/bob/fritzing/build fritzbuild qmake ../phoenix.pro
docker run -v "$(pwd):/home/bob/fritzing" -w /home/bob/fritzing/build fritzbuild make -j16
```
./configure --with-x --enable-xspice --enable-cider --with-readline=yes --enable-openmp --disable-debug CFLAGS="-march=armv8-a+crc -mcpu=cortex-a72 -O2" LDFLAGS="-march=armv8-a+crc -mcpu=cortex-a72 -s"




## Resources
- https://github.com/conan-io/conan-docker-tools/blob/master/modern/base/Dockerfile
- https://github.com/fritzing/fritzing-app/blob/develop/docker/Dockerfile.bionic


### ngspice
- compile flags - https://forums.raspberrypi.com/viewtopic.php?t=288404