# Native Linux-specific configuration
# Only sourced on non-WSL Linux systems

# Open command using xdg-open
alias open='xdg-open'

# Use dircolors for colored ls output
if command -v dircolors &> /dev/null; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
