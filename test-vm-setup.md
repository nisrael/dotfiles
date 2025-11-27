# Testing Dotfiles in VMware Fusion

## Quick Start

### 1. Create macOS VM

1. Open VMware Fusion
2. File → New → Create a custom virtual machine
3. Select macOS → Choose the latest version you want to test
4. Configure: 4GB RAM minimum, 50GB disk
5. Finish and install macOS (takes ~30 minutes)

### 2. Initial VM Setup

After macOS installation completes:

```bash
# In the VM, open Terminal

# Install git (will prompt for Xcode Command Line Tools)
git --version

# Create SSH key for GitHub access
ssh-keygen -t ed25519 -C "test@vm"
cat ~/.ssh/id_ed25519.pub
# Add this key to your GitHub account (Settings → SSH Keys)

# Clone your dotfiles
git clone --recursive git@github.com:nisrael/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 3. Take Snapshot (Important!)

**Before testing, take a snapshot:**
- Virtual Machine → Snapshots → Take Snapshot
- Name it: "Fresh macOS - Before dotfiles"
- This lets you quickly reset and re-test

### 4. Test Installation

```bash
# Run the install script
./install

# Run the bootstrap
./bootstrap

# Test specific components
just minimal
just cli
just gui
```

### 5. Verify Installation

Check that everything works:

```bash
# Verify stow created symlinks
ls -la ~/
ls -la ~/.config/

# Verify tools are installed
which bat eza zoxide fzf
which colima docker-buildx

# Test zsh config
zsh
echo $SHELL

# Check Homebrew packages
brew list
```

### 6. Reset for Re-testing

To test again from fresh state:
- Virtual Machine → Snapshots → Restore Snapshot
- Select "Fresh macOS - Before dotfiles"
- Click Restore

## Alternative: Shared Folder Method

Instead of cloning, you can mount your host dotfiles folder:

1. Virtual Machine → Settings → Sharing
2. Enable "Share folders with the virtual machine"
3. Add your dotfiles folder: `/Users/nisrael/dotfiles`
4. In VM, access via: `/Volumes/VMware Shared Folders/dotfiles`

This way you can edit on host and test changes immediately in VM!

```bash
# In VM
cd /Volumes/VMware\ Shared\ Folders/dotfiles
./install
./bootstrap
```

## Tips

- **Fast Testing:** Use snapshots to quickly reset between tests
- **Multiple VMs:** Create VMs for different macOS versions
- **Headless Mode:** Run VM in background while testing
- **Auto-start:** Configure VM to auto-start for CI-like testing
