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
antigen bundle kube-ps1
antigen bundle spaceship-prompt/spaceship-vi-mode@main

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme spaceship-prompt/spaceship-prompt

# Tell Antigen that you're done.
antigen apply

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

# load krew for k8s
path+=("${KREW_ROOT:-$HOME/.krew}/bin")

# kubectl
[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
complete -F __start_kubectl ku

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


#load kubectl config
source ~/.kube/load-kube-configs.sh

export PATH
source "/etc/profile.d/rvm.sh"

export AWS_PROFILE=default
export AWS_DEFAULT_REGION=eu-central-1

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
