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

# Node.js and pnpm are managed by asdf (see .tool-versions)

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

# Add Homebrew
if [ -d "/opt/homebrew/bin" ]; then
  export PATH="$PATH:/opt/homebrew/bin"
fi

if [ -d "$HOME/.local/bin/claude" ]; then
  export CLAUDE_CODE_EXECUTABLE="$HOME/.local/bin/claude"
fi

if [ -d "$HOME/.opencode/bin" ]; then
  export PATH=$HOME/.opencode/bin:$PATH
fi

if [ -d "$HOME/.platformio/penv/bin" ]; then
  export PATH=$HOME/.platformio/penv/bin:$PATH
fi

# Reorder PATH so bin comes before sbin (they're symlinks on Fedora/CachyOS)
PATH=$(echo "$PATH" | tr ':' '\n' | awk '!/sbin/{print} /sbin/{s=s":"$0} END{print substr(s,2)}' | tr '\n' ':' | sed 's/:$//')

# Sentinel variable to indicate .profile has been sourced
export DOTFILES_PROFILE_LOADED=1
. "$HOME/.cargo/env"
