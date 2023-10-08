#!/bin/bash

docker build -t kmpm/fritzbuild-base:latest ./base
docker build -t kmpm/fritzbuild-ngspice:latest -f compontents/Dockerfile.ngspice ./components


