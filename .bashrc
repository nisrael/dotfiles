# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# Source .profile if not already loaded (for non-login interactive shells)
if [ -z "$DOTFILES_PROFILE_LOADED" ] && [ -f "$HOME/.profile" ]; then
  source "$HOME/.profile"
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=$HISTSIZE
HISTIGNORE="clear:bg:fg:cd:cd -:cd ..:exit:date:w:ls:l:ll:lll"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
if [ -x /usr/bin/lesspipe ]; then
  eval "$(SHELL=/bin/sh lesspipe)"
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color|*-256color) color_prompt=yes;;
esac

# source git file containing __git_ps1 function
if [ -f /usr/lib/git-core/git-sh-prompt ]; then
  source /usr/lib/git-core/git-sh-prompt
elif [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
  source /usr/share/git-core/contrib/completion/git-prompt.sh
elif [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh ]; then
  source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
fi

export PS1='\
\[\e[1;32m\]\u@\
\[\e[1;36m\]\h\
\[\e[1;94m\]:\w \
\[\e[1;33m\]$(__git_ps1 "(%s) ")\
\[\e[1;32m\]$([ \j -gt 0 ] && echo "* ")\
$(if [ "$LAST_EXIT_STATUS" -eq 0 ]; then echo "\[\e[1;32m\]"; else echo "\[\e[1;31m\]"; fi)\$ \
\[\e[0m\]\
'

# this is useful to color tmux windows with "activity" differently, so it
# notifies me that something wrong happened in that window
beep_on_error() {
  local exit_status=$?
  LAST_EXIT_STATUS=$exit_status
  if [[ $exit_status -gt 0 ]]; then
    echo -ne '\a'
  fi
}

export PROMPT_COMMAND="beep_on_error"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# configure tmux
if [ -f ~/.tmux/tmux_bash_completion ]; then
  source ~/.tmux/tmux_bash_completion
fi

# configure fzf
if command -v fzf &>/dev/null; then
  source "$HOME/.config/fzf/completion.bash"
  source "$HOME/.config/fzf/key-bindings.bash"
  _fzf_compgen_path() {
    rg --files --hidden --color=never
  }

  _fzf_compgen_dir() {
    fd --color=never --type d
  }

  _fzf_setup_completion path npm
fi

# activate mise
if command -v mise &>/dev/null; then
  eval "$(mise activate bash)"
  eval "$(mise completion bash)"
fi

if command -v wezterm &>/dev/null; then
  eval "$(wezterm shell-completion --shell bash)"
fi

# tldr completion
if [ -f /usr/share/bash-completion/completions/tldr ]; then
  source /usr/share/bash-completion/completions/tldr
fi


# Platform-specific and common shell configuration
if [ -f ~/.config/shell/common.sh ]; then
  source ~/.config/shell/common.sh
fi

if uname | grep -iq darwin; then
  [ -f ~/.config/shell/macos.sh ] && source ~/.config/shell/macos.sh
elif uname -a | grep -iq microsoft; then
  [ -f ~/.config/shell/wsl.sh ] && source ~/.config/shell/wsl.sh
elif uname | grep -iq linux; then
  [ -f ~/.config/shell/linux.sh ] && source ~/.config/shell/linux.sh
fi

# Local customizations (not version controlled)
if [ -f ~/.bashrc.local ]; then
  source ~/.bashrc.local
fi

. "$HOME/.cargo/env"

# opencode
export PATH=/home/nisrael/.opencode/bin:$PATH
