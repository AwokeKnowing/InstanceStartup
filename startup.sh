############## Install the CUDA and NVIDIA Drivers
#!/bin/bash
echo "Checking for CUDA and installing."
# Check for CUDA and try to install.
if ! dpkg-query -W cuda-8-0; then
  # The 16.04 installer works with 16.10.
  curl -O http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
  dpkg -i ./cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
  apt-get update
  apt-get install cuda-8-0 -y
fi
# Enable persistence mode
nvidia-smi -pm 1


############## Install Docker
if ! dpkg-query -W docker; then
  curl -sSL https://get.docker.com/ | sh
fi

############# NVIDIA_DOCKER
if ! dpkg-query -W nvidia-docker; then 
  wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb
  dpkg -i /tmp/nvidia-docker*.deb
fi

############ Docker-Compose
if ! [ -x "/usr/local/bin/docker-compose" ]; then 
 curl -L https://github.com/docker/compose/releases/download/1.15.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
fi

########### Get Pip
if ! which pip; then
  sudo apt-get install python-pip
fi

########### nvidia-docker-compose
if ! [ -x "/usr/local/bin/nvidia-docker-compose" ]; then 
  pip install nvidia-docker-compose
fi 

########## Setup Alias and add a group for Docker to run docker w/o sudo
if ! alias | grep doc; then
  groupadd docker
  gpasswd -a $USER docker
  newgrp docker
  # create alias for doc
  echo "alias doc='nvidia-docker-compose'" >> ~/.bashrc
  echo "alias docl='doc logs -f --tail=100'" >> ~/.bashrc
  source ~/.bashrc
fi
