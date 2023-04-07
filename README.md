# Personal dot files

All existing dot files will be replaced without asking.

Clone the repo:

    git clone git@github.com:kalkov/dot-files.git ~/dot-files

Choose between essential and full packages.

## Essential

Used for slower machines like RaspberryPI or small cloud instances.

### Prerequisites
* [fzf](https://github.com/junegunn/fzf)
* [tmux](https://github.com/tmux/tmux/wiki)
* [tpm](https://github.com/tmux-plugins/tpm)
* [Vundle](https://github.com/VundleVim/Vundle.vim)

### Install
Symlink dot files from `~/dot-files/essential` to `~/`:

    ./install-essential.sh

## Full

Used for desktop, laptop or powerful cloud instances. Includes the essential package.

### Prerequisites

* [zsh](https://www.zsh.org/)
* [antigen](https://github.com/zsh-users/antigen)
* [fzf](https://github.com/junegunn/fzf)
* [tmux](https://github.com/tmux/tmux/wiki)
* [tpm](https://github.com/tmux-plugins/tpm)
* [Vundle](https://github.com/VundleVim/Vundle.vim)

### Install
Symlink dot files from `~/dot-files/essential` & `~/dot-files/full` to `~/`:

    ./install-full.sh
