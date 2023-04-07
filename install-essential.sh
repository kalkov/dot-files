#!/usr/bin/env bash

echo "Installing git"
sudo apt install git

echo "Installing curl"
sudo apt install curl

echo "Installing tmux"
sudo apt install tmux

echo "Installing tpm"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Installing Vundle"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

dotfiles_dir=~/dot-files/essential

echo "Creating assential symlinks..."

shopt -s dotglob
for source in $dotfiles_dir/*; do
    dest=~/${source##*/}
    echo "Symlinking: $source to: $dest"
    ln -sf $source $dest
done

echo "Done"
