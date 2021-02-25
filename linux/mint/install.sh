#!/bin/sh

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install \
     apt-transport-https \ 
     ca-certificates \
     clang \ 
     cmake \
     curl \
     dbus-x11 \
     gcc \
     git \
     gnupg-agent \
     iwd \
     make \
     musl-dev
     openssh-server \
     software-properties-common \
     tmux \
     vim \
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
echo 'export GOOS="$(go env GOOS)"' >> $HOME/.bashrc
echo 'export GOARCH="$(go env GOARCH)"' >> $HOME/.bashrc
echo 'export CGO_ENABLED=1' >> $HOME/.bashrc
echo 'export GO111MODULE=on' >> $HOME/.bashrc
echo 'export GOBIN=$GOPATH/bin' >> $HOME/.bashrc
echo 'export GO15VENDOREXPERIMENT=1' >> $HOME/.bashrc

sudo shutdown -r now
