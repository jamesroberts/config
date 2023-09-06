set -e

echo "Setting Node Version to 18..."
if [ -f ~/.nvm/nvm.sh ]; then
    echo "Sourcing nvm from ~/.nvm"
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
cargo install exa mdcat





