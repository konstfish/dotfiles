printf "[>] overwrite zshrc? (y/n):  "
read order
if [ $order == "y" ] ; then
    cp shell/.zshrc ~/.zshrc
fi

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
nvm install 18 && nvm use 18

curl -fsSL https://bun.sh/install | bash

echo "[*] install starship prompt"
curl -sS https://starship.rs/install.sh | sh
mkdir -p ~/.config && cp shell/.config/starship.toml ~/.config/starship.toml

echo "[*] setup .config"
cp -r shell/.config/neofetch ~/.config/neofetch

cp shell/.gitconfig ~/.gitconfig

echo "[*] setup .ssh"
mkdir -p ~/.ssh && cp shell/.ssh/config ~/.ssh/config
cp /Users/david/Documents/Documents/keys/* ~/.ssh/
chmod 600 ~/.ssh/*

echo "[*] setup nano"
cp shell/.nanorc ~/.nanorc
curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh

echo "[*] setup iterm2"
if ! [ -f ~/Documents/Configuration/com.googlecode.iterm2.plist ]; then
  mkdir -p ~/Documents/Configuration/
  cp shell/com.googlecode.iterm2.plist ~/Documents/Configuration/com.googlecode.iterm2.plist
fi

defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/Documents/Configuration/"
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

killall Dock

defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
defaults write com.apple.finder "ShowPathbar" -bool "true"
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"
defaults write com.apple.universalaccess "showWindowTitlebarIcons" -bool "true"

defaults write com.apple.finder "ShowHardDrivesOnDesktop" -bool "true"
defaults write com.apple.finder "ShowMountedServersOnDesktop" -bool "true"

killall Finder

osascript -e 'tell application "Finder" to set desktop picture to "/Users/david/Documents/Wallpaper/-zgH.png" as POSIX file'

echo "[*] etc"
touch ~/.hushlogin

echo "[!] done"
echo "todo: setup wakatime, raycast, iterm2"