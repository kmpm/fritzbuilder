#!/bin/bash

cd ../fritzing-app


docker run --rm -it \
    -v "$(pwd):/home/bob/fritzing" \
    -w /home/bob/fritzing/build \
    -u bob:bob \
    kmpm/fritzbuild \
    bash