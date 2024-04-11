#!/usr/bin/env bash

set -e

echo "Installing Kitty"

mkdir -p ~/.local/bin/
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
sudo ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/

echo "Complete"
