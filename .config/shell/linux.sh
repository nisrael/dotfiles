# Native Linux-specific configuration
# Only sourced on non-WSL Linux systems

# Linux-specific ls with colors and directory grouping
alias ls='ls -A --color=auto --group-directories-first --time-style=long-iso --human-readable -v'
alias ll='ls -l'

# Open command using xdg-open
alias open='xdg-open'

# Use dircolors for colored ls output
if command -v dircolors &> /dev/null; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
