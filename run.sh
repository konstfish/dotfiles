printf "[>] overwrite zshrc? (y/n):  "
read order
if [ $order == "y" ] ; then
    cp .zshrc ~/.zshrc
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
cp code/settings.json $HOME/Library/Application\ Support/VSCodium/User/settings.json
cat code/code_extensions.txt | xargs codium --install-extension

echo "[*] install/setup node & bun"
nvm install 18 && nvm use 18

curl -fsSL https://bun.sh/install | bash

echo "[*] install spaceship prompt"
npm install -g spaceship-prompt

printf "[>] install fonts? (y/n):  "
read order
if [ $order == "y" ] ; then
    cp $HOME/Documents/Documents/fonts/* /Library/Fonts/
fi
