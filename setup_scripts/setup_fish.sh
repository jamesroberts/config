#!/usr/bin/env bash

set -e

echo "Install fish following the instructions here: https://fishshell.com/"


if [[ $OSTYPE == 'darwin'* ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/rzjam/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    brew install fish
fi

echo "
Install the fish plugin manager by running:
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
"
