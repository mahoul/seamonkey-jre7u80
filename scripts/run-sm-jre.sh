#!/bin/bash

DOCKER_IMG=mahoul/seamonkey-jre7u80

xhost +

docker run --rm --network=host \
--name dockermonkey --hostname dockermonkey \
-v /etc/localtime:/etc/localtime:ro -v /tmp/.X11-unix:/tmp/.X11-unix \
-e DISPLAY=unix$DISPLAY $DOCKER_IMG $*

