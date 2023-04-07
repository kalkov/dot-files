#!/usr/bin/env bash

./install-essential.sh

echo "Installing zsh"
sudo apt install zsh
chsh -s $(which zsh)

echo "Installing antigen"
curl -L git.io/antigen > ~/antigen.zsh


dotfiles_dir=~/dot-files/full

echo "Creating full symlinks..."

shopt -s dotglob
for source in $dotfiles_dir/*; do
    dest=~/${source##*/}
    echo "Symlinking: $source to: $dest"
    ln -sf $source $dest
done

echo "Done"
