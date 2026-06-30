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

echo "Installing batcat"
sudo apt install bat

dotfiles_dir=~/dot-files/essential

echo "Creating assential symlinks..."

shopt -s dotglob
for source in $dotfiles_dir/*; do
    [[ "$(basename $source)" == ".ssh" ]] && continue
    dest=~/${source##*/}
    echo "Symlinking: $source to: $dest"
    ln -sf $source $dest
done

echo "Installing SSH config..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh
ln -sf $dotfiles_dir/.ssh/config ~/.ssh/config
chmod 600 $dotfiles_dir/.ssh/config

echo "Done"
