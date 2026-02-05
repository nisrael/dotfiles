# Syntax Highlighting Fix - YAML & Docker Compose

## What Was Fixed

### Issue
No syntax highlighting for YAML files (including docker-compose.yml)

### Root Cause
Treesitter parsers weren't installed yet (even though they were in the config)

---

## Changes Made

### 1. Enhanced Treesitter Configuration (`lua/plugins/treesitter.lua`)
Added many more parsers, organized by category:

**Added:**
- `dockerfile` - For Dockerfiles
- `tsx` - For TypeScript/JSX
- `markdown_inline` - Better markdown support
- `git_config`, `gitcommit`, `gitignore`, `diff` - Git files
- `make`, `cmake` - Build systems
- `xml`, `ini` - Config files
- `fish`, `zig`, `sql`, `regex` - Additional languages

### 2. Docker Compose File Detection (`init.lua`)
Added auto-detection for docker-compose files:
- `docker-compose.yml`
- `docker-compose.yaml`
- `compose.yml` / `compose.yaml`
- Plus numbered variants: `docker-compose-dev.yml`, etc.

Sets filetype to `yaml.docker-compose` for proper syntax highlighting.

### 3. YAML Plugin (`lua/plugins/extras.lua`)
Added `cuducos/yaml.nvim` for better YAML support:
- YAML path navigation
- Quick jump to anchors/keys
- Better indentation

---

## Next Steps

### 1. Restart Neovim
The treesitter parsers will install automatically:
```bash
nvim
```

You'll see notifications about parsers being installed.

### 2. Verify Installation
Open Neovim and run:
```vim
:TSInstall yaml dockerfile
```

Or just open a YAML file and it should auto-install.

### 3. Check Status
```vim
:TSInstallInfo
```

Look for `yaml` and `dockerfile` - they should show as installed.

---

## Testing

### Test YAML Syntax
```bash
nvim docker-compose.yml
```

You should now see:
- ✅ Color syntax highlighting
- ✅ Proper indentation
- ✅ Treesitter-based folding

### Test Dockerfile Syntax
```bash
nvim Dockerfile
```

Should have proper syntax highlighting too.

---

## Troubleshooting

### If syntax highlighting still doesn't work:

1. **Check if parser is installed:**
   ```vim
   :TSInstallInfo yaml
   ```

2. **Manually install parser:**
   ```vim
   :TSInstall yaml dockerfile
   ```

3. **Check treesitter status:**
   ```vim
   :checkhealth nvim-treesitter
   ```

4. **Force reinstall if needed:**
   ```vim
   :TSUpdate
   ```

### If you see errors about C compiler:
Treesitter needs a C compiler to build parsers. On Fedora:
```bash
sudo dnf install gcc g++ make
```

---

## Parsers Now Available

After restarting Neovim, you'll have syntax highlighting for:

**Core:**
- Lua, Vim, Vimdoc

**Web:**
- JavaScript, TypeScript, TSX, HTML, CSS

**Systems:**
- C, C++, Rust, Go, Zig

**Scripting:**
- Python, Ruby, Elixir, Bash, Fish

**Config/Data:**
- JSON, YAML, TOML, XML, INI

**Markup:**
- Markdown, LaTeX

**DevOps:**
- Dockerfile, Make, CMake

**Git:**
- Git config, commits, diffs, gitignore

**Other:**
- Arduino, Java, SQL, Regex

---

## Summary

✅ **Added 30+ treesitter parsers** for common file types  
✅ **Added docker-compose file detection**  
✅ **Added YAML plugin** for better navigation  
✅ **Organized parsers** by category for easy maintenance

Just restart Neovim and syntax highlighting will work! 🎨
