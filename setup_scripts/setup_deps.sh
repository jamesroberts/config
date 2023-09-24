#!/usr/bin/bash

set -e

echo "Setting Node Version to 18..."
    echo "Sourcing nvm from ~/.nvm"
    if [ -f ~/.nvm/nvm.sh ]; then
    . ~/.nvm/nvm.sh
    nvm install 18
    nvm use 18
else
    echo "Error: Please install nvm"
    echo -e "Hint: \nRun > curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash"
    exit
fi

echo "Installing build essentials..."
sudo apt install build-essential gcc pkg-config libssl-dev

echo "Installing rust toolchain..."
curl https://sh.rustup.rs -sSf | sh

source "$HOME/.cargo/env"

echo "Installing rust based tools..."
cargo install exa mdcat bat skim tokei just navi fd-find

if command -v brew >/dev/null; then
    brew install tmux
    brew install the_silver_searcher
elif command -v apt-get >/dev/null; then
    sudo apt-get install tmux
    sudo apt-get install silversearcher-ag
elif command -v yum >/dev/null; then
    sudo yum install tmux
    sudo yum install the_silver_searcher
fi
