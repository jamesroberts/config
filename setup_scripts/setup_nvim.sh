#!/usr/bin/env bash

set -e

cd ~

sudo rm -rf /usr/bin/nvim

mkdir -p ~/.local/

if [[ $OSTYPE == 'darwin'* ]]; then
    brew install wget
    brew install neovim
    brew install ripgrep
    brew install fontconfig
    brew install homebrew/cask-fonts/font-jetbrains-mono-nerd-font
else
    rm -f nvim.appimage
    sudo rm -rf /squashfs-root/
    curl -LO https://github.com/neovim/neovim-releases/releases/download/v0.10.1/nvim.appimage
    # curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage

    chmod u+x nvim.appimage

    ./nvim.appimage --appimage-extract
    ./squashfs-root/AppRun --version

    sudo mv -f squashfs-root /
    sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

    if command -v apt-get >/dev/null; then
        sudo apt-get install ripgrep
    elif command -v yum >/dev/null; then
        sudo yum install -y yum-utils
        sudo yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
        sudo yum install ripgrep
    else
        sudo snap install ripgrep
    fi

    echo "Installing Nerd Font"
    mkdir -p ~/.local/share/fonts
    rm -f JetBrainsMono.zip
    wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/JetBrainsMono.zip"
    unzip JetBrainsMono.zip -d ~/.local/share/fonts
    rm -f JetBrainsMono.zip

    fc-cache -f -v

    echo "JetBrainsMono Nerd Font installed"
fi

mkdir -p ~/.config/nvim/

echo "Neovim installed"
echo "Neovim setup successfully"
