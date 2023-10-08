# Fritzing Build container for Raspberry PI
This is very much a work in progress. 
It will most likely __not work at all__ as long as this warning exists.

## Principle of operation
Compiling on the an RPI4 is somewhat slow and during the development of
this image I didn't want to recompile more then neccesary when something
in the chain had to be redone. That was basis of this setup of layers
of images that each dependency is copied from.

- A base image `kmpm/fritzbuild-base` is created with all standard
  Debian packages that will be needed to build the rest.

- A separate docker image is being built for each `component`
  that fritzing depends on like quazip, ngspice, libgit2.

- The master docker images is created from the base but it copies
  all the component folders from the component-images.

The only thing that is raspberry specific at the moment are some 
`CFLAGS` and `LDFLAGS` for the [ngspice component](./components/Dockerfile.ngspice)


## Usage

```shell
clone http://github.com/kmpm/fritzbuild
clone https://github.com/fritzing/fritzing-app

# create the docker images
cd fritzbuild
make

# build fritzing using the images
cd ../fritzing-app

docker run -v "$(pwd):/home/bob/fritzing" -w /home/bob/fritzing/build kmpm/fritzbuild qmake ../phoenix.pro
docker run -v "$(pwd):/home/bob/fritzing" -w /home/bob/fritzing/build kmpm/fritzbuild make -j2
```


## Resources

### Build environment

- https://github.com/fritzing/fritzing-app/blob/develop/docker/Dockerfile.bionic
- https://github.com/conan-io/conan-docker-tools/blob/master/modern/base/Dockerfile


### ngspice
- https://ngspice.sourceforge.io/
- compile flags - https://forums.raspberrypi.com/viewtopic.php?t=288404
