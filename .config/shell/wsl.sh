# WSL-specific configuration
# Only sourced on Windows Subsystem for Linux

# Open command using wslview (from wslu package)
if command -v wslview &> /dev/null; then
  alias open='wslview'
fi

# Persist ssh session across shells using keychain
if command -v keychain &> /dev/null; then
  eval "$(keychain --quiet --eval id_rsa 2>/dev/null)"
fi

export GIT_SSH=ssh.exe

# WSL-specific PATH or environment adjustments can go here
# For example, accessing Windows executables:
# export PATH="$PATH:/mnt/c/Windows/System32"
