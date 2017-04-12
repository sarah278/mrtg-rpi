#!/bin/bash

docker tag registry.snafui.com:5000/mrtg:rpi ggosselin/mrtg:rpi
docker push ggosselin/mrtg:rpi
docker rmi ggosselin/mrtg:rpi
