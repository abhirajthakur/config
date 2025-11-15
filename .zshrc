# bindkey "\e[A" history-search-backward
# bindkey "\e[B" history-search-forward

bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

alias ls='ls --color'
alias ll='ls -la'
alias gs='git status'
alias gl='git log --oneline --graph --decorate'
alias ga='git add'
alias pb='pnpm build'
alias pd='pnpm dev'
alias n='nvim'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

autoload -Uz compinit
compinit

sv() {
  local target_dir="${1:-.}"
  local venv_path="$target_dir/.venv/bin/activate"

  if [[ -f "$venv_path" ]]; then
    source "$venv_path"
    echo "Activated virtual environment at: $venv_path"
  else
    echo "No virtual environment found at: $venv_path"
    return 1
  fi
}

compdef _cd sv

compdef _sv_completion sv


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

# Function to send the current working directory to WezTerm
function __wezterm_osc7() {
  if hash wezterm 2>/dev/null; then
    # Use WezTerm's helper command to set the working directory if available
    wezterm set-working-directory 2>/dev/null && return
  fi
  # Fallback: Send the current working directory to the terminal using OSC 7
  printf "\033]7;file://%s%s\033\\" "${HOSTNAME}" "${PWD}"
}

# Hook to execute the function after every interactive command
precmd_functions+=(__wezterm_osc7)
