#!/bin/bash
docker run -d \
 --name jellyfin \
 --user 1000:1000 \
 --net=host \
 --volume /home/alavu/jellyfin/config\
 --volume /home/alavu/jellyfin/cache \
 --mount type=bind,source=/home/alavu/jellyfin/media,target=/media \
 --restart=unless-stopped \
 jellyfin/jellyfin
