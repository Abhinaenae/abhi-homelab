# Jellyfin on Docker Container

Commands:
```
sudo apt update
sudo apt install docker.io -y
sudo docker pull jellyfin/jellyfin
sudo ./jellyfin.sh #see link below
chmod 700 ./jellyfin.sh #executable privilege
```
jellyfin.sh:
```
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

```
[Link to docker run script](https://github.com/Abhinaenae/abhi-homelab/blob/main/scripts/jellyfin/jellyfin.sh)

Visiting `localhost:8096` will show you the installation screen. 
After setup:
![image](https://github.com/Abhinaenae/abhi-homelab/assets/92381984/0ffe4dbb-cde8-4c15-8eb5-07e190cfbecc)
