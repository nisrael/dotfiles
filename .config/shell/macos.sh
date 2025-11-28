# macOS-specific configuration

# Enable colored ls output (macOS style)
export CLICOLOR=1

export HOMEBREW_NO_ENV_HINTS=1

# macOS Python user packages - automatically detect all installed versions
if [ -d "$HOME/Library/Python" ]; then
  for python_bin in "$HOME/Library/Python"/*/bin; do
    if [ -d "$python_bin" ]; then
      export PATH="$PATH:$python_bin"
    fi
  done
fi


# workaround https://github.com/MidnightCommander/mc/issues/4625
function mc(){
    SHELL=/opt/homebrew/bin/bash
    /opt/homebrew/bin/mc
} 
