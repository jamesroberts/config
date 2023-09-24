#!/usr/bin/bash

set -e

echo "Note: This script assumes you have fish already installed!"

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

fisher install jorgebucaran/nvm.fish
