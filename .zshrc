ZSH=$HOME/.oh-my-zsh
ZSH_THEME="smt"
CASE_SENSITIVE="true"

plugins=(bundler rvm rails3 ruby git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/versi/.rvm/scripts/rvm


#rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

#nvm
source $HOME/.nvm/nvm.sh

#tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

