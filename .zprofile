# ~/.zprofile: executed by zsh for login shells

# Source profile for PATH and environment variables
if [ -f "$HOME/.profile" ]; then
  source "$HOME/.profile"
fi
