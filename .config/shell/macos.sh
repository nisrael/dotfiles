# macOS-specific configuration

# Enable colored ls output (macOS style)
export CLICOLOR=1

# Homebrew setup
if [ -d "/opt/homebrew" ]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
  export PATH="$HOMEBREW_PREFIX/bin:$PATH"
fi

# macOS Python user packages
if [ -d "$HOME/Library/Python/3.8/bin" ]; then
  export PATH="$PATH:$HOME/Library/Python/3.8/bin"
fi

if [ -d "$HOME/Library/Python/3.9/bin" ]; then
  export PATH="$PATH:$HOME/Library/Python/3.9/bin"
fi

if [ -d "$HOME/Library/Python/3.10/bin" ]; then
  export PATH="$PATH:$HOME/Library/Python/3.10/bin"
fi

if [ -d "$HOME/Library/Python/3.11/bin" ]; then
  export PATH="$PATH:$HOME/Library/Python/3.11/bin"
fi

# macOS Android SDK location
if [ -d "$HOME/Library/Android/sdk" ]; then
  export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
fi
