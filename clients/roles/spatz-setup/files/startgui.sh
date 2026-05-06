#!/bin/bash
xhost +
docker run --rm -ti --net=host --env="DISPLAY" -v /var/run/docker.sock:/var/run/docker.sock -v /tmp/tmux-spatz:/tmp/tmux-spatz spatz_display