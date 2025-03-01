printf "[!] this script relies heavily on icloud content being there"
read confirm

echo "[*] install brew"
if command -v brew &>/dev/null ; then
    brew upgrade
else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "[*] install brew packages"
cat brew/brew_packages.txt | xargs brew install

echo "[*] install brew casks"
cat brew/brew_casks.txt | xargs brew install --cask

echo "[*] copy vscode settings & install extensions"
cp code/settings.json ~/Library/Application\ Support/VSCodium/User/settings.json
cat code/code_extensions.txt | xargs codium --install-extension

echo "[*] install/setup node & bun"
nvm install 22 && nvm use 22

curl -fsSL https://bun.sh/install | bash

echo "[*] install uv"
curl -LsSf https://astral.sh/uv/install.sh | sh

echo "[*] install starship prompt"
curl -sS https://starship.rs/install.sh | sh

echo "[*] setup home folder"
cp -r home/* ~/

echo "[*] setup .ssh"
cp /Users/david/Documents/Documents/keys/* ~/.ssh/
chmod 600 ~/.ssh/*

echo "[*] setup nano"
curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh

echo "[*] setup iterm2"
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.config/iterm2/"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

echo "[*] copy preferences"
cp prefernces/com.manytricks.Moom.plist ~/Library/Preferences/com.manytricks.Moom.plist

echo "[*] install fonts"
if [ -d "/Users/david/Documents/Documents/fonts" ]; then
    cp /Users/david/Documents/Documents/fonts/* /Library/Fonts/
fi

echo "[*] macos defaults"
defaults write com.apple.dock "tilesize" -int "42"
defaults write com.apple.dock "autohide" -bool "true"

defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
defaults write com.apple.finder "ShowPathbar" -bool "true"
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"
defaults write com.apple.universalaccess "showWindowTitlebarIcons" -bool "true"
defaults write com.apple.dock mru-spaces -bool "false"

killall Dock

defaults write NSGlobalDomain _HIHideMenuBar -bool "true"
defaults write com.apple.finder "ShowHardDrivesOnDesktop" -bool "true"
defaults write com.apple.finder "ShowMountedServersOnDesktop" -bool "true"

osascript -e 'tell application "Finder" to set desktop picture to "/Users/david/Documents/Wallpaper/-zgH.png" as POSIX file'

killall Finder

echo "[*] yabai/skhd/sketchybar"

cp shell/.skhdrc ~/.skhdrc
skhd --install-service

cp shell/.yabairc ~/.yabairc
yabai --install-service

brew services start sketchybar

echo "[*] etc"
touch ~/.hushlogin

echo "[!] done, goodbye"