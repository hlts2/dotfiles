#!/bin/sh

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install \
     apt-transport-https \ 
     ca-certificates \
     curl \
     dbus-x11 \
     git \
     gnupg-agent \
     iwd \
     software-properties-common
     tmux
     vim \
     openssh-server
         
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(. /etc/os-release; echo "$UBUNTU_CODENAME") stable"
sudo apt-get update
sudo apt-get install docker-ce
sudo usermod -aG docker $(whoami)
sudo systemctl enable docker

cd $HOME; git clone https://github.com/hlts2/dotfiles.git; cd dotfiles; make link

sudo shutdown -r now
