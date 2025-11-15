# ~/.bash_profile: executed by bash for login shells

# Source profile for PATH and environment variables
if [ -f "$HOME/.profile" ]; then
  source "$HOME/.profile"
fi

# Source bashrc for interactive shell configuration
if [ -f "$HOME/.bashrc" ]; then
  source "$HOME/.bashrc"
fi
. "$HOME/.cargo/env"
