ZSH=$HOME/.oh-my-zsh
ZSH_THEME="sunrise"
CASE_SENSITIVE="true"

plugins=(autoenv colored-man colorize command-not-found cp history bundler rvm rails ruby git)

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'

export TERM=xterm-256color

#rvm
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/versi/.rvm/scripts/rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

#nvm
#source $HOME/.nvm/nvm.sh

compctl -g '~/.teamocil/*(:t:r)' teamocil


#go
export GOPATH=/home/versi/work/go 

#tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# added by travis gem
[ -f /home/versi/.travis/travis.sh ] && source /home/versi/.travis/travis.sh
[[ -s "/home/versi/.gvm/scripts/gvm" ]] && source "/home/versi/.gvm/scripts/gvm"

alias tml="tmux list-sessions"
alias tma="tmux -2 attach -t $1"
alias tmk="tmux kill-session -t $1"

alias fuck='$(thefuck $(fc -ln -1))'
# You can use whatever you want as an alias, like for mondays:
alias FUCK='fuck'
