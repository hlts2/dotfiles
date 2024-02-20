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
BAT_VERSION=0.18.0
HANDOLINT_VERSION=1.15.0
KUBECTL_VERSION=1.17.2
STERN_VERSION=1.11.0
K9S_VERSION=0.24.7
KIND_VERSION=0.7.0

# bat
wget https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat-v${BAT_VERSION}-x86_64-apple-darwin.tar.gz
tar -zxvf bat-v${BAT_VERSION}-x86_64-apple-darwin.tar.gz
cd bat-v${BAT_VERSION}-x86_64-apple-darwin/
chmod +x bat
mv bat /usr/local/bin/bat

# -- For Kubernetes --
## kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/darwin/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

## stern
curl -Lo stern https://github.com/wercker/stern/releases/download/${STERN_VERSION}/stern_Darwin_amd64
chmod +x stern
sudo mv ./stern /usr/local/bin/stern

## k9s
wget https://github.com/derailed/k9s/releases/download/v${K9S_VERSION}/k9s_${K9S_VERSION}_Darwin_x86_64.tar.gz
tar -xvf k9s_${K9S_VERSION}_Darwin_x86_64.tar.gz
rm -rf k9s_${K9S_VERSION}_Darwin_x86_64.tar.gz
chmod +x k9s
sudo mv ./k9s /usr/local/bin/k9s
