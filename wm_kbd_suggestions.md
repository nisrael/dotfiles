# Window Manager Keybinding Comparison & Suggestions

## Comparison

| Function | Wayfire | Sway | Difference |
|---|---|---|---|
| **Terminal** | `Super+Enter` → alacritty | `Super+Enter` → foot | Same key, different app |
| **App launcher** | `Super` → rofi | `Super+d` → wmenu-run | Different key & app |
| **Kill window** | (not bound) | `Super+Shift+q` | Missing in Wayfire |
| **Reload config** | (not bound) | `Super+Shift+c` | Missing in Wayfire |
| **Exit session** | (not bound) | `Super+Shift+e` → swaynag | Missing in Wayfire |
| **Workspaces 1-8** | `Ctrl+Alt+1-8` | `Super+1-0` | Different modifier |
| **Move win to ws** | `Super+Alt+1-8` | `Super+Shift+1-0` | Different modifier |
| **Focus direction** | (not bound) | `Super+h/j/k/l` or arrows | Missing in Wayfire |
| **Move window** | `Super+LMB` (drag) | `Super+Shift+h/j/k/l` + floating_modifier | Wayfire mouse-only |
| **Resize window** | `Super+RMB` | `Super+r` (resize mode) | Different approach |
| **Maximize/Fullscreen** | `Super+Up` (maximize) | `Super+f` (fullscreen) | Different key & behavior |
| **Restore** | `Super+Down` | (not bound) | Missing in Sway |
| **Snap left/right/etc** | `Super+Alt+arrows` | (not bound) | Missing in Sway |
| **Split h/v** | (not bound) | `Super+b` / `Super+v` | Missing in Wayfire |
| **Layout switch** | (not bound) | `Super+s/w/e` | Missing in Wayfire |
| **Float toggle** | (not bound) | `Super+Shift+Space` | Missing in Wayfire |
| **Focus float/tile** | (not bound) | `Super+Space` | Missing in Wayfire |
| **Scratchpad** | (not bound) | `Super+Shift+-` / `Super+-` | Missing in Wayfire |
| **Alt-Tab** | `Alt+Tab` | (not bound) | Missing in Sway |
| **Volume** | media keys → volumectl | media keys → pactl | Same keys, different tool |
| **Brightness** | media keys → lightctl | media keys → brightnessctl | Same keys, different tool |
| **Screenshot** | (not bound) | `Print` → grim | Missing in Wayfire |
| **File manager** | `Super+e` → nautilus | (not bound) | Missing in Sway |
| **Idle toggle** | `Super+z` | (not bound) | Missing in Sway |
| **Clipboard/Emoji/etc** | `Ctrl+Alt+P/E/R/W/B` | (not bound) | Missing in Sway |
| **Kbd backlight** | `Shift+F1/F2` | (not bound) | Missing in Sway |
| **Scale presets** | `Ctrl+Super+1-4` | (not bound) | Missing in Sway |

## Suggestions

Adopt the Wayfire conventions as the "source of truth" since that's the established setup, and update the sway config to match:

1. **Terminal**: Change to `alacritty` (or whichever is preferred — Wayfire uses alacritty, sway uses foot)
2. **Launcher**: Bind `Super` alone isn't possible in sway, so keep `Super+d` but switch to rofi
3. **Workspaces**: Change sway from `Super+1-8` to `Ctrl+Alt+1-8` to match Wayfire
4. **Move to workspace**: Change from `Super+Shift+1-8` to `Super+Alt+1-8`
5. **Volume/Brightness**: Switch sway from pactl/brightnessctl to volumectl/lightctl to match Wayfire
6. **Add missing bindings** to sway: file manager (`Super+e`), idle toggle (`Super+z`), clipboard (`Ctrl+Alt+p`), emoji (`Ctrl+Alt+e`), history (`Ctrl+Alt+r`), wifi (`Ctrl+Alt+w`), bluetooth (`Ctrl+Alt+b`), kbd backlight (`Shift+F1/F2`)
7. **Keep sway-specific bindings** that don't conflict: `Super+Shift+q` (kill), `Super+Shift+c` (reload), `Super+Shift+e` (exit), `Super+b/v` (split), `Super+s/w/e` (layouts), `Super+f` (fullscreen), `Super+Shift+Space` (float), scratchpad, resize mode
