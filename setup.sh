#!/bin/bash

echo "🛠️ Installing Xcode Tools..."
xcode-select --install

if test ! $(which brew); then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "✨ Installing Homebrew Software..."

brew bundle install

echo "💫 Making Zsh Great..."
curl -L http://install.ohmyz.sh | sh
cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git && git clone https://github.com/zsh-users/zsh-autosuggestions.git
echo "plugins=(git zsh-syntax-highlighting zsh-autosuggestions)" >> ~/.zshrc

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$(whoami)/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)" 

echo "🤖 Changing Mac Settings..."

# Show all file extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

#"Showing icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

# Disable showing recents in dock
defaults write com.apple.dock show-recents -bool false

echo "💻 Installing Latest Version of Xcode..."
xcodes install --latest --experimental-unxip

echo "📱 Building ControlRoom For Simulator..."
mkdir ~/Developer
cd ~/Developer
git clone https://github.com/twostraws/ControlRoom
cd ~/Developer/ControlRoom
xcodebuild -scheme "Release - ControlRoom" DSTROOT="/" archive

echo "🖱️ Building Mac Mouse Fix..."
cd ~/Developer
git clone https://github.com/noah-nuebling/mac-mouse-fix
cd ~/Developer/mac-mouse-fix
xcodebuild -scheme "App - Release" DSTROOT="/" archive

echo "⛺️ Setting Up Dock..."

curl -sL $(curl --silent "https://api.github.com/repos/kcrawford/dockutil/releases/latest" | jq -r '.assets[].browser_download_url' | grep pkg) -o /tmp/dockutil.pkg
sudo installer -pkg "/tmp/dockutil.pkg" -target /
rm /tmp/dockutil.pkg

dockutil --remove all --no-restart

dockapps=( 
    "/Applications/Safari.app" 
    "/System/Applications/Mail.app"
    "/Applications/Things3.app"
    "/Applications/Craft.app"
)

for app in "${dockapps[@]}"
do 
    dockutil --add "$app" --no-restart
done

dockutil --add ~/Downloads --display stack --no-restart

echo "🧹 Cleaning Up..."
brew cleanup

echo "✅ Done!"