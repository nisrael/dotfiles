# Sublime Text Configuration

This configuration uses the nightfox color schemes (carbonfox for dark mode, dayfox for light mode).

## Theme Switching

The themes are automatically symlinked from the nightfox.nvim plugin by ansible.

To switch between dark and light themes, edit `Preferences.sublime-settings` and change:

**For dark mode (carbonfox):**
```json
"color_scheme": "carbonfox.tmTheme",
```

**For light mode (dayfox):**
```json
"color_scheme": "dayfox.tmTheme",
```

## Quick Theme Switch

You can also use Sublime Text's command palette:
1. Press `Cmd+Shift+P` (macOS) or `Ctrl+Shift+P` (Linux)
2. Type "UI: Select Color Scheme"
3. Choose `carbonfox` or `dayfox`

## Configuration Highlights

- **Font**: JetBrainsMono Nerd Font at 13pt
- **Tab size**: 2 spaces
- **Line endings**: Unix (LF)
- **Auto-save**: Disabled (hot_exit: false)
- **Telemetry**: Disabled
- **Word wrap**: Disabled by default
- **Rulers**: 80 and 120 characters
- **Excluded folders**: node_modules, __pycache__, .git, dist, build, etc.

## Managed by Ansible

This configuration is managed by ansible and stow. Do not edit the symlinked files directly.
Edit the source files in the dotfiles repository instead.
