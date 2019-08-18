#!/usr/bin/env bash

dotfiles_dir=~/dot-files

echo "Creating symlinks..."

ln -sf $dotfiles_dir/.bash_profile ~/.bash_profile
ln -sf $dotfiles_dir/.bash_ssh ~/.bash_ssh
ln -sf $dotfiles_dir/.bashrc ~/.bashrc
ln -sf $dotfiles_dir/.gitconfig ~/.gitconfig
ln -sf $dotfiles_dir/.profile ~/.profile
ln -sf $dotfiles_dir/.tmux.conf ~/.tmux.conf
ln -sf $dotfiles_dir/.vimrc ~/.vimrc
ln -sf $dotfiles_dir/.zshrc ~/.zshrc

echo "Done"
