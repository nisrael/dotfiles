# Common shell configuration for all platforms
# Sourced by .bashrc and .zshrc

# Editor
export EDITOR=nvim

# LS_COLORS for completion styling
if command -v vivid &> /dev/null; then
  export LS_COLORS="$(vivid generate snazzy)"
elif command -v dircolors &> /dev/null; then
  eval "$(dircolors -b)"
else
  # Fallback: basic color configuration
  export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
fi

# Language-specific paths
# Rust
if [ -d "$HOME/.cargo/bin" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -f $HOME/.cargo/env ]; then
  source $HOME/.cargo/env
fi

# Go
export GOPATH="$HOME/go"
if [ -d "$GOPATH/bin" ]; then
  export PATH="$GOPATH/bin:$PATH"
fi

# Pager
export PAGER="bat"
export MANPAGER="sh -c 'col -b | bat -l man -p'"

if command -v fdfind &> /dev/null; then
  alias fd='fdfind'
fi

# Configure fzf
if [ -d "$HOME/.fzf" ]; then
  export PATH="$HOME/.fzf/bin:$PATH"
  export FZF_DEFAULT_COMMAND='rg --files --hidden --color=never'
  export FZF_ALT_C_COMMAND='fd --color=never --type d'
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview "bat --color=always --style=numbers --line-range=:500 {}"'
fi

# Enable zoxide if available
if command -v zoxide &> /dev/null; then
  if [ -n "$BASH_VERSION" ]; then
    eval "$(zoxide init bash)"
  elif [ -n "$ZSH_VERSION" ]; then
    eval "$(zoxide init zsh)"
  fi
fi

if command -v rg &> /dev/null; then
  export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"
fi

# Common aliases
alias cat='bat'
alias ls='eza -A --color=auto --group-directories-first --time-style=long-iso --icons'
alias ll='eza -A --color=auto --group-directories-first --time-style=long-iso --icons -l'
alias la='eza -a --icons'
alias lt='eza --tree --icons'
alias l='eza -lh --icons'

# Process viewer with procs
if command -v procs &> /dev/null; then
  alias px='procs'                        # Short alias
  alias pxt='procs --tree'                # Tree view of processes
  alias pxc='procs --sortd cpu'           # Sort by CPU usage (descending)
  alias pxm='procs --sortd mem'           # Sort by memory usage (descending)
  alias pxw='procs --watch'               # Watch mode (live updates)
  alias pxu='procs --or --uid $(id -u)'   # Only show current user's processes
fi

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate --all'
alias gd='git diff'
alias lg='lazygit'

# Less options
# -F to quit automatically if the file is shorter than the screen
# -X to not clear the screen after quitting
# -R to show only color escape sequences in raw form
# -M to show a more verbose prompt
export LESS="-F -X -R -M"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Hyperfine configuration
if command -v hyperfine &> /dev/null; then
  # Default hyperfine options: warmup runs, show output, export results
  export HYPERFINE_DEFAULT_OPTS="--warmup 3 --show-output"

  # Alias for quick benchmarking with common defaults
  alias bench='hyperfine --warmup 3 --runs 10'

  # Alias for comparing multiple commands with JSON export
  alias benchcmp='hyperfine --warmup 3 --runs 10 --export-json /tmp/bench-results.json'

  # Alias for detailed benchmarking with markdown export
  alias benchmd='hyperfine --warmup 5 --runs 20 --export-markdown /tmp/bench-results.md'
fi
