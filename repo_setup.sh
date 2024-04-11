#!/usr/bin/env bash

cd $HOME

function config {
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

function add_to_config_file {
    echo 'alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"' >> $1
    echo 'source "$HOME/.shell_rc"' >> $1
}

BASHRC=$HOME/.bashrc
touch "$BASHRC"
echo "Appending config to $BASHRC"
add_to_config_file $BASHRC

ZSHRC=$HOME/.zshrc
touch "$ZSHRC"
echo "Appending config to $ZSHRC"
add_to_config_file $ZSHRC

echo ".cfg" >> .gitignore

git clone --bare git@github.com:jamesroberts/config.git $HOME/.cfg

mkdir -p .config-backup

config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing config files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;

config checkout
config config --local status.showUntrackedFiles no
