#!/usr/bin/env bash

./install-essential.sh

dotfiles_dir=~/dot-files/full

echo "Creating full symlinks..."

shopt -s dotglob
for source in $dotfiles_dir/*; do
    dest=~/${source##*/}
    echo "Symlinking: $source to: $dest"
    ln -sf $source $dest
done

echo "Done"
