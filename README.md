# Dotfiles

Personal dotfiles repository for Linux (Ubuntu, Fedora) and macOS development environments. This setup uses Ansible playbooks to automate installation and configuration of development tools, with GNU Stow for managing symlinks.

## Quick Start

```bash
# Install Ansible and dependencies
./install

# Run the full bootstrap playbook
./bootstrap
```

## Installed Tools and Programs

### Programming Languages & Runtimes

- **Node.js** - JavaScript runtime (via geerlingguy.nodejs role)
- **Go** - Go programming language
- **Rust** - Rust programming language with Cargo
- **Crystal** - Crystal programming language
- **Java** - OpenJDK 21
- **Python 3** - Python 3 with pip and pynvim

### Build Tools & Package Managers

- **Maven** - Java build automation tool
- **mise** - Polyglot runtime manager (formerly rtx)
- **npm** - Node.js package manager
- **pip** - Python package installer

### Text Editors

- **Neovim** - Modern Vim fork with extensive plugin ecosystem (see Neovim Plugins section)
- **Vim** - Classic Vi IMproved editor
- **Helix** - Post-modern modal text editor
- **Micro** - Modern terminal-based text editor
- **Zed** - High-performance collaborative code editor

### Terminal Emulators

- **WezTerm** - GPU-accelerated cross-platform terminal emulator
- **Kitty** - Fast, feature-rich, GPU-based terminal emulator
- **Alacritty** - OpenGL terminal emulator

### Shell & Shell Enhancements

- **Zsh** - Z shell (alternative to Bash)
- **Bash** - Bourne Again Shell (configured with modular platform-specific configs)
- **zsh-syntax-highlighting** - Fish shell-like syntax highlighting for Zsh
- **zsh-autosuggestions** - Fish-like autosuggestions for Zsh

### Version Control & Git Tools

- **Git** - Distributed version control system
- **tig** - Text-mode interface for Git
- **git-delta** - Syntax-highlighting pager for Git
- **difftastic** - Structural diff tool
- **git-absorb** - Automatic commit fixup tool
- **GitHub CLI (gh)** - Official GitHub command-line tool
- **GitHub Copilot CLI** - AI-powered CLI assistant

### Terminal Multiplexers & File Managers

- **tmux** - Terminal multiplexer
- **zellij** - Modern terminal workspace
- **yazi** - Blazing fast terminal file manager

### Search & Navigation Tools

- **ripgrep (rg)** - Fast recursive grep alternative
- **fd** - Fast and user-friendly alternative to find
- **fzf** - Command-line fuzzy finder
- **zoxide** - Smarter cd command

### System Monitoring & Utilities

- **htop** - Interactive process viewer
- **btop** - Resource monitor with modern interface
- **tokei** - Code statistics tool

### File Processing & Text Tools

- **jq** - Command-line JSON processor
- **bat** - Cat clone with syntax highlighting
- **7zip** - File archiver with high compression ratio
- **moreutils** - Collection of Unix tools (sponge, chronic, etc.)
- **xclip** - Command-line interface to X selections (Linux)
- **unzip** - Archive extraction utility

### Development Tools

- **Docker** - Container platform
- **editorconfig-checker** - EditorConfig validation tool
- **cheat** - Interactive cheatsheets on the command-line
- **tlrc** - Official tldr client (simplified man pages)
- **Claude CLI** - Anthropic's Claude AI assistant CLI
- **OpenCode** - VS Code CLI alternative

### LSP Servers

- **efm-langserver** - General-purpose language server
- **shellcheck** - Shell script static analysis tool
- **CoC (Conquer of Completion)** - Neovim LSP client

### Linters & Formatters

- **yamllint** - YAML linter (Python)
- **eslint** - JavaScript/TypeScript linter (npm)
- **prettier** - Opinionated code formatter (npm)
- **StyLua** - Lua code formatter

### Security & Password Management

- **1Password CLI (op)** - Command-line interface for 1Password
- **1Password** - Password manager (Linux desktop)

### Fonts

**Nerd Fonts** (patched fonts with icons):
- JetBrains Mono
- Martian Mono
- Meslo
- Hack
- Zed Mono
- Envy Code R
- Fira Mono

### Browsers

- **Vivaldi** - Feature-rich web browser
- **Chromium** - Open-source web browser (Flatpak)

### Linux Desktop Applications (Flatpak)

**Media:**
- Spotify - Music streaming client

**Graphics & Image Editing:**
- GIMP - GNU Image Manipulation Program
- Inkscape - Vector graphics editor

**System Tools:**
- Flatseal - Flatpak permission manager
- Gearlever - AppImage manager
- AppImagePool - AppImage store
- ulauncher - Application launcher

**Development Tools:**
- ImHex - Hex editor
- Bruno - API client (Postman alternative)

**3D Modeling & CAD:**
- FreeCAD - Parametric 3D CAD modeler

**PDF Tools:**
- PDFSlicer - PDF manipulation tool

**Social:**
- Tuba - Mastodon client

