# Platform-Specific Shell Configuration

This directory contains shell configuration files that are automatically sourced based on the detected platform.

## Files

- **common.sh** - Configuration shared across all platforms (Linux, macOS, WSL)
- **linux.sh** - Native Linux-specific configuration
- **macos.sh** - macOS-specific configuration
- **wsl.sh** - Windows Subsystem for Linux-specific configuration

## How It Works

Both `.bashrc` and `.zshrc` automatically detect the platform and source the appropriate files:

1. Always sources `common.sh` first
2. Detects platform using `uname` commands
3. Sources the platform-specific file (linux.sh, macos.sh, or wsl.sh)
4. Finally sources `.bashrc.local` or `.zshrc.local` if present (for machine-specific overrides)

## Platform Detection Logic

```bash
if uname | grep -iq darwin; then
  # macOS detected → source macos.sh
elif uname -a | grep -iq microsoft; then
  # WSL detected → source wsl.sh
elif uname | grep -iq linux; then
  # Native Linux detected → source linux.sh
fi
```

## What Goes Where?

### common.sh
- Editor configuration (EDITOR=nvim)
- Tools available everywhere (fzf, zoxide)
- Universal aliases (cat='bat')
- Common environment variables

### linux.sh
- Linux-specific `ls` aliases with GNU options
- `xdg-open` for the `open` command
- `dircolors` configuration

### macos.sh
- Homebrew setup
- macOS `CLICOLOR` configuration
- macOS-specific PATH additions (Python user packages, Android SDK)

### wsl.sh
- WSL-specific `ls` aliases
- `wslview` for the `open` command (requires wslu package)
- SSH keychain persistence
- Windows interop settings

## Local Overrides

For machine-specific configuration that shouldn't be version controlled:

1. Create `~/.bashrc.local` or `~/.zshrc.local`
2. Add your custom configuration
3. These files are automatically sourced last, overriding earlier settings

Example `.bashrc.local`:
```bash
# Work-specific aliases
alias vpn='sudo openvpn --config /path/to/work.ovpn'

# Private tokens (never commit these!)
export GITHUB_TOKEN="your-token"
```

These `.local` files are:
- Excluded from git (in `.gitignore`)
- Not stowed to your home directory (in `.stow-local-ignore`)
- Perfect for secrets, work-specific configs, or machine-specific tweaks
