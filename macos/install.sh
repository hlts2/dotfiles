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

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
