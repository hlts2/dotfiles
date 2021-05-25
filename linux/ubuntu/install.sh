#!/bin/sh

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
