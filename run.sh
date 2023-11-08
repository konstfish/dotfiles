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
mkdir -p ~/.config && cp shell/starship.toml ~/.config/starship.toml

printf "[>] install fonts"
if [ -d "/Users/david/Documents/Documents/fonts" ]; then
    cp /Users/david/Documents/Documents/fonts/* /Library/Fonts/
fi

echo "[*] etc"
touch ~/.hushlogin