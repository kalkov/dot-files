#!/usr/bin/env bash

./install-essential.sh

echo "Installing zsh"
sudo apt install zsh
chsh -s $(which zsh)

echo "Installing antigen"
curl -L git.io/antigen > ~/antigen.zsh


echo "Installing krew"

(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)

dotfiles_dir=~/dot-files/full

echo "Creating full symlinks..."

shopt -s dotglob
for source in $dotfiles_dir/*; do
    dest=~/${source##*/}
    echo "Symlinking: $source to: $dest"
    ln -sf $source $dest
done

echo "Done"
