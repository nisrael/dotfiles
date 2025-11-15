# Common shell configuration for all platforms
# Sourced by .bashrc and .zshrc

# Editor
export EDITOR=nvim

# Configure fzf
if [ -d "$HOME/.fzf" ]; then
  export PATH="$HOME/.fzf/bin:$PATH"
  export FZF_DEFAULT_COMMAND='rg --files --hidden --color=never'
  export FZF_ALT_C_COMMAND='fd --color=never --type d'
fi

# Enable zoxide if available
if command -v zoxide &> /dev/null; then
  if [ -n "$BASH_VERSION" ]; then
    eval "$(zoxide init bash)"
  elif [ -n "$ZSH_VERSION" ]; then
    eval "$(zoxide init zsh)"
  fi
fi

# Common aliases
alias cat='bat'

# Less options
# -F to quit automatically if the file is shorter than the screen
# -X to not clear the screen after quitting
# -R to show only color escape sequences in raw form
# -M to show a more verbose prompt
export LESS="FXRM"
