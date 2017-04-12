#!/bin/bash
docker build -f Dockerfile.x86 -t registry.snafui.com:5000/mrtg:x86 .
docker push registry.snafui.com:5000/mrtg:x86
docker tag registry.snafui.com:5000/mrtg:x86 ggosselin/mrtg:x86
docker push ggosselin/mrtg:x86
docker rmi registry.snafui.com:5000/mrtg:x86
docker rmi ggosselin/mrtg:x86
