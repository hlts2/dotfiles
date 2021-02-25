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
     openssh-server \
     wget
         
# for docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(. /etc/os-release; echo "$UBUNTU_CODENAME") stable"
sudo apt-get update
sudo apt-get install docker-ce
sudo usermod -aG docker $(whoami)
sudo systemctl enable docker

# for go
wget https://golang.org/dl/go1.16.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.16.1.linux-amd64.tar.gz

echo 'export GOPATH=$HOME/go' >> $HOME/.bashrc
echo 'export GOROOT=/usr/local/go' >> $HOME/.bashrc
echo 'export PATH=$PATH:$GOPATH/bin:$GOROOT/bin' >> $HOME/.bashrc
echo 'export GO111MODULE=on' >> $HOME/.bashrc

sudo shutdown -r now
