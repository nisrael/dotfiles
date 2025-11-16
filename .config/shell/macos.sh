# macOS-specific configuration

# Enable colored ls output (macOS style)
export CLICOLOR=1

# Homebrew setup
if [ -d "/opt/homebrew" ]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
  export PATH="$HOMEBREW_PREFIX/bin:$PATH"
fi

# macOS Python user packages - automatically detect all installed versions
if [ -d "$HOME/Library/Python" ]; then
  for python_bin in "$HOME/Library/Python"/*/bin; do
    if [ -d "$python_bin" ]; then
      export PATH="$PATH:$python_bin"
    fi
  done
fi
