# Dotfiles

Personal dotfiles repository for automated development environment setup across Linux (Ubuntu, Fedora) and macOS.
This repository uses Ansible playbooks to install and configure development tools, with GNU Stow for dotfile management.

## Credits

Thanks a lot to [@phelipetls](https://github.com/phelipetls) for their 
[dotfiles](https://github.com/phelipetls/dotfiles) and the blog post 
[Ansible for dotfiles: the introduction I wish I'd had](https://phelipetls.github.io/posts/introduction-to-ansible/), 
which were a great starting point for learning ansible and using it with stow for dotfiles management.

## TL;DR

```bash
# Clone and setup
git clone --recursive https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install everything
./install    # Installs Ansible and dependencies
./bootstrap  # Runs full setup (platform-aware)

# Or install specific components
just minimal  # Minimal setup (essential tools for servers)
just cli      # CLI tools only (works on SSH servers)
just gui      # GUI applications (skip on WSL)
just desktop  # Desktop environment config (Linux only)
just nvim     # Neovim setup only

# Add local git settings (name, email, ...)
cp .gitconfig.local.example ~/.gitconfig.local
```

**What gets installed:**
- **All platforms**: 80+ CLI tools, Neovim, LSP servers, shell enhancements
- **Linux + macOS**: GUI apps (VSCode, Zed, WezTerm, Alacritty, Vivaldi, etc.)
- **Native Linux only**: GNOME customizations, Flatpak apps, desktop tools

## Quick Start

```bash
# Install Ansible and dependencies
./install

# Run the full bootstrap playbook
./bootstrap
```

The bootstrap script automatically detects your platform (Ubuntu, Fedora, macOS, or WSL) and installs appropriate tools.

## Architecture

### Role-Based Organization

This repository organizes tools into specialized Ansible roles based on their use case:

#### **minimal** - Essential Cross-Distribution Tools
A curated subset of the most essential tools that work reliably across Debian, Ubuntu, and RedHat-based distributions. Perfect for server environments where you want a consistent baseline setup without installing everything.

**What's included:**
- Git submodules update
- **stow** - Dotfile symlink management
- **shell** - zsh with syntax highlighting and autosuggestions
- **Development tools** - build-essential (Debian) / Development Tools (RedHat)
- **Core CLI tools** - tig, tmux, ripgrep, fd-find, jq, htop, python3-pip, unzip, mc, moreutils
- **asdf** - Extendable version manager for multiple languages and runtimes
- **fzf** - Fuzzy finder
- **bat** - Better cat with syntax highlighting
- **eza** - Modern ls replacement
- **zoxide** - Smart cd command
- **vim** - Classic text editor

**Why minimal?**
- Works on Debian, Ubuntu, and RedHat distributions
- Fast to install (essential tools only)
- No GUI dependencies
- Perfect for headless servers and remote development
- Provides a productive terminal environment without bloat

**Usage:**
```bash
ansible-playbook bootstrap.yml --tags minimal
# or
just minimal
```

#### **cli** - Pure Terminal Tools (SSH-friendly)
Command-line tools that work over SSH and don't require a GUI. Perfect for headless servers and remote development.

**Categories:**
- Core utilities: ripgrep, fd, fzf, bat, eza, zoxide, jq, htop, btop
- Git tools: tig, git-delta, difftastic, git-absorb, gh, lazygit
- Text editors: vim, helix, micro (TUI only)
- Terminal workspace: tmux, zellij
- File managers: yazi
- Programming runtimes: Node.js, Go, Rust, Crystal, OpenJDK, Maven
- Dev tools: Docker (Linux only), just, asdf, cargo-binstall
- Documentation: cheat, tlrc, tealdeer
- Misc: meld (has CLI mode), 1password-cli, claude-cli, opencode

**Platform notes:**
- Docker excluded on WSL and macOS (use Docker Desktop instead)
- All tools work on Linux, macOS, and WSL

#### **gui** - Cross-Platform GUI Applications
GUI applications that run on both native Linux and macOS (excluded from WSL).

**What's included:**
- Code editors: VSCode, Zed
- Terminal emulators: WezTerm, Alacritty
- Browsers: Vivaldi
- Password manager: 1Password (desktop app)
- VPN: Mullvad, WireGuard
- Development: Arduino IDE, ueberzugpp
- Fonts: Nerd Fonts (JetBrains Mono, Martian Mono, Meslo, Hack, Zed Mono, etc.)

**Platform notes:**
- Automatically skipped on WSL (no GUI support)
- macOS uses Homebrew casks
- Linux uses native packages or AppImages

#### **desktop** - Desktop Environment Configuration
Linux desktop environment customization (GNOME, Flatpak, system settings). Only runs on native Linux.

**What's included:**
- GNOME settings and extensions (dash-to-dock, just-perfection, etc.)
- Flatpak setup and applications (Spotify, GIMP, Inkscape, etc.)
- Desktop launchers: ulauncher
- Platform-specific tweaks (Fedora vs Ubuntu)

**Platform notes:**
- Only runs on native Linux (not WSL, not macOS)
- Configures GNOME desktop via dconf
- Installs and manages Flatpak applications

#### **Other Roles** (unchanged)
- **stow**: Dotfile symlink management with GNU Stow
- **shell**: Shell enhancements (zsh-syntax-highlighting, zsh-autosuggestions)
- **lsp**: Language Server Protocol servers and linters
- **nvim**: Neovim installation and plugin setup
- **homebrew**: macOS package manager (macOS only)

### Platform Installation Matrix

| Role     | Native Linux | WSL | macOS | Notes |
|----------|-------------|-----|-------|-------|
| stow     | ✓           | ✓   | ✓     | Dotfile symlinks |
| shell    | ✓           | ✓   | ✓     | Shell enhancements |
| cli      | ✓           | ✓   | ✓     | Docker excluded on WSL/macOS |
| lsp      | ✓           | ✓   | ✓     | Language servers |
| nvim     | ✓           | ✓   | ✓     | Neovim |
| gui      | ✓           | ✗   | ✓     | GUI applications |
| desktop  | ✓           | ✗   | ✗     | Desktop environment config |
| homebrew | ✗           | ✗   | ✓     | macOS package manager |

## Installed Tools

### CLI Tools (works everywhere including SSH)

#### Core Utilities

##### **ripgrep (rg)**
Fast recursive line-oriented search tool (better than grep)

**Installed by:** [`roles/cli/tasks/main.yml`](roles/cli/tasks/main.yml)

**Configuration:**
- Config file: [`.config/ripgrep/ripgreprc`](.config/ripgrep/ripgreprc)
- Ignore patterns: [`.rgignore`](.rgignore)
- Environment: `RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"` in [`.config/shell/common.sh`](.config/shell/common.sh)
- Settings: `--hidden`, `--follow`, `--smart-case`, custom colors, glob ignores

##### **fd**
Simple, fast alternative to `find`

**Installed by:** [`roles/cli/tasks/main.yml`](roles/cli/tasks/main.yml)

**Configuration:**
- Ignore patterns: [`.config/fd/ignore`](.config/fd/ignore)
- Alias: `alias fd='fdfind'` (on Ubuntu) in [`.config/shell/common.sh`](.config/shell/common.sh)
- Used by fzf: `FZF_ALT_C_COMMAND='fd --color=never --type d'`

##### **fzf**
Command-line fuzzy finder

**Installed by:** [`roles/cli/tasks/main.yml`](roles/cli/tasks/main.yml)

**Configuration:**
- Git submodule: [`.fzf/`](.fzf/) (installed from git submodule)
- Sourced in: [`.bashrc`](.bashrc), [`.zshrc`](.zshrc)
- Environment in [`.config/shell/common.sh`](.config/shell/common.sh):
  - `FZF_DEFAULT_COMMAND='rg --files --hidden --color=never'`
  - `FZF_ALT_C_COMMAND='fd --color=never --type d'`
  - `FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview "bat --color=always --style=numbers --line-range=:500 {}"'`

##### **bat**
Cat clone with syntax highlighting and Git integration

**Installed by:** [`roles/cli/tasks/bat.yml`](roles/cli/tasks/bat.yml)

**Configuration:**
- Alias: `alias cat='bat'` in [`.config/shell/common.sh`](.config/shell/common.sh)
- Pager: `PAGER=bat` in [`.config/shell/common.sh`](.config/shell/common.sh)
- Man pager: `MANPAGER="sh -c 'col -bx | bat -l man -p'"` in [`.config/shell/common.sh`](.config/shell/common.sh)
- Version: 0.23.0

##### **eza**
Modern replacement for `ls` with colors and icons

**Installed by:** [`roles/cli/tasks/eza.yml`](roles/cli/tasks/eza.yml)

**Configuration:**
- Aliases in [`.config/shell/common.sh`](.config/shell/common.sh):
  - `alias ls='eza -A --color=auto --group-directories-first --time-style=long-iso --icons'`
  - `alias ll='eza -A --color=auto --group-directories-first --time-style=long-iso --icons -l'`
  - `alias la='eza -a --icons'`
  - `alias lt='eza --tree --icons'`
  - `alias l='eza -lh --icons'`
- Version: 0.20.14

##### **zoxide**
Smarter cd command that learns your most-used directories

**Installed by:** [`roles/cli/tasks/zoxide.yml`](roles/cli/tasks/zoxide.yml)

**Configuration:**
- Initialized in [`.config/shell/common.sh`](.config/shell/common.sh): `eval "$(zoxide init bash)"`
- Also in [`.zshrc`](.zshrc): `eval "$(zoxide init zsh)"`
- Version: 0.9.1

##### **jq**
Command-line JSON processor

**Installed by:** [`roles/cli/tasks/main.yml`](roles/cli/tasks/main.yml)

**Configuration:** None (used via command line)

##### **htop**
Interactive process viewer

**Installed by:** [`roles/cli/tasks/main.yml`](roles/cli/tasks/main.yml)

**Configuration:** None

##### **btop**
Resource monitor with beautiful interface

**Installed by:** [`roles/cli/tasks/btop.yml`](roles/cli/tasks/btop.yml)

**Configuration:** None

##### **dust**
More intuitive version of `du` (disk usage)

**Installed by:** [`roles/cli/tasks/dust.yml`](roles/cli/tasks/dust.yml)

**Configuration:** None

##### **procs**
Modern replacement for `ps` (process viewer)

**Installed by:** [`roles/cli/tasks/procs.yml`](roles/cli/tasks/procs.yml)

**Configuration:** None

##### **hyperfine**
Command-line benchmarking tool

**Installed by:** [`roles/cli/tasks/hyperfine.yml`](roles/cli/tasks/hyperfine.yml)

**Configuration:** None

##### **7zip**
File archiver with high compression ratio

**Installed by:** [`roles/cli/tasks/7zip.yml`](roles/cli/tasks/7zip.yml)

**Configuration:** None

#### Version Control & Git Tools

##### **Git**
Distributed version control system

**Installed by:** System package manager

**Configuration:**
- Main config: [`.gitconfig`](.gitconfig) (generated by Ansible template)
- Template: [`roles/stow/templates/gitconfig.j2`](roles/stow/templates/gitconfig.j2)
- Common settings: [`.config/git/common.gitconfig`](.config/git/common.gitconfig)
- Platform-specific: [`.config/git/linux.gitconfig`](.config/git/linux.gitconfig), [`.config/git/macos.gitconfig`](.config/git/macos.gitconfig), [`.config/git/wsl.gitconfig`](.config/git/wsl.gitconfig)
- Local overrides: `.gitconfig.local` (example: [`.gitconfig.local.example`](.gitconfig.local.example))
- Attributes: [`.gitattributes`](.gitattributes)

**Settings:**
- Default pager: `delta`
- Editor: `nvim`
- Merge tool: `nvimdiff`
- Push default: `current`
- Rebase: `autosquash = true`, `autoStash = true`
- Delta: side-by-side diff, navigate mode, dark theme

**Aliases:**
- `co = checkout`, `st = status`
- `rh = reset --hard`, `rs = reset --soft`
- `recent = branch --sort=-committerdate`
- `undo = reset --soft HEAD^`
- `difft = -c diff.external=difft diff` (uses difftastic)
- `pushf = push --force-with-lease`

##### **tig**
Text-mode interface for Git

**Installed by:** [`roles/cli/tasks/main.yml`](roles/cli/tasks/main.yml)

**Configuration:**
- Config file: [`.tigrc`](.tigrc)
- Vim-style navigation (h, j, k, l)
- Custom view bindings (vm, vd, vl, vt, vb, etc.)
- Custom toggles (oo, os, on, od, etc.)

##### **git-delta**
Syntax-highlighting pager for Git diffs

**Installed by:** [`roles/cli/tasks/git-delta.yml`](roles/cli/tasks/git-delta.yml)

**Configuration:**
- Configured in [`.gitconfig`](.gitconfig) template
- Side-by-side diff, navigate mode, dark theme
- Version: 0.14.0

##### **difftastic**
Structural diff tool that understands syntax

**Installed by:** [`roles/cli/tasks/difftastic.yml`](roles/cli/tasks/difftastic.yml)

**Configuration:**
- Git alias: `git difft` in [`.gitconfig`](.gitconfig)
- Version: 0.53.0

##### **git-absorb**
Automatic fixup commits

**Installed by:** [`roles/cli/tasks/git-absorb.yml`](roles/cli/tasks/git-absorb.yml)

**Configuration:** None (use via `git absorb`)
- Version: 0.6.9

##### **GitHub CLI (gh)**
Official GitHub command-line tool

**Installed by:** [`roles/cli/tasks/gh.yml`](roles/cli/tasks/gh.yml)

**Configuration:** None

**NPM extensions:**
- `@github/copilot` - GitHub Copilot CLI extension

##### **lazygit**
Simple terminal UI for git commands

**Installed by:** [`roles/cli/tasks/lazygit.yml`](roles/cli/tasks/lazygit.yml)

**Configuration:** None

##### **git-toolbelt**
Collection of useful git scripts

**Installed by:** Git submodule at [`git-toolbelt/`](git-toolbelt/)

**Configuration:**
- Added to PATH in [`.profile`](.profile): `$HOME/dotfiles/git-toolbelt`

**Available scripts:** git-active-branches, git-autofixup, git-cleanup, git-current-branch, git-delete-merged-branches, and many more

#### Text Editors (TUI)

##### **Neovim**
Hyperextensible Vim-based text editor

**Installed by:** [`roles/nvim/`](roles/nvim/)

**Configuration:**
- Main config: [`.config/nvim/init.lua`](.config/nvim/init.lua)
- Plugin configs: [`.config/nvim/lua/plugins/config/`](.config/nvim/lua/plugins/config/)
  - [`coc.lua`](.config/nvim/lua/plugins/config/coc.lua) - Conquer of Completion (LSP)
  - [`treesitter.lua`](.config/nvim/lua/plugins/config/treesitter.lua) - Treesitter
  - [`fzf_lua.lua`](.config/nvim/lua/plugins/config/fzf_lua.lua) - Fuzzy finder
  - [`slime.lua`](.config/nvim/lua/plugins/config/slime.lua) - REPL integration
- Helpers: [`.config/nvim/lua/helpers/`](.config/nvim/lua/helpers/)
- Autoload: [`.config/nvim/autoload/`](.config/nvim/autoload/)
- Compilers: [`.config/nvim/compiler/`](.config/nvim/compiler/)
- Plugins: [`.config/nvim/pack/plugins/opt/`](.config/nvim/pack/plugins/opt/) (git submodules)

**Environment:**
- `EDITOR=nvim` in [`.config/shell/common.sh`](.config/shell/common.sh)

**Plugins:** coc.nvim, nvim-treesitter, fzf-lua, oil.nvim, vim-fugitive, vim-surround, vim-commentary, and 30+ more

##### **Vim**
Classic Vi IMproved editor

**Installed by:** [`roles/cli/tasks/vim.yml`](roles/cli/tasks/vim.yml)

**Configuration:**
- Config file: [`.vimrc`](.vimrc)
- Basic settings: line numbers, mouse support, syntax highlighting, smart search

##### **Helix**
Post-modern modal text editor

**Installed by:** [`roles/cli/tasks/helix.yml`](roles/cli/tasks/helix.yml)

**Configuration:** None (uses default config)

##### **Micro**
Modern terminal-based text editor

**Installed by:** [`roles/cli/tasks/micro.yml`](roles/cli/tasks/micro.yml)

**Configuration:** None (uses default config)

#### Terminal Multiplexers & Workspace

##### **tmux**
Terminal multiplexer

**Installed by:** [`roles/cli/tasks/main.yml`](roles/cli/tasks/main.yml)

**Configuration:**
- Config file: [`.tmux.conf`](.tmux.conf)
- Default shell: zsh
- True color support: `tmux-256color`
- Vi keybindings in copy mode
- Vim-style pane navigation (Ctrl-h/j/k/l)
- Mouse support enabled
- Base index 1 (windows and panes)
- Custom status bar (green background)
- Platform-specific clipboard integration (macOS, Linux, WSL)

##### **zellij**
Modern terminal workspace with layouts

**Installed by:** [`roles/cli/tasks/zellij.yml`](roles/cli/tasks/zellij.yml)

**Configuration:** None (uses default config)
- Version: 0.41.2

#### File Managers

##### **yazi**
Blazing fast terminal file manager written in Rust

**Installed by:** [`roles/cli/tasks/yazi.yml`](roles/cli/tasks/yazi.yml)

**Configuration:**
- Config: [`.config/yazi/yazi.toml`](.config/yazi/yazi.toml)
- Keymap: [`.config/yazi/keymap.toml`](.config/yazi/keymap.toml)
- Theme: [`.config/yazi/theme.toml`](.config/yazi/theme.toml)
- Init: [`.config/yazi/init.lua`](.config/yazi/init.lua)

##### **meld**
Visual diff and merge tool (has both GUI and CLI modes)

**Installed by:** [`roles/cli/tasks/meld.yml`](roles/cli/tasks/meld.yml)

**Configuration:** None (works cross-platform, has CLI interface)

#### Programming Languages & Runtimes

##### **Node.js**
JavaScript runtime

**Installed by:** [`roles/cli/tasks/main.yml`](roles/cli/tasks/main.yml) (via system package manager)

**Configuration:**
- NPM config: `.npmrc` (generated with prefix)
- NPM prefix: `$HOME/.npm-packages`
- Added to PATH in [`.profile`](.profile)

**Global packages:**
- `strip-ansi-cli`
- `@github/copilot` (GitHub Copilot CLI)

##### **Go**
Go programming language

**Installed by:** [`roles/cli/tasks/go.yml`](roles/cli/tasks/go.yml)

**Configuration:**
- `GOPATH="$HOME/go"` in [`.config/shell/common.sh`](.config/shell/common.sh) and [`.profile`](.profile)
- Go bin added to PATH: `$GOPATH/bin`, `/usr/local/go/bin`

##### **Rust**
Rust programming language with Cargo

**Installed by:** [`roles/cli/tasks/rust.yml`](roles/cli/tasks/rust.yml)

**Configuration:**
- Cargo bin added to PATH: `$HOME/.cargo/bin` in [`.profile`](.profile)
- Sourced in [`.bashrc`](.bashrc): `. "$HOME/.cargo/env"`

##### **Crystal**
Fast, compiled, type-safe programming language

**Installed by:** [`roles/cli/tasks/crystal.yml`](roles/cli/tasks/crystal.yml)

**Configuration:** None

##### **OpenJDK**
Open-source Java Development Kit

**Installed by:** [`roles/cli/tasks/openjdk.yml`](roles/cli/tasks/openjdk.yml)

**Configuration:** OpenJDK 21

##### **Maven**
Java build automation tool

**Installed by:** [`roles/cli/tasks/maven.yml`](roles/cli/tasks/maven.yml)

**Configuration:** None

##### **cargo-binstall**
Install Rust binaries without compiling

**Installed by:** [`roles/cli/tasks/cargo-binstall.yml`](roles/cli/tasks/cargo-binstall.yml)

**Configuration:** None

#### Build & Development Tools

##### **Docker**
Container platform

**Installed by:** [`roles/cli/tasks/docker.yml`](roles/cli/tasks/docker.yml)

**Configuration:**
- User added to docker group
- Service enabled
- **Platform notes:** Excluded on WSL and macOS (use Docker Desktop instead)

##### **asdf**
Extendable version manager with support for multiple languages and runtimes

**Installed by:** [`roles/cli/tasks/asdf.yml`](roles/cli/tasks/asdf.yml)

**Configuration:**
- Activated in [`.bashrc`](.bashrc) and [`.zshrc`](.zshrc)
- Completion enabled
- Manages Node.js, pnpm, and other language runtimes

##### **just**
Command runner (like make but better)

**Installed by:** [`roles/cli/tasks/just.yml`](roles/cli/tasks/just.yml)

**Configuration:**
- Justfile: [`justfile`](justfile)
- Recipes for running specific Ansible roles

##### **editorconfig**
Maintain consistent coding styles

**Installed by:** [`roles/cli/tasks/editorconfig.yml`](roles/cli/tasks/editorconfig.yml)

**Configuration:** editorconfig-checker for validation
- Version: 3.2.0

##### **tokei**
Code statistics tool

**Installed by:** [`roles/cli/tasks/tokei.yml`](roles/cli/tasks/tokei.yml)

**Configuration:** None

#### Documentation & Help

##### **cheat**
Interactive cheatsheets on the command-line

**Installed by:** [`roles/cli/tasks/cheat.yml`](roles/cli/tasks/cheat.yml)

**Configuration:**
- Config file: [`.config/cheat/conf.yml`](.config/cheat/conf.yml)
- Editor: vim, colorize: true, style: monokai
- Version: 4.4.2

##### **tlrc**
Official tldr client (simplified man pages)

**Installed by:** [`roles/cli/tasks/tlrc.yml`](roles/cli/tasks/tlrc.yml)

**Configuration:**
- Config file: [`.config/tlrc/config.toml`](.config/tlrc/config.toml)
- Custom styling and colors
- Version: 1.9.3

##### **tealdeer**
Fast tldr client in Rust

**Installed by:** [`roles/cli/tasks/tealdeer.yml`](roles/cli/tasks/tealdeer.yml)

**Configuration:** None

#### CLI-Only Applications

##### **1Password CLI (op)**
Command-line interface for 1Password

**Installed by:** [`roles/cli/tasks/1password-cli.yml`](roles/cli/tasks/1password-cli.yml)

**Configuration:** None (authenticate via `op signin`)

##### **Claude CLI**
Anthropic's Claude AI assistant CLI

**Installed by:** [`roles/cli/tasks/claude.yml`](roles/cli/tasks/claude.yml)

**Configuration:** None

##### **opencode**
Tool for opening code repositories

**Installed by:** [`roles/cli/tasks/opencode.yml`](roles/cli/tasks/opencode.yml)

**Configuration:**
- Bin added to PATH in [`.bashrc`](.bashrc): `/home/nisrael/.opencode/bin`

##### **sd**
Intuitive find & replace CLI (sed alternative)

**Installed by:** [`roles/cli/tasks/sd.yml`](roles/cli/tasks/sd.yml)

**Configuration:** None

##### **usage**
Tool for viewing tool usage

**Installed by:** [`roles/cli/tasks/usage.yml`](roles/cli/tasks/usage.yml)

**Configuration:** None

#### WSL-Specific Tools

##### **wslu (wslview)**
Collection of utilities for WSL

**Installed by:** [`roles/cli/tasks/wsl.yml`](roles/cli/tasks/wsl.yml)

**Configuration:**
- Alias in [`.config/shell/wsl.sh`](.config/shell/wsl.sh): `alias open='wslview'`

### GUI Tools (Linux + macOS, excluded from WSL)

All GUI tools are installed via the [`roles/gui/`](roles/gui/) role and automatically skip WSL.

#### Code Editors

##### **Visual Studio Code**
Popular extensible code editor

**Installed by:** [`roles/gui/tasks/vscode.yml`](roles/gui/tasks/vscode.yml)

**Configuration:** None (use VSCode settings sync)

##### **Zed**
High-performance multiplayer code editor

**Installed by:** [`roles/gui/tasks/zed.yml`](roles/gui/tasks/zed.yml)

**Configuration:**
- Settings: [`.config/zed/settings.json`](.config/zed/settings.json)
- Themes: [`.config/zed/themes/`](.config/zed/themes/)
- Channel: stable

#### Terminal Emulators

##### **WezTerm**
GPU-accelerated cross-platform terminal emulator

**Installed by:** [`roles/gui/tasks/wezterm.yml`](roles/gui/tasks/wezterm.yml)

**Configuration:**
- Config file: [`.config/wezterm/wezterm.lua`](.config/wezterm/wezterm.lua)

##### **Alacritty**
OpenGL terminal emulator

**Installed by:** [`roles/gui/tasks/alacritty.yml`](roles/gui/tasks/alacritty.yml)

**Configuration:**
- Generated config: `~/.config/alacritty/alacritty.toml` (from template)
- Template: [`roles/stow/templates/alacritty.toml.j2`](roles/stow/templates/alacritty.toml.j2)
- Common settings: [`.config/alacritty/common.toml`](.config/alacritty/common.toml)
- Platform-specific: [`.config/alacritty/linux.toml`](.config/alacritty/linux.toml), [`.config/alacritty/macos.toml`](.config/alacritty/macos.toml)
- Themes: [`.config/alacritty/themes/`](.config/alacritty/themes/)

#### Browsers

##### **Vivaldi**
Feature-rich web browser

**Installed by:** [`roles/gui/tasks/vivaldi.yml`](roles/gui/tasks/vivaldi.yml)

**Configuration:** None (use Vivaldi sync)

#### Security & VPN

##### **1Password**
Password manager (desktop app with browser integration)

**Installed by:** [`roles/gui/tasks/1password.yml`](roles/gui/tasks/1password.yml)

**Configuration:** None (use 1Password account)

##### **Mullvad**
Privacy-focused VPN client

**Installed by:** [`roles/gui/tasks/mullvad.yml`](roles/gui/tasks/mullvad.yml)

**Configuration:** None (configure via GUI)

##### **WireGuard**
Fast, modern VPN

**Installed by:** [`roles/gui/tasks/wireguard.yml`](roles/gui/tasks/wireguard.yml)

**Configuration:** None (configure via network manager)

#### Hardware & Development

##### **Arduino IDE**
Arduino development environment

**Installed by:** [`roles/gui/tasks/arduino.yml`](roles/gui/tasks/arduino.yml)

**Configuration:** None

##### **ueberzugpp**
Terminal image viewer (for yazi in GUI terminals)

**Installed by:** [`roles/gui/tasks/ueberzugpp.yml`](roles/gui/tasks/ueberzugpp.yml), [`roles/gui/tasks/ueberzugpp-fedora.yml`](roles/gui/tasks/ueberzugpp-fedora.yml)

**Configuration:** None

#### Fonts

##### **Nerd Fonts**
Patched fonts with icons and glyphs

**Installed by:** [`roles/gui/tasks/nerd-fonts.yml`](roles/gui/tasks/nerd-fonts.yml), [`roles/gui/tasks/nerd-fonts-install-one.yml`](roles/gui/tasks/nerd-fonts-install-one.yml)

**Fonts included:**
- JetBrains Mono
- Martian Mono
- Meslo
- Hack
- Zed Mono
- Envy Code R
- Fira Mono
- Comic Shanns Mono

**Installation:**
- Linux: `~/.local/share/fonts/<FontName>/`
- macOS: Homebrew casks (e.g., `font-jetbrains-mono-nerd-font`)

### Desktop Tools (Native Linux only)

All desktop tools are installed via the [`roles/desktop/`](roles/desktop/) role and only run on native Linux (not WSL, not macOS).

#### Desktop Environment

##### **GNOME**
Desktop environment configuration

**Installed by:** [`roles/desktop/tasks/gnome.yml`](roles/desktop/tasks/gnome.yml)

**Configuration:**
- Settings applied via `dconf` (community.general.dconf module)
- Extension settings loaded from dump files in [`roles/desktop/files/`](roles/desktop/files/)

**System settings:**
- Touchpad tap-to-click enabled
- Show battery percentage
- Alt+Tab current workspace only
- Night light: auto schedule, 4220K temperature
- Search providers disabled (Photos, Firefox, etc.)
- Custom keybindings

**Extensions installed:**
- appindicator-support (615)
- dash-to-dock (307)
- just-perfection (3843)
- open-bar (6580)
- top-bar-organizer (4356)

**Extension settings:**
- dash-to-dock: [`roles/desktop/files/dconf-org.gnome.shell.extensions.dash-to-dock.dump`](roles/desktop/files/dconf-org.gnome.shell.extensions.dash-to-dock.dump)
- just-perfection: [`roles/desktop/files/dconf-org.gnome.shell.extensions.just-perfection.dump`](roles/desktop/files/dconf-org.gnome.shell.extensions.just-perfection.dump)
- open-bar: [`roles/desktop/files/dconf-org.gnome.shell.extensions.openbar.dump`](roles/desktop/files/dconf-org.gnome.shell.extensions.openbar.dump)
- top-bar-organizer: [`roles/desktop/files/dconf-org.gnome.shell.extensions.top-bar-organizer.dump`](roles/desktop/files/dconf-org.gnome.shell.extensions.top-bar-organizer.dump)

##### **Flatpak**
Universal package management system

**Installed by:** [`roles/desktop/tasks/flatpak.yml`](roles/desktop/tasks/flatpak.yml)

**Applications installed:**
- **Media:** Spotify
- **Graphics:** GIMP, Inkscape
- **Browsers:** Chromium
- **Password:** KeePassXC
- **System:** Flatseal, Gear Lever, AppImagePool
- **Social:** Tuba (Mastodon)
- **Development:** ImHex, Bruno (API client)
- **3D/CAD:** FreeCAD
- **PDF:** PDF Slicer
- **Gaming:** Bottles

##### **ulauncher**
Application launcher for Linux

**Installed by:** [`roles/desktop/tasks/ulauncher.yml`](roles/desktop/tasks/ulauncher.yml)

**Configuration:**
- Config directory: [`.config/ulauncher/`](.config/ulauncher/)

### Language Servers & Linters

All LSP tools are installed via the [`roles/lsp/`](roles/lsp/) role.

##### **efm-langserver**
General-purpose language server

**Installed by:** [`roles/lsp/tasks/main.yml`](roles/lsp/tasks/main.yml)

**Configuration:**
- Config file: [`.config/efm-langserver/config.yaml`](.config/efm-langserver/config.yaml)
- Configured linters: yamllint, shellcheck, luacheck, stylua
- Version: 0.0.53

##### **shellcheck**
Shell script static analysis tool

**Installed by:** [`roles/lsp/tasks/shellcheck.yml`](roles/lsp/tasks/shellcheck.yml)

**Configuration:** Used by efm-langserver

##### **yamllint**
YAML linter (Python)

**Installed by:** [`roles/lsp/tasks/main.yml`](roles/lsp/tasks/main.yml)

**Configuration:** Used by efm-langserver

##### **luacheck**
Lua static analyzer and linter

**Installed by:** [`roles/lsp/tasks/main.yml`](roles/lsp/tasks/main.yml)

**Configuration:**
- Config file: [`.luacheckrc`](.luacheckrc)
- Globals: vim, awful, awesome

##### **stylua**
Lua code formatter

**Installed by:** [`roles/lsp/tasks/main.yml`](roles/lsp/tasks/main.yml)

**Configuration:**
- Config file: [`stylua.toml`](stylua.toml)
- Column width: 120, Unix line endings, 2-space indent
- Version: 0.13.1

##### **eslint**
JavaScript/TypeScript linter (npm)

**Installed by:** [`roles/lsp/tasks/main.yml`](roles/lsp/tasks/main.yml)

**Configuration:** Project-specific `.eslintrc` files

##### **prettier**
Opinionated code formatter (npm)

**Installed by:** [`roles/lsp/tasks/main.yml`](roles/lsp/tasks/main.yml)

**Configuration:** Project-specific `.prettierrc` files

### Shell Configuration

#### **Bash**
Bourne Again Shell

**Configuration:**
- Main config: [`.bashrc`](.bashrc)
- Login shell: [`.bash_profile`](.bash_profile)
- Common profile: [`.profile`](.profile)
- Common settings: [`.config/shell/common.sh`](.config/shell/common.sh)
- Platform-specific: [`.config/shell/linux.sh`](.config/shell/linux.sh), [`.config/shell/macos.sh`](.config/shell/macos.sh), [`.config/shell/wsl.sh`](.config/shell/wsl.sh)
- Local overrides: `.bashrc.local` (example: [`.bashrc.local.example`](.bashrc.local.example))

**Settings:**
- History: 50000 entries, ignore duplicates
- History ignore: `clear`, `ls`, `cd`, `exit`, etc.
- Bash completion enabled
- Git branch in prompt

#### **Zsh**
Z Shell

**Installed by:** [`roles/shell/`](roles/shell/)

**Configuration:**
- Main config: [`.zshrc`](.zshrc)
- Login shell: [`.zprofile`](.zprofile)
- Common settings: [`.config/shell/common.sh`](.config/shell/common.sh)
- Platform-specific: [`.config/shell/linux.sh`](.config/shell/linux.sh), [`.config/shell/macos.sh`](.config/shell/macos.sh), [`.config/shell/wsl.sh`](.config/shell/wsl.sh)
- Local overrides: `.zshrc.local`

**Settings:**
- History: 50000 entries
- Emacs keybindings
- Case-insensitive completion
- Git branch in prompt
- fzf, zoxide integration

##### **zsh-syntax-highlighting**
Real-time syntax highlighting for Zsh

**Installed by:** [`roles/shell/`](roles/shell/)

**Configuration:** Sourced in [`.zshrc`](.zshrc)

##### **zsh-autosuggestions**
Fish-like autosuggestions for Zsh

**Installed by:** [`roles/shell/`](roles/shell/)

**Configuration:** Sourced in [`.zshrc`](.zshrc)

#### **inputrc**
GNU readline configuration

**Configuration:**
- Config file: [`.inputrc`](.inputrc)
- History search with arrow keys
- Case-insensitive completion
- Bracketed paste mode

### Other Configuration Files

- [`.tmux.conf`](.tmux.conf) - tmux configuration
- [`.tigrc`](.tigrc) - tig configuration
- [`.vimrc`](.vimrc) - Vim configuration
- [`.hushlogin`](.hushlogin) - Suppress login messages
- [`ansible.cfg`](ansible.cfg) - Ansible configuration
- [`Vagrantfile`](Vagrantfile) - Vagrant VM for testing
- [`.stow-local-ignore`](.stow-local-ignore) - Files to ignore when stowing

## Platform-Specific Differences

### Configuration Strategy

The repository uses two different strategies for platform-specific configuration:

#### **Shell Configuration** (Runtime Detection)
Shell configurations (bash/zsh) use runtime platform detection with modular files:

- [`.config/shell/common.sh`](.config/shell/common.sh) - Shared for all platforms
- [`.config/shell/linux.sh`](.config/shell/linux.sh) - Native Linux only
- [`.config/shell/macos.sh`](.config/shell/macos.sh) - macOS only
- [`.config/shell/wsl.sh`](.config/shell/wsl.sh) - WSL only

Both [`.bashrc`](.bashrc) and [`.zshrc`](.zshrc) detect the platform using `uname` and source files in order: `common.sh` → platform-specific → `.local`

**Local overrides:** Create `.bashrc.local` or `.zshrc.local` for machine-specific settings (API keys, work configs). These are excluded from git/stow.

#### **Git Configuration** (Build-Time Template)
Git configuration uses Ansible templates to generate platform-specific config:

- `.gitconfig` - Generated by Ansible (NOT in version control)
- [`.config/git/common.gitconfig`](.config/git/common.gitconfig) - Shared settings
- [`.config/git/linux.gitconfig`](.config/git/linux.gitconfig) - Linux-specific
- [`.config/git/macos.gitconfig`](.config/git/macos.gitconfig) - macOS-specific
- [`.config/git/wsl.gitconfig`](.config/git/wsl.gitconfig) - WSL-specific

The generated `.gitconfig` includes the correct platform file. Run `./bootstrap` or `ansible-playbook bootstrap.yml --tags stow` to regenerate.

**Local overrides:** Copy [`.gitconfig.local.example`](.gitconfig.local.example) to `~/.gitconfig.local` for user info and credentials.

### Platform Comparison

| Feature | Native Linux | WSL | macOS |
|---------|-------------|-----|-------|
| **Package Manager** | apt (Ubuntu), dnf (Fedora) | apt (Ubuntu-based) | Homebrew |
| **GUI Apps** | ✓ (via apt/dnf/AppImage) | ✗ (not supported) | ✓ (via Homebrew casks) |
| **Desktop Config** | ✓ (GNOME, Flatpak) | ✗ (no desktop) | ✗ (uses native macOS) |
| **Docker** | ✓ (native Docker) | ✗ (use Docker Desktop) | ✗ (use Docker Desktop) |
| **Clipboard** | xclip | clip.exe | pbcopy/pbpaste |
| **Open command** | xdg-open | wslview | open (native) |
| **Fonts location** | `~/.local/share/fonts/` | N/A | Homebrew manages |
| **Terminal emulators** | WezTerm, Alacritty | None (use Windows) | WezTerm, Alacritty |
| **1Password** | Desktop app + CLI | CLI only | Desktop app + CLI |

### WSL-Specific Notes

- No GUI applications installed (use Windows apps)
- No Docker (use Docker Desktop for Windows)
- Uses `wslview` instead of `xdg-open`
- Clipboard integration via `clip.exe` in tmux
- Git configured to use `ssh.exe` for better Windows integration

### macOS-Specific Notes

- All tools installed via Homebrew when possible
- GUI apps installed as Homebrew casks
- No GNOME/Flatpak (uses native macOS desktop)
- `CLICOLOR=1` for colored `ls` output
- Python user packages paths added to PATH
- GNU tar installed separately (`gnu-tar`)

## Usage Examples

### Full Installation

```bash
# Clone repository with submodules
git clone --recursive https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install Ansible and dependencies
./install

# Run full bootstrap (auto-detects platform)
./bootstrap

# Add local git settings (name, email, ...)
cp .gitconfig.local.example ~/.gitconfig.local
vim ~/.gitconfig.local
```

### Selective Installation with Tags

```bash
# Minimal installation (essential tools only - perfect for servers)
ansible-playbook bootstrap.yml --tags minimal

# CLI tools only (perfect for SSH servers)
ansible-playbook bootstrap.yml --tags cli

# GUI applications only
ansible-playbook bootstrap.yml --tags gui

# Desktop environment config only
ansible-playbook bootstrap.yml --tags desktop

# Neovim setup only
ansible-playbook bootstrap.yml --tags nvim

# LSP servers only
ansible-playbook bootstrap.yml --tags lsp

# Update git submodules
ansible-playbook bootstrap.yml --tags submodules

# Re-run stow to update symlinks
ansible-playbook bootstrap.yml --tags stow

# Shell enhancements only
ansible-playbook bootstrap.yml --tags shell
```

### Using Justfile Recipes

The [`justfile`](justfile) provides convenient shortcuts:

```bash
# Install just if not already installed
cargo install just

# View available recipes
just --list

# Run specific roles
just minimal    # Minimal essential tools
just cli        # CLI tools only
just gui        # GUI applications only
just desktop    # Desktop environment config
just nvim       # Neovim setup
just lsp        # Language servers
just shell      # Shell enhancements
just stow       # Re-run stow

# Full bootstrap
just bootstrap
```

### Platform-Specific Scenarios

#### Minimal Server Setup (cross-distribution)
```bash
# Install only the most essential tools (works on Debian, Ubuntu, and RedHat)
# Includes: stow, zsh, basic CLI tools, asdf, fzf, bat, eza, zoxide, vim
ansible-playbook bootstrap.yml --tags minimal
```

#### SSH-only Server (full CLI setup)
```bash
# Install all CLI tools, no GUI
ansible-playbook bootstrap.yml --tags stow,shell,cli,lsp,nvim
```

#### WSL Workstation
```bash
# Automatic - bootstrap detects WSL and skips gui/desktop
./bootstrap
```

#### Native Linux Workstation
```bash
# Full installation including desktop customization
./bootstrap
```

#### macOS Workstation
```bash
# CLI + GUI, no desktop config
./bootstrap
```

## Development

### Adding a New CLI Tool

1. Create task file: `roles/cli/tasks/<tool-name>.yml`
2. Add platform-specific installation logic:
   ```yaml
   - name: Install <tool> (Ubuntu)
     apt:
       name: <tool>
       state: present
     when: ansible_distribution == "Ubuntu"

   - name: Install <tool> (macOS)
     homebrew:
       name: <tool>
       state: present
     when: ansible_distribution == "MacOSX"
   ```
3. Import in `roles/cli/tasks/main.yml`:
   ```yaml
   - import_tasks: <tool-name>.yml
     tags: [cli]
   ```
4. For binary downloads, install to `~/.local/bin/`

### Adding a Neovim Plugin

1. Add as git submodule:
   ```bash
   git submodule add <repo-url> .config/nvim/pack/plugins/opt/<plugin-name>
   ```
2. Load in `.config/nvim/init.lua`:
   ```lua
   vim.cmd("packadd! <plugin-name>")
   ```
3. Add configuration inline or in `lua/plugins/config/<plugin-name>.lua`
4. Commit both `.gitmodules` and the submodule

### Adding a Nerd Font

1. Edit `roles/gui/tasks/nerd-fonts.yml`
2. Add font name to the Linux section loop (must match GitHub release name)
3. Add corresponding Homebrew cask to macOS section
4. Fonts install to:
   - Linux: `~/.local/share/fonts/<FontName>/`
   - macOS: Homebrew manages automatically

### Managing GNOME Settings

#### System Settings
Use individual `community.general.dconf` tasks in `roles/desktop/tasks/gnome.yml`:

```yaml
- name: Enable tap-to-click
  community.general.dconf:
    key: "/org/gnome/desktop/peripherals/touchpad/tap-to-click"
    value: "true"
```

#### Extension Settings
Extensions don't have schemas, so use dconf dumps:

1. Configure the extension via GUI
2. Export settings:
   ```bash
   dconf dump /org/gnome/shell/extensions/extension-name/ > \
     roles/desktop/files/dconf-org.gnome.shell.extensions.extension-name.dump
   ```
3. Add load task in `roles/desktop/tasks/gnome.yml`:
   ```yaml
   - name: Load extension settings
     ansible.builtin.shell:
       cmd: dconf load /org/gnome/shell/extensions/extension-name/ < {{ role_path }}/files/dconf-org.gnome.shell.extensions.extension-name.dump
     changed_when: false
   ```

### Platform Detection in Tasks

Use Ansible facts for conditional execution:

```yaml
# Ubuntu only
when: ansible_distribution == "Ubuntu"

# Fedora only
when: ansible_distribution == "Fedora"

# macOS only
when: ansible_distribution == "MacOSX"

# WSL detection
when: ansible_kernel is search("microsoft")

# Native Linux (not macOS, not WSL)
when: ansible_system == "Linux" and not ansible_kernel is search("microsoft")

# Exclude WSL
when: not ansible_kernel is search("microsoft")
```

## Troubleshooting

### Git Submodules

If plugins are missing:
```bash
# Initialize and update all submodules
git submodule update --init --recursive
```

### Stow Conflicts

If stow fails due to existing files:
```bash
# Backup existing dotfiles
mkdir ~/dotfiles-backup
mv ~/.bashrc ~/.zshrc ~/dotfiles-backup/

# Re-run stow
ansible-playbook bootstrap.yml --tags stow
```

### Neovim Treesitter

If syntax highlighting is broken:
```bash
# Re-install Treesitter parsers
nvim -c "TSUpdateSync" -c "qa"
```

### Platform Detection

Check platform detection:
```bash
# View Ansible facts
ansible localhost -m setup | grep ansible_distribution
ansible localhost -m setup | grep ansible_kernel
```

## License

Personal dotfiles - use at your own discretion.
