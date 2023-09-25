#!/usr/bin/bash

set -e

echo "Install fish following the instructions here: https://fishshell.com/"

echo "
Install the fish plugin manager by running:
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
"

echo "Install the following dependencies via fisher by running the following:
    fisher install jorgebucaran/nvm.fish
"
