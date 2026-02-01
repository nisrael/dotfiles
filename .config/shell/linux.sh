# Native Linux-specific configuration
# Only sourced on non-WSL Linux systems

# Open command using xdg-open
alias open='xdg-open'

# Linux locale configuration
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive
export TERMINAL=footclient
export SSH_AUTH_SOCK=~/.1password/agent.sock
