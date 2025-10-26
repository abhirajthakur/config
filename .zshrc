bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY

alias ll='ls -la'
alias gs='git status'
alias gl='git log --oneline --graph --decorate'
# alias sv='source .venv/bin/activate'
alias pb='pnpm build'
alias pd='pnpm dev'
alias n='nvim'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

sv() {
  local target_dir="${1:-.}"
  local venv_path="$target_dir/.venv/bin/activate"

  if [ -f "$venv_path" ]; then
    # shellcheck disable=SC1090
    source "$venv_path"
    echo "✅ Activated virtual environment at: $venv_path"
  else
    echo "❌ No virtual environment found at: $venv_path"
    return 1
  fi

}

autoload -Uz compinit
compinit

eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$PATH:/opt/nvim/"

# bun completions
[ -s "/home/abhiraj/.bun/_bun" ] && source "/home/abhiraj/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# go
export PATH=$PATH:/usr/local/go/bin

. "$HOME/.local/bin/env"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
export PATH=$PATH:$HOME/go/bin
