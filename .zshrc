# Source .profile if not already loaded (for non-login interactive shells)
if [ -z "$DOTFILES_PROFILE_LOADED" ] && [ -f "$HOME/.profile" ]; then
  source "$HOME/.profile"
fi

# Powerlevel10k is disabled in favor of Starship
# # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# # Initialization code that may require console input (password prompts, [y/n]
# # confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Helper function to fix OMZ plugins with multiple files
_fix-omz-plugin() {
    [[ -f ./._zinit/teleid ]] || return 1
    local teleid="$(<./._zinit/teleid)"
    local pluginid
    for pluginid (${teleid#OMZ::plugins/} ${teleid#OMZP::}) {
        [[ $pluginid != $teleid ]] && break
    }
    (($?)) && return 1
    print "Fixing $teleid..."
    git clone --quiet --no-checkout --depth=1 --filter=tree:0 https://github.com/ohmyzsh/ohmyzsh
    cd ./ohmyzsh
    git sparse-checkout set --no-cone /plugins/$pluginid
    git checkout --quiet
    cd ..
    local file
    for file (./ohmyzsh/plugins/$pluginid/*~(.gitignore|*.plugin.zsh)(D)) {
        print "Copying ${file:t}..."
        cp -R $file ./${file:t}
    }
    rm -rf ./ohmyzsh
}

# Powerlevel10k is disabled in favor of Starship
# # Add in Powerlevel10k
# zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search
zinit light hlissner/zsh-autopair

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::extract
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::copypath

# Platform-specific plugins (loaded with _fix-omz-plugin for multi-file support)
if [[ "$OSTYPE" == "darwin"* ]]; then
  zinit wait lucid atpull"%atclone" atclone"_fix-omz-plugin" for OMZ::plugins/macos
fi

# Load completions (with caching for faster startup)
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

zinit cdreplay -q

# Load fzf-tab after compinit (required for proper completion integration)
zinit light Aloxaf/fzf-tab

# Powerlevel10k configuration is disabled in favor of Starship
# # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# History
HISTSIZE=50000
HISTFILE=~/.zsh_history
SAVEHIST=50000
HISTDUP=erase
HISTORY_IGNORE="(clear|bg|fg|cd|cd -|cd ..|exit|date|w|ls|l|ll|lll)"
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-

# Color kill command output
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Remove package-lock.json from completion items
zstyle ':completion:*' ignored-patterns package-lock.json

# Platform-specific colors will be set by shell config files

# see https://wiki.archlinux.org/title/zsh#Key_bindings
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

# Keybindings
bindkey -e

key[Control-P]="^p"
key[Control-N]="^n"
key[Meta-W]="^[w"
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

# setup key accordingly
[[ -n "${key[Home]}"          ]] && bindkey -- "${key[Home]}"          beginning-of-line
[[ -n "${key[End]}"           ]] && bindkey -- "${key[End]}"           end-of-line
[[ -n "${key[Insert]}"        ]] && bindkey -- "${key[Insert]}"        overwrite-mode
[[ -n "${key[Backspace]}"     ]] && bindkey -- "${key[Backspace]}"     backward-delete-char
[[ -n "${key[Delete]}"        ]] && bindkey -- "${key[Delete]}"        delete-char
[[ -n "${key[Up]}"            ]] && bindkey -- "${key[Up]}"            up-line-or-search
[[ -n "${key[Down]}"          ]] && bindkey -- "${key[Down]}"          down-line-or-search
[[ -n "${key[Left]}"          ]] && bindkey -- "${key[Left]}"          backward-char
[[ -n "${key[Right]}"         ]] && bindkey -- "${key[Right]}"         forward-char
[[ -n "${key[PageUp]}"        ]] && bindkey -- "${key[PageUp]}"        beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"      ]] && bindkey -- "${key[PageDown]}"      end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}"     ]] && bindkey -- "${key[Shift-Tab]}"     reverse-menu-complete
[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word
[[ -n "${key[Control-P]}"      ]] && bindkey -- "${key[Control-P]}"      history-search-backward
[[ -n "${key[Control-N]}"      ]] && bindkey -- "${key[Control-N]}"      history-search-forward
[[ -n "${key[Meta-W]}"         ]] && bindkey -- "${key[Meta-W]}"         kill-region

# History substring search (uses Up/Down arrow keys)
[[ -n "${key[Up]}" ]] && bindkey "${key[Up]}" history-substring-search-up
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" history-substring-search-down

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
  autoload -Uz add-zle-hook-widget

  function zle_application_mode_start {
    echoti smkx
  }

  function zle_application_mode_stop {
    echoti rmkx
  }

  add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
  add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# Enable Ctrl-X + Ctrl-E to edit command in $EDITOR
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# Enable multiline input with Shift+Enter (Windows Terminal CSI u mode)
insert-newline() {
  LBUFFER="${LBUFFER}
"
}
zle -N insert-newline
bindkey '^[[13;2u' insert-newline


# Activate mise
if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
  eval "$(mise completion zsh)"
fi

if command -v wezterm &>/dev/null; then
  eval "$(wezterm shell-completion --shell zsh)"
fi

# Shell integrations
eval "$(fzf --zsh)"

# Disable flow control keybindings Ctrl-Q and Ctrl-S. This is necessary to make
# the Ctrl-G + Ctrl-S keybinding (to open fzf window with git stashes) work
setopt noflowcontrol

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

# Initialize starship prompt
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

# Local customizations (not version controlled)
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi
