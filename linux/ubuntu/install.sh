#!/bin/sh

GO_VERSION=1.16.4

sudo chown -R $(whoami) /usr/local/bin
sudo chmod -R u=rwX,go=rX /usr/local/bin

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get install -y \
    clang \
    cmake \
    ctags \
    curl \
    g++ \
    gauche \
    gawk \
    gcc \
    gem \
    git \
    gnupg \
    graphviz \
    hdf5-helpers \
    hdf5-tools \
    jq \
    libhdf5-dev \
    locales \
    make \
    musl-dev \
    neovim \
    nodejs \
    npm \
    openssh-client \
    openssh-server \
    openssl \
    perl \
    python-pip \
    python3 \
    python3-pip \
    ruby-dev \
    rlwrap \
    sed \
    tar \
    tmux \
    tig \
    tzdata \
    unzip \
    wget \
    zip \
    zsh

sudo apt-get-repository ppa:mmstick76/alacritty
sudo apt-get install -y alacritty

mkdir ~/.npm-global
npm config set prefix '~/.npm-global'

sudo npm install n -g
sudo n stable

sudo apt purge -y nodejs npm

pip2 install --upgrade pip neovim \
    && pip3 install --upgrade pip neovim \
    && npm install -g neovim

pip3 install --upgrade pip \
    ranger-fm

npm install -g \
    yarn

wget https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
