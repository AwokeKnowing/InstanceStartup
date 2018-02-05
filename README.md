# InstanceStartup
simple repo for keeping eye on startup script for docker, nvidia-docker and nvidia-docker-compose. 

## HOW TO
1. `sudo bash startup.sh` will install everything and add you to the group
2. reboot the instance

## Also Contains Dockerfile for Tensorflow
1. Builds a tensorflow image

This script installs:
1. Nvidia Drivers
2. Docker
3. Nvidia-Docker
4. Docker-Compose
5. Nvidia-Docker-Compose
6. Assigns nvidia-docker-compose to doc as an alias
