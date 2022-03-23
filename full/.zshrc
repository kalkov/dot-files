source ~/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle command-not-found
antigen bundle docker
antigen bundle docker-compose
antigen bundle bundler
antigen bundle common-aliases
antigen bundle copypath
antigen bundle copyfile
antigen bundle dirhistory
antigen bundle ruby
antigen bundle history
antigen bundle tmux
antigen bundle kubectl

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme fino

# Tell Antigen that you're done.
antigen apply

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)

# load pyenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

complete -F __start_kubectl ku

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
