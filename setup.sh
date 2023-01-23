#!/bin/bash

echo "🛠️ Installing Xcode Tools..."
xcode-select --install

if test ! $(which brew); then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$(whoami)/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)" 
fi

echo "✨ Installing Homebrew Software..."

brew bundle install

echo "🤖 Changing Mac Settings..."

# Show all file extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

