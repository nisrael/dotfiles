# Common shell configuration for all platforms
# Sourced by .bashrc and .zshrc

# Editor
export EDITOR=nvim

# Pager
export PAGER="bat"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

if command -v fdfind &> /dev/null; then
  alias fd='fdfind'
fi

# Configure fzf
if [ -d "$HOME/.fzf" ]; then
  export PATH="$HOME/.fzf/bin:$PATH"
  export FZF_DEFAULT_COMMAND='rg --files --hidden --color=never'
  export FZF_ALT_C_COMMAND='fd --color=never --type d'
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview "bat --color=always --style=numbers --line-range=:500 {}"'
fi

# Enable zoxide if available
if command -v zoxide &> /dev/null; then
  if [ -n "$BASH_VERSION" ]; then
    eval "$(zoxide init bash)"
  elif [ -n "$ZSH_VERSION" ]; then
    eval "$(zoxide init zsh)"
  fi
fi

if command -v rg &> /dev/null; then
  export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"
fi

# Common aliases
alias cat='bat'
alias ls='eza -A --color=auto --group-directories-first --time-style=long-iso --icons'
alias ll='eza -A --color=auto --group-directories-first --time-style=long-iso --icons -l'
alias la='eza -a --icons'
alias lt='eza --tree --icons'
alias l='eza -lh --icons'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate --all'
alias gd='git diff'
alias lg='lazygit'

# Less options
# -F to quit automatically if the file is shorter than the screen
# -X to not clear the screen after quitting
# -R to show only color escape sequences in raw form
# -M to show a more verbose prompt
export LESS="-F -X -R -M"
