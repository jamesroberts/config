set -e

cd ~

sudo rm -rf /usr/bin/nvim

if [[ $OSTYPE == 'darwin'* ]]; then
	brew install neovim
	brew install ripgrep
	brew install fontconfig
else
	rm -f nvim.appimage
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage

	chmod u+x nvim.appimage
	sudo ln -s ~/nvim.appimage /usr/bin/nvim

	if command -v apt-get >/dev/null; then
		sudo apt-get install ripgrep
	elif command -v yum >/dev/null; then
		sudo yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
		sudo yum install ripgrep
	else
		sudo snap install ripgrep
	fi
fi

mkdir -p ~/.config/nvim/
# mkdir -p ~/.vim/undodir

echo "Neovim installed"

echo "Installing Nerd Font"
mkdir -p ~/.local/share/fonts
rm JetBrainsMono.zip
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/JetBrainsMono.zip"
unzip JetBrainsMono.zip -d ~/.local/share/fonts

fc-cache -f -v

echo "JetBrainsMono Nerd Font installed"

# git clone --depth 1 https://github.com/wbthomason/packer.nvim\
# ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# echo "Package manager setup"

# sudo ln -s ~/dotfiles/nvim/* ~/.config/nvim/

# Backup old config
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak

echo "Neovim setup successfully"
