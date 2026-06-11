setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

# Matching (case-insensitive + fuzzy)
zstyle ':completion:*' matcher-list '' \
  'm:{a-z}={A-Z}' \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=* l:|=*'

# Menu UI
zstyle ':completion:*' menu select=long
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more%s
zstyle ':completion:*' select-prompt %SScrolling at %p%s

# Colors
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Better kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# bindkey "^[[A" history-search-backward
# bindkey "^[[B" history-search-forward

alias ls='ls --color'
alias ll='ls -la'
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate'
alias ga='git add'
alias pb='pnpm build'
alias pd='pnpm dev'
alias n='nvim'
alias -g ...='../..'
alias t="tmux"
alias tn='tmux new -s "$(basename "$PWD")"'

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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/home/abhiraj/.bun/_bun" ] && source "/home/abhiraj/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# go
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/go/bin"

eval "$(starship init zsh)"

. "$HOME/.local/bin/env"

# # In ~/.bashrc or ~/.zshrc
if [ -z "$TMUX" ]; then
  export TERM="xterm-256color" # or your terminal's specific terminfo
fi
export DOCKER_BUILDKIT=1


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
