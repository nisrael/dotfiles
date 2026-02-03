# PlatformIO Configuration for Neovim

## Summary of Changes

Your Neovim configuration has been updated with PlatformIO development support!

### Files Modified:
1. `lua/plugins/lsp.lua` - Added clangd LSP server for C/C++ support
2. `lua/plugins/treesitter.lua` - Added Arduino treesitter parser
3. `lua/plugins/platformio.lua` - NEW: PlatformIO integration
4. `lua/plugins/tasks.lua` - NEW: Overseer task runner with PlatformIO tasks

---

## What Was Added

### 1. C/C++ Language Server (clangd)
- Provides IntelliSense, auto-completion, go-to-definition for C/C++ code
- Automatically installed via Mason

### 2. PlatformIO Plugin (`nvim-platformio.lua`)
- Direct integration with PlatformIO CLI
- Commands for build, upload, monitor, test, debug
- Telescope integration for quick command access

### 3. Task Runner (Overseer)
- Visual task management for build processes
- Pre-configured PlatformIO tasks
- Integration with ToggleTerm for output display

### 4. Terminal Management (ToggleTerm)
- Better terminal handling for serial monitor
- Multiple terminal layouts (float, horizontal, vertical)

---

## Keybindings

### PlatformIO Commands (Leader = Space)
| Keymap | Command | Description |
|--------|---------|-------------|
| `<leader>pb` | PIOBuild | Build project |
| `<leader>pu` | PIOUpload | Upload to device |
| `<leader>pm` | PIOMonitor | Serial monitor |
| `<leader>pc` | PIOClean | Clean build files |
| `<leader>pi` | PIOInit | Initialize new project |
| `<leader>pt` | PIOTest | Run tests |
| `<leader>pd` | PIODebug | Start debugger |
| `<leader>pp` | Telescope commands | Show all PlatformIO commands |

### Task Runner (Overseer)
| Keymap | Command | Description |
|--------|---------|-------------|
| `<leader>or` | OverseerRun | Run a task |
| `<leader>ot` | OverseerToggle | Toggle task list |
| `<leader>oo` | OverseerOpen | Open task list |
| `<leader>oc` | OverseerClose | Close task list |
| `<leader>oq` | OverseerQuickAction | Quick task action |

### Terminal
| Keymap | Command | Description |
|--------|---------|-------------|
| `<C-\>` | ToggleTerm | Toggle terminal |
| `<leader>tf` | Float terminal | Floating terminal |
| `<leader>th` | Horizontal terminal | Bottom terminal |
| `<leader>tv` | Vertical terminal | Side terminal |
| `<Esc>` (in terminal) | Exit | Exit terminal mode |

---

## Getting Started

### 1. First Time Setup
After opening Neovim, the plugins will automatically install. You can also manually run:
```vim
:Lazy sync
```

### 2. Install PlatformIO CLI (if not already installed)
```bash
# Using pip
pip install platformio

# Or using your package manager
# Fedora/RHEL
sudo dnf install platformio

# Ubuntu/Debian
sudo apt install platformio
```

### 3. Open a PlatformIO Project
Navigate to a directory with `platformio.ini` file, or initialize a new project:
```vim
:PIOInit
```

### 4. Build and Upload
- **Build**: Press `<Space>pb` or `:PIOBuild`
- **Upload**: Press `<Space>pu` or `:PIOUpload`
- **Monitor**: Press `<Space>pm` or `:PIOMonitor`

### 5. Using the Task Runner
- Press `<Space>or` to see available tasks
- Select a PlatformIO task (build, upload, clean, etc.)
- Press `<Space>ot` to toggle the task output window

---

## Workflow Example

1. **Open your PlatformIO project**
   ```bash
   cd ~/my-arduino-project
   nvim .
   ```

2. **Edit your code** (e.g., `src/main.cpp`)
   - Get full C++ IntelliSense from clangd
   - Auto-completion, go-to-definition works!

3. **Build the project**
   - Press `<Space>pb`
   - Or use task runner: `<Space>or` → select "platformio build"

4. **Upload to device**
   - Press `<Space>pu`
   - Or use task runner: `<Space>or` → select "platformio upload"

5. **Open serial monitor**
   - Press `<Space>pm`
   - Exit with `<Esc>` then `:q`

---

## Additional Tips

### clangd Configuration
For better C++ support, you can create a `.clangd` file in your project root:
```yaml
CompileFlags:
  Add: 
    - "-I/path/to/your/libraries"
    - "-std=c++11"
```

PlatformIO usually generates a `compile_commands.json` file that clangd uses automatically.

### Generate compile_commands.json
If clangd isn't working properly, generate the compile commands:
```bash
pio run --target compiledb
```

### Troubleshooting
- **LSP not starting**: Run `:LspInfo` to check status
- **PlatformIO commands not found**: Ensure `pio` is in your PATH
- **Plugins not loading**: Run `:Lazy sync` to update plugins

---

## What's Next (Optional Enhancements)

If you want even more features, consider adding:
1. **DAP (Debugger)** - `mfussenegger/nvim-dap` for breakpoint debugging
2. **CMake Support** - `Civitasv/cmake-tools.nvim` if you use CMake
3. **Copilot/AI** - `github/copilot.vim` for AI-assisted coding
4. **Better UI** - `folke/noice.nvim` for enhanced UI messages

Enjoy your PlatformIO development in Neovim! 🚀
