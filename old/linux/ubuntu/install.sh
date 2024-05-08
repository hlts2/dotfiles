#!/bin/sh

GO_VERSION=1.16.4

sudo chown -R $(whoami) /usr/local/bin
sudo chmod -R u=rwX,go=rX /usr/local/bin

xmodmap -pke > ~/.Xmodmap_default
xmodmap -e "keycode 100 = Hiragana NoSymbol Hiragana"

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
    python3-venv \
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


# Install deps for k8s

## kubectl
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

## kubectx && kubens
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens

## kustomize
curl -s "https://raw.githubusercontent.com/\
kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
sudo mv ./kustomize /usr/local/kustomize

## helmfile
wget https://github.com/roboll/helmfile/releases/download/v0.139.7/helmfile_linux_amd64
chmod +x helmfile_linux_amd64 && sudo mv helmfile_linux_amd64 /usr/local/bin/helmfile

## stern
wget https://github.com/wercker/stern/releases/download/1.11.0/stern_linux_amd64
chmod +x stern_linux_amd64
sudo mv stern_linux_amd64 /usr/local/bin/stern

## k9s
curl -sS https://webinstall.dev/k9s | bash
