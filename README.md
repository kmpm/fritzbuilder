# Fritzing Build container for Raspberry PI
This is very much a work in progress. 
It will most likely __not work at all__ as long as this warning exists.

```shell
clone http://github.com/kmpm/fritzbuild
clone https://github.com/fritzing/fritzing-app

# create the docker images
cd fritzbuild
make

# build fritzing using the images
cd ../fritzing-app

docker run -v "$(pwd):/home/bob/fritzing" -w /home/bob/fritzing/build fritzbuild qmake ../phoenix.pro
docker run -v "$(pwd):/home/bob/fritzing" -w /home/bob/fritzing/build fritzbuild make -j2
```


## Resources
- https://github.com/conan-io/conan-docker-tools/blob/master/modern/base/Dockerfile
- https://github.com/fritzing/fritzing-app/blob/develop/docker/Dockerfile.bionic


### ngspice
- compile flags - https://forums.raspberrypi.com/viewtopic.php?t=288404