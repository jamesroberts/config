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

if command -v brew >/dev/null; then
    brew install tmux
    brew install the_silver_searcher
elif command -v apt-get >/dev/null; then
    sudo apt install build-essential gcc pkg-config libssl-dev
    sudo apt-get install tmux
    sudo apt-get install silversearcher-ag
elif command -v yum >/dev/null; then
    sudo yum install build-essential gcc pkg-config libssl-dev
    sudo yum install tmux
    sudo yum -y install pcre-devel xz-devel zlib-devel
    git clone https://github.com/ggreer/the_silver_searcher.git
    cd the_silver_searcher/
    ./build.sh
    sudo make install && cd - && rm -rf the_silver_searcher/
fi

echo "Installing rust toolchain..."
curl https://sh.rustup.rs -sSf | sh

source "$HOME/.cargo/env"

echo "Installing rust based tools..."
cargo install eza mdcat bat skim tokei just navi fd-find

