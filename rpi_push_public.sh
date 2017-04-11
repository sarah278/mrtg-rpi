#!/bin/bash
docker build -f Dockerfile.rpi -t ggosselin/mrtg:rpi .
docker push ggosselin/mrtg:rpi
