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

echo "Installing kubectx"
kubectl krew install ctx

echo "Installing kubens"
kubectl krew install ns

echo "Installing RVM"
gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt update
sudo apt install rvm
sudo usermod -a -G rvm $USER  

dotfiles_dir=~/dot-files/full

echo "Creating full symlinks..."

shopt -s dotglob
for source in $dotfiles_dir/*; do
    dest=~/${source##*/}
    echo "Symlinking: $source to: $dest"
    ln -sf $source $dest
done

echo "Done"
