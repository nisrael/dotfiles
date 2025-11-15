# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$PATH:$HOME/.local/bin"
fi

# Add local scripts folder into PATH
if [ -d "$HOME/scripts" ]; then
  export PATH="$PATH:$HOME/scripts/"
fi

if [ -d "$HOME/.local/share/JetBrains/Toolbox/script" ]; then
  export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/script"
fi

if [ -x "/usr/lib/jvm/java-11-openjdk-amd64" ]; then
  export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
fi

# Add n related variables
export N_PREFIX="$HOME/.n"

if [ -d "$N_PREFIX" ]; then
  export PATH="$N_PREFIX/bin:$PATH"
fi

# Add npm related PATH
NPM_PACKAGES="$HOME/.npm-packages"

if [ -d "$NPM_PACKAGES" ]; then
  export PATH="$PATH:$NPM_PACKAGES/bin"
  export MANPATH="$MANPATH:$NPM_PACKAGES/share/man"
fi

# Add Python related PATH
if [ -d "$HOME/.poetry" ]; then
  export PATH="$PATH:$HOME/.poetry/bin"
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
if [ -d "$HOME/git-toolbelt" ]; then
  export PATH="$PATH:$HOME/git-toolbelt"
fi

# Add Homebrew
if [ -d "/opt/homebrew/bin" ]; then
  export PATH="$PATH:/opt/homebrew/bin"
fi

# Add pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

export COREPACK_ENABLE_AUTO_PIN=0

# Sentinel variable to indicate .profile has been sourced
export DOTFILES_PROFILE_LOADED=1
