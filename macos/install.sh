#!bin/bash

# Ask for the administrator password upfront
sudo -v

xcode-select --install

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap homebrew/bundle
brew update
brew upgrade --all
brew cleanup
brew bundle

# Because did not install with the brew bundle
brew tap caskroom/fonts
brew cask install font-fira-code

gem update --system

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# -- For Docker
## hadolint
curl -L -O https://github.com/hadolint/hadolint/releases/download/v1.15.0/hadolint-$(uname)-x86_64
mv hadolint-$(uname)-x86_64 hadolint
chmod +x hadolint
sudo mv ./hadolint /usr/local/bin/hadolint

# -- For Kubernetes --
## kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.17.0/bin/darwin/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

## stern
curl -Lo stern https://github.com/wercker/stern/releases/download/1.11.0/stern_$(uname)_amd64
chmod +x stern
mv ./stern /usr/local/bin/stern

## k9s
wget https://github.com/derailed/k9s/releases/download/v0.13.6/k9s_0.13.6_$(uname)_x86_64.tar.gz
tar -xvf k9s_0.13.6_Darwin_x86_64.tar.gz
rm -rf k9s_0.13.6_Darwin_x86_64.tar.gz
chmod +x k9s
mv ./k9s /usr/local/bin/k9s

## kind
curl -Lo ./kind "https://github.com/kubernetes-sigs/kind/releases/download/v0.7.0/kind-$(uname)-amd64"
chmod +x kind
mv ./kind /usr/local/kind
