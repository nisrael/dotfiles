# WSL-specific configuration
# Only sourced on Windows Subsystem for Linux

# WSL-specific ls with colors and directory grouping (same as Linux)
alias ls='ls -A --color=auto --group-directories-first --time-style=long-iso --human-readable -v'
alias ll='ls -l'

# Open command using wslview (from wslu package)
if command -v wslview &> /dev/null; then
  alias open='wslview'
fi

# Persist ssh session across shells using keychain
if command -v keychain &> /dev/null; then
  eval "$(keychain --quiet --eval id_rsa 2>/dev/null)"
fi

# Use dircolors for colored ls output
if command -v dircolors &> /dev/null; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

export GIT_SSH=ssh.exe

# WSL-specific PATH or environment adjustments can go here
# For example, accessing Windows executables:
# export PATH="$PATH:/mnt/c/Windows/System32"