**Gaming & Compatibility:**
- Bottles - Windows software manager

**Hardware:**
- Arduino IDE - Arduino development environment
- ueberzugpp - Terminal image viewer

**Password Management:**
- KeePassXC - Cross-platform password manager

### Neovim Plugins

**Text Editing:**
- vim-surround - Manipulate surrounding characters
- vim-repeat - Repeat plugin maps with .
- vim-unimpaired - Pairs of handy bracket mappings
- vim-speeddating - Increment/decrement dates and times
- vim-abolish - Easily search for, substitute, and abbreviate variants
- vim-lion - Alignment operator
- vim-commentary - Comment/uncomment code
- vim-sleuth - Automatic indent detection
- undotree - Undo history visualizer
- dsf.vim - Delete/change surrounding function calls
- inline_edit.vim - Edit code blocks inline
- treesj - Split/join code blocks using Treesitter

**Git Integration:**
- vim-fugitive - Git wrapper
- gv.vim - Git commit browser
- vim-rhubarb - GitHub integration for fugitive
- fugitive-gitlab.vim - GitLab integration for fugitive
- vim-fugitive-blame-ext - Extended git blame
- vim-twiggy - Git branch management

**File Navigation:**
- oil.nvim - File explorer as a buffer
- fzf-lua - Fuzzy finder for files, buffers, etc.

**LSP & Completion:**
- coc.nvim - Conquer of Completion (LSP client)

**Syntax & Parsing:**
- nvim-treesitter - Treesitter integration
- nvim-treesitter-textobjects - Textobjects using Treesitter
- nvim-ts-context-commentstring - Context-aware commenting

**UI Enhancements:**
- statuscol.nvim - Customizable statuscolumn
- nvim-ufo - Folding enhancement

**Session & Testing:**
- vim-obsession - Session management
- vim-test - Run tests from Neovim
- vim-dispatch - Asynchronous build and test dispatcher

**REPL Integration:**
- vim-slime - Send code to REPL

**Utilities:**
- plenary.nvim - Lua utility functions (dependency)
- promise-async - Async promise implementation
- jsonpath.nvim - JSONPath query support
- LargeFile - Performance optimization for large files
- vim-hugo - Hugo static site generator support

## Ansible Setup

### Architecture

This repository uses a single Ansible playbook (`bootstrap.yml`) that orchestrates multiple roles. Each role is responsible for a specific category of tools or configuration.

### Roles

#### 1. **stow** (Symlink Management)
- Uses GNU Stow to create symlinks from this repository to `$HOME`
- Removes conflicting default files (like `.bashrc`) before symlinking
- Generates `.gitconfig` from Jinja2 template with platform-specific includes
- Platform-specific task files: `ubuntu.yml`, `fedora.yml`, `macos.yml`

**What gets symlinked:**
- Shell configurations (`.bashrc`, `.zshrc`)
- `.config/` directory (Neovim, shell, git, tmux, etc.)
- `.tmux.conf`, `.tigrc`
- Other dotfiles in repository root

#### 2. **homebrew**
- Installs Homebrew package manager on macOS
- Only runs on macOS systems

#### 3. **shell**
- Installs Zsh shell
- Installs zsh-syntax-highlighting
- Installs zsh-autosuggestions

**Configuration approach:**
- Runtime platform detection in shell scripts
- Modular configuration files in `.config/shell/`:
  - `common.sh` - Shared configuration
  - `linux.sh` - Native Linux settings
  - `macos.sh` - macOS settings
  - `wsl.sh` - WSL-specific settings

#### 4. **nodejs**
- Uses the `geerlingguy.nodejs` external role
- Installs Node.js and npm
- Required for npm-based tools and LSP servers

#### 5. **cli** (Command-Line Tools)
- Largest role with platform-specific installation logic
- Installs core CLI tools via package managers (apt/dnf/homebrew)
- Downloads and installs binary releases from GitHub for tools like:
  - git-delta, difftastic, tokei, bat, eza, btop, zellij, yazi, etc.
- Installs terminal emulators (WezTerm, Kitty, Alacritty)
- Installs programming languages (Go, Rust, Crystal, OpenJDK, Maven)
- Installs development tools (Docker, mise, GitHub CLI, Claude CLI, Zed, etc.)
- Installs Nerd Fonts (cross-platform font installation)
- Installs npm global packages (strip-ansi-cli, @github/copilot)
- WSL-specific utilities (when running on WSL)

**Pattern:** Each tool typically has its own task file (e.g., `git-delta.yml`, `bat.yml`) imported from `main.yml`

#### 6. **lsp** (Language Server Protocol)
- Installs LSP servers: efm-langserver, shellcheck
- Installs linters and formatters:
  - Python: yamllint (via pip)
  - JavaScript/TypeScript: eslint, prettier (via npm)
  - Lua: StyLua (GitHub release)

#### 7. **nvim** (Neovim)
- Installs Neovim via platform-specific methods:
  - Ubuntu: AppImage from GitHub releases
  - Fedora: dnf package
  - macOS: Homebrew
