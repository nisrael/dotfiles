# PlatformIO Setup - ARM64 (Fedora Asahi) Notes

## Issues Fixed

### 1. ✅ clangd Installation Error
**Problem:** Mason couldn't install clangd - "The current platform is unsupported"
**Reason:** You're on ARM64 (aarch64) and Mason doesn't support clangd for ARM64
**Solution:** Use system clangd instead (already installed!)

Your system has **clangd 21.1.8** installed via Fedora packages.

### 2. ✅ PlatformIO Plugin Configuration Errors
**Problem:** Invalid boolean values in configuration
**Solution:** Fixed configuration and made plugin lazy-loaded

### 3. ✅ PlatformIO CLI Not Found
**Status:** PlatformIO is not yet installed on your system
**Solution:** Install it (see below)

---

## What Changed

### `lua/plugins/lsp.lua`
- ✅ Removed `clangd` from Mason's `ensure_installed` list
- ✅ Added comment explaining clangd comes from system packages
- ✅ LSP configuration still includes clangd (uses system binary)

### `lua/plugins/platformio.lua`
- ✅ Fixed invalid boolean configuration options
- ✅ Made plugin lazy-loaded (only loads for C/C++/Arduino files)
- ✅ Added check for PlatformIO CLI with warning if not installed
- ✅ Added file type triggers: `c`, `cpp`, `arduino`

---

## Installation Steps

### 1. Install PlatformIO CLI (Required for PlatformIO features)

Choose one method:

#### Option A: Using pip (Recommended)
```bash
pip install --user platformio
```

Then add to your PATH in `~/.zshrc` or `~/.bashrc`:
```bash
export PATH="$HOME/.local/bin:$PATH"
```

#### Option B: Using pipx (Isolated install)
```bash
# Install pipx if not already installed
sudo dnf install pipx
pipx ensurepath

# Install PlatformIO
pipx install platformio
```

#### Option C: System package (might be outdated)
```bash
sudo dnf install platformio
```

### 2. Verify Installation
```bash
pio --version
# Should show: PlatformIO Core, version X.X.X
```

### 3. Restart Neovim
```bash
nvim
```

The plugins will load correctly now!

---

## Verification Checklist

Run these commands to verify everything works:

### Check clangd (C/C++ LSP)
```bash
clangd --version
# Should show: clangd version 21.1.8 (Fedora 21.1.8-4.fc43)
```

### Check PlatformIO
```bash
pio --version
# Should show version after installation
```

### In Neovim - Check LSP
1. Open a C/C++ file
2. Run `:LspInfo`
3. Should see `clangd` attached

### In Neovim - Check PlatformIO
1. Open a PlatformIO project (directory with `platformio.ini`)
2. Try `:PIOBuild` or press `<Space>pb`
3. Should work without errors

---

## Current Status

| Component | Status | Notes |
|-----------|--------|-------|
| clangd LSP | ✅ Working | System version 21.1.8 |
| Mason | ✅ Working | Other LSPs install fine |
| PlatformIO Plugin | ✅ Fixed | Needs PIO CLI installed |
| PlatformIO CLI | ⚠️ Not Installed | Install with pip/pipx |
| Task Runner | ✅ Ready | Will work once PIO installed |

---

## Next Steps

1. **Install PlatformIO CLI** (see above)
2. **Restart your shell** to reload PATH
3. **Open Neovim** - plugins will load correctly
4. **Test with a PlatformIO project**:
   ```bash
   # Create test project
   mkdir ~/test-pio && cd ~/test-pio
   pio project init --board uno
   nvim .
   ```

---

## Troubleshooting

### If clangd doesn't work in Neovim
```bash
# Reinstall clang tools
sudo dnf reinstall clang-tools-extra

# Check in Neovim
nvim
:LspInfo
```

### If PlatformIO commands don't work
```bash
# Verify pio is in PATH
which pio

# If not found, add to ~/.zshrc:
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### If you get "PlatformIO not found" warning in Neovim
This is normal if you haven't installed PlatformIO CLI yet. The plugin will work once you install it.

---

## ARM64 Specific Notes

You're running **Fedora Asahi (ARM64)**. Some considerations:

1. **clangd** - Must use system package (Mason doesn't support ARM64)
2. **PlatformIO** - Works fine on ARM64, but you need to install via pip/pipx
3. **Other LSPs** - Mason works for most other languages

For any LSP that Mason can't install on ARM64, install via system packages:
```bash
sudo dnf search language-server
```

---

## Summary

✅ **Fixed:** clangd now uses system installation  
✅ **Fixed:** PlatformIO plugin configuration errors  
✅ **Fixed:** Made PlatformIO lazy-loaded for better performance  
⚠️ **Action Required:** Install PlatformIO CLI with `pip install --user platformio`

After installing PlatformIO CLI, restart Neovim and everything should work! 🚀
