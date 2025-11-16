# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$PATH:$HOME/.local/bin"
fi

# Add local scripts folder into PATH
if [ -d "$HOME/dotfiles/scripts" ]; then
  export PATH="$PATH:$HOME/dotfiles/scripts/"
fi

if [ -d "$HOME/.local/share/JetBrains/Toolbox/script" ]; then
  export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/script"
fi

# Add npm related PATH
NPM_PACKAGES="$HOME/.npm-packages"

if [ -d "$NPM_PACKAGES" ]; then
  export PATH="$PATH:$NPM_PACKAGES/bin"
  export MANPATH="$MANPATH:$NPM_PACKAGES/share/man"
fi

# Add Go related PATH
export GOPATH="$HOME/go"

if [ -d "$GOPATH" ]; then
  export PATH="$PATH:$GOPATH/bin"
fi

if [ -d "/usr/local/go/bin" ]; then
  export PATH="$PATH:/usr/local/go/bin"
fi

# Add Rust related PATH
if [ -d "$HOME/.cargo/bin" ]; then
  export PATH="$PATH:$HOME/.cargo/bin"
fi

# Add git-toolbelt
if [ -d "$HOME/dotfiles/git-toolbelt" ]; then
  export PATH="$PATH:$HOME/dotfiles/git-toolbelt"
fi

# Add Homebrew
if [ -d "/opt/homebrew/bin" ]; then
  export PATH="$PATH:/opt/homebrew/bin"
fi

# Add pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

if [ -d "$HOME/.local/bin/claude" ]; then
  export CLAUDE_CODE_EXECUTABLE="$HOME/.local/bin/claude"
fi

# Sentinel variable to indicate .profile has been sourced
export DOTFILES_PROFILE_LOADED=1
. "$HOME/.cargo/env"
