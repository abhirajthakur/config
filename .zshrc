# Load nvm (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Set Go environment variables
export GOROOT=/usr/local/go
export GOPATH=$HOME/.go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# Shell options
setopt nocaseglob
setopt nocasematch
setopt correct
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS

# History setup
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt inc_append_history

# Aliases
alias ll='ls -la'
alias gs='git status'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias myip='curl http://ipecho.net/plain; echo'

# Initialize zsh completion system for alias expansion
autoload -Uz compinit
compinit

# Keybindings for history search with arrow keys
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

# Load additional custom configs if any
if [ -d ~/.zshrc.d ]; then
  for config_file in ~/.zshrc.d/*.zsh; do
    source $config_file
  done
fi

# Initialize starship prompt for zsh
eval "$(starship init zsh)"

