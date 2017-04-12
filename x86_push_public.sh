#!/bin/bash
docker build -f Dockerfile.x86 -t ggosselin/mrtg .
docker push ggosselin/mrtg
docker rmi ggosselin/mrtg