- Installs pynvim Python package
- Generates Vim help tags (`:helptags ALL`)
- Installs Treesitter parsers (`:TSUpdateSync`)
- Plugins are managed as git submodules in `.config/nvim/pack/plugins/opt/`

#### 8. **editors**
- Installs additional text editors: Helix, Micro

#### 9. **linux-desktop** (Linux Desktop Environment)
- Only runs on native Linux (not WSL, not in CI)
- Installs and configures desktop applications
- Sets up Flatpak and installs Flatpak applications
- Installs desktop tools: 1Password, Vivaldi, ulauncher, Arduino IDE, ueberzugpp
- Configures GNOME desktop settings via dconf
- Platform-specific tasks for Fedora and Ubuntu

**GNOME Configuration Strategy:**
- **System settings:** Individual `community.general.dconf` tasks (readable, validated)
- **Extension settings:** Bulk load via `dconf dump/load` files in `roles/linux-desktop/files/`

### Running Specific Roles

Use Ansible tags to run only specific parts of the setup:

```bash
# Update git submodules only
ansible-playbook bootstrap.yml --tags submodules

# Install Neovim configuration only
ansible-playbook bootstrap.yml --tags nvim

# Install CLI tools only
ansible-playbook bootstrap.yml --tags cli

# Install LSP servers only
ansible-playbook bootstrap.yml --tags lsp

# Install Node.js tools only
ansible-playbook bootstrap.yml --tags nodejs

# Install Linux desktop tools (Fedora/Ubuntu only)
ansible-playbook bootstrap.yml --tags linux

# Run stow to symlink dotfiles
ansible-playbook bootstrap.yml --tags stow

# Install shell enhancements only
ansible-playbook bootstrap.yml --tags shell

# Install editors (Helix, Micro)
ansible-playbook bootstrap.yml --tags editors
```

### Platform Detection

The playbook uses Ansible facts to detect the platform and run appropriate tasks:

- `ansible_distribution == "Ubuntu"` - Ubuntu-specific tasks
- `ansible_distribution == "Fedora"` - Fedora-specific tasks
- `ansible_distribution == "MacOSX"` - macOS-specific tasks
- `ansible_kernel is search("microsoft")` - WSL detection
- `ansible_system is search("Linux")` - Native Linux (not macOS)

### Configuration File Strategy

#### Shell Configuration (Runtime Detection)
- `.bashrc` and `.zshrc` detect platform at shell startup
- Source platform-specific files from `.config/shell/`:
  - `common.sh` → `{linux,macos,wsl}.sh` → `.{bash,zsh}rc.local`
- Local overrides: Create `.bashrc.local` or `.zshrc.local` (excluded from git)

#### Git Configuration (Build-Time Template)
- `.gitconfig` is generated by Ansible from `roles/stow/templates/gitconfig.j2`
- Platform-specific includes from `.config/git/`:
  - `common.gitconfig`, `{linux,macos,wsl}.gitconfig`
- Local overrides: Copy `.gitconfig.local.example` to `~/.gitconfig.local`

### Testing

Automated testing runs on every push via GitHub Actions:

```bash
# Ubuntu CI test
./install
./bootstrap
```

Test workflow: `.github/workflows/test.yml`

### Development Patterns

**Adding a new CLI tool:**
1. Create task file: `roles/cli/tasks/<tool-name>.yml`
2. Add platform-specific installation logic
3. Import in `roles/cli/tasks/main.yml`
4. Binary downloads typically install to `~/.local/bin/`

**Adding a Neovim plugin:**
1. Add as submodule: `git submodule add <url> .config/nvim/pack/plugins/opt/<name>`
2. Load in `.config/nvim/init.lua`: `vim.cmd("packadd! <name>")`
3. Add configuration inline or in `lua/plugins/config/`
4. Commit `.gitmodules` and submodule changes

**Adding a Nerd Font:**
1. Edit `roles/cli/tasks/nerd-fonts.yml`
2. Add font name to `nerd_fonts_list` (must match GitHub release name)
3. Add corresponding Homebrew cask for macOS

**Managing GNOME settings:**
- System settings: Add `community.general.dconf` task in `roles/linux-desktop/tasks/gnome.yml`
- Extension settings: Export with `dconf dump`, save to `roles/linux-desktop/files/`, load via `dconf load`

## Configuration Files

- **`.gitconfig`** - Generated by Ansible (not in version control)
- **`.gitconfig.local`** - Machine-specific git settings (not in version control)
- **`.config/git/`** - Platform-specific git configs
- **`.config/shell/`** - Platform-specific shell configs
- **`.config/nvim/`** - Neovim configuration and plugins
- **`.tmux.conf`** - tmux configuration
- **`.zshrc`** - Zsh configuration
- **`.bashrc`** - Bash configuration
- **`.tigrc`** - tig configuration
- **`ansible.cfg`** - Ansible configuration
- **`Vagrantfile`** - Vagrant VM for testing

## License

Personal dotfiles - use at your own discretion.
