#!/bin/bash

echo "🛠️ Installing Xcode Tools..."
xcode-select --install

if test ! $(which brew); then
  echo "🍺 Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "✨ Installing Homebrew Software..."

brew bundle install

echo "🤖 Changing Mac Settings..."

# Show all file extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

