# Neovim Quick Reference

## 🚀 First Time Setup

```bash
nvim
# Wait 1-2 minutes for plugins to install
# Quit and reopen: :q then nvim
```

Check health: `:checkhealth`

---

## ⌨️ Essential Keybindings

### Leader Keys
- **Leader**: `Space`
- **Local Leader**: `\`

---

## 📁 File Navigation

| Key | Action |
|-----|--------|
| `<Space>e` | Toggle file tree |
| `<Space>ff` | Find files |
| `<Space>fg` | Live grep (search in files) |
| `<Space>fb` | Find buffers |
| `<Space>fr` | Recent files |
| `<Space>fw` | Find word under cursor |
| `<Space>fc` | Find commands |
| `<Space>fk` | Find keymaps |

### In File Tree (nvim-tree)
| Key | Action |
|-----|--------|
| `→` | Open file/folder |
| `←` | Close folder |
| `.` | Toggle hidden files |
| `a` | Create new file |
| `d` | Delete file |
| `r` | Rename file |
| `x` | Cut file |
| `p` | Paste file |
| `y` | Copy filename |

---

## 🔍 LSP (Language Server)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Go to references |
| `K` | Hover documentation |
| `<Space>ca` | Code actions |
| `<Space>rn` | Rename symbol |
| `<Space>d` | Show diagnostic |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

### LSP Management
- `:Mason` - Install/manage LSP servers
- `:LspInfo` - Show LSP status

---

## 🎨 Git Integration

| Key | Action |
|-----|--------|
| `]c` | Next hunk |
| `[c` | Previous hunk |
| `<Space>hs` | Stage hunk |
| `<Space>hr` | Reset hunk |
| `<Space>hu` | Undo stage hunk |
| `<Space>hp` | Preview hunk |
| `<Space>hb` | Blame line |
| `<Space>hd` | Diff this |

---

## 📝 Editing

### Commenting
| Key | Action |
|-----|--------|
| `gcc` | Comment/uncomment line |
| `gc` (visual) | Comment/uncomment selection |
| `gbc` | Block comment |

### Surrounding (nvim-surround)
| Key | Action | Example |
|-----|--------|---------|
| `ys{motion}{char}` | Surround | `ysiw"` - surround word with quotes |
| `cs{old}{new}` | Change surround | `cs"'` - change " to ' |
| `ds{char}` | Delete surround | `ds"` - remove quotes |

Examples:
- `ysiw"` - surround word with quotes
- `yss)` - surround line with parentheses
- `cs"'` - change double quotes to single quotes
- `ds{` - delete curly braces

### Visual Mode
| Key | Action |
|-----|--------|
| `<` | Indent left (keeps selection) |
| `>` | Indent right (keeps selection) |
| `J` | Move line down |
| `K` | Move line up |
| `p` | Paste without yanking |

---

## 🪟 Window Management

### Navigation
| Key | Action |
|-----|--------|
| `Ctrl+h` | Move to left window |
| `Ctrl+j` | Move to bottom window |
| `Ctrl+k` | Move to top window |
| `Ctrl+l` | Move to right window |

### Resize
| Key | Action |
|-----|--------|
| `Ctrl+Up` | Increase height |
| `Ctrl+Down` | Decrease height |
| `Ctrl+Left` | Decrease width |
| `Ctrl+Right` | Increase width |

### Splits
| Command | Action |
|---------|--------|
| `:split` or `:sp` | Horizontal split |
| `:vsplit` or `:vsp` | Vertical split |

---

## 📋 Buffer Management

| Key | Action |
|-----|--------|
| `Shift+h` | Previous buffer |
| `Shift+l` | Next buffer |
| `<Space>bd` | Delete buffer |

---

## 🔧 Diagnostics & Trouble

| Key | Action |
|-----|--------|
| `<Space>xx` | Toggle diagnostics (Trouble) |
| `<Space>xX` | Buffer diagnostics (Trouble) |
| `<Space>xl` | Location list (Trouble) |
| `<Space>xq` | Quickfix list (Trouble) |

---

## 🛠️ Utility Commands

### Quick Actions
| Key | Action |
|-----|--------|
| `<Space>w` | Save file |
| `<Space>q` | Quit |
| `<Space>Q` | Quit all without saving |
| `<Space>n` | Toggle line numbers (absolute → relative → off) |
| `Esc` | Clear search highlighting |

### Useful Commands
| Command | Action |
|---------|--------|
| `:Lazy` | Manage plugins |
| `:Mason` | Manage LSP servers |
| `:checkhealth` | Check nvim health |
| `:TSUpdate` | Update Treesitter parsers |
| `:TSInstall <lang>` | Install Treesitter parser |

---

## 🎯 Advanced Features

### Scrolling
| Key | Action |
|-----|--------|
| `Ctrl+d` | Scroll down (centered) |
| `Ctrl+u` | Scroll up (centered) |
| `n` | Next search (centered) |
| `N` | Previous search (centered) |

### Incremental Selection (Treesitter)
| Key | Action |
|-----|--------|
| `Ctrl+Space` | Start/expand selection |
| `Backspace` | Shrink selection |

---

## 📚 Learning Resources

### In Neovim
- Press `<Space>` and wait - Which-key shows available commands
- `:help <topic>` - Built-in help
- `:Telescope keymaps` - Search all keybindings

### Quick Tips
1. **Finding files**: `<Space>ff` is faster than `:e`
2. **Searching**: `<Space>fg` searches all files
3. **Code navigation**: Use `gd` to jump to definitions
4. **Hover docs**: Press `K` on any symbol
5. **Autocomplete**: Type and suggestions appear automatically
6. **Comment code**: `gcc` in normal, `gc` in visual
7. **File explorer**: `<Space>e` toggles, `→/←` to navigate

---

## 🎨 Customization

### Add More LSP Servers
```vim
:Mason
# Navigate and press 'i' to install
```

### Add More Languages to Treesitter
```vim
:TSInstall <language>
# Example: :TSInstall markdown
```

### Change Colorscheme
Edit `lua/plugins/nightfox.lua` and change:
```lua
vim.cmd.colorscheme("carbonfox")  -- Try: nightfox, nordfox, duskfox, etc.
```

---

## 🐛 Troubleshooting

### Plugins Not Loading?
```vim
:Lazy sync
```

### LSP Not Working?
```vim
:LspInfo          # Check LSP status
:Mason            # Install missing servers
:checkhealth lsp  # Diagnose issues
```

### Completion Not Working?
```vim
:checkhealth nvim-cmp
```

---

## ⚙️ Line Numbers

**Default:** Absolute line numbers (1, 2, 3...)

**Toggle:** Press `<Space>n` to cycle through modes:
1. **Absolute** → `1, 2, 3, 4...` (default - best for most use)
2. **Relative** → `3, 2, 1, 0 (cursor), 1, 2, 3...` (for vim motions like `5j`)
3. **Off** → No line numbers (clean view)

**Recommendation:** Keep it on **absolute** (default) unless you:
- Use relative for vertical navigation (`5j`, `3k`, `d7j`)
- Turn off for presentations or focus mode

---

## 🎓 Common Workflows

### Editing a Project
1. `cd ~/project`
2. `nvim .`
3. `<Space>ff` - Find file to edit
4. `<Space>fg` - Search for text
5. `<Space>e` - Browse file tree

### Code Navigation
1. Hover over symbol: `K`
2. Go to definition: `gd`
3. Find references: `gr`
4. Rename: `<Space>rn`

### Git Workflow
1. Make changes
2. `<Space>hp` - Preview changes
3. `<Space>hs` - Stage hunks
4. `<Space>hb` - Check who changed this line

---

## 📖 Cheat Sheet

**Most Used Commands:**
```
Space+e     = File tree
Space+ff    = Find files
Space+fg    = Search in files
Space+w     = Save
Space+q     = Quit
Space+n     = Toggle line numbers
gcc         = Comment line
gd          = Go to definition
K           = Hover docs
Ctrl+Space  = Trigger completion
Esc         = Clear search
```

**Remember:** Press `Space` and wait to see available commands!

---

*Generated for nisrael's dotfiles - CachyOS/Arch setup*
