# Carbonfox Wallpapers

A collection of stylish, dark wallpapers designed to match the carbonfox colorscheme.

## Color Palette

Based on the IBM Carbon design system and nightfox carbonfox variant:
- Background: `#161616` (dark charcoal)
- Mantle: `#0e0e0e` (deeper black)
- Blue: `#78A9FF` (bright blue)
- Cyan: `#33B1FF`, `#08BDBA`, `#3DDBD9` (various teals/cyans)
- Purple: `#BE95FF` (lavender)
- Pink: `#FF7EB6` (rose)
- Green: `#25be6a` (emerald)

## Available Wallpapers

1. **solid.png** - Pure carbonfox background color
2. **gradient-subtle.png** - Subtle dark gradient
3. **textured-dark.png** - Textured dark gradient with noise
4. **blurred-orbs.png** - Soft glowing blue/cyan orbs
5. **diagonal-blue.png** - Diagonal blue gradient
6. **grid-minimal.png** - Minimalist grid pattern
7. **soft-glow.png** - Multiple soft glowing elements
8. **circles-abstract.png** - Abstract circle outlines
9. **plasma-dark.png** - Dark plasma fractal
10. **corner-glow.png** - Subtle corner lighting
11. **triangles.png** - Geometric triangles
12. **noise-subtle.png** - Subtle noise texture

## Usage

### Change Wallpaper

```bash
# Set random wallpaper
carbonfox-wallpaper random

# Cycle to next wallpaper
carbonfox-wallpaper next

# Set specific wallpaper
carbonfox-wallpaper soft-glow.png

# List available wallpapers
carbonfox-wallpaper list
```

### Keybindings

- **Super + W** - Cycle to next wallpaper

### Automatic Rotation

The wallpaper is set randomly on each Wayfire startup. To enable automatic
rotation during your session, you can add a systemd timer or cron job:

```bash
# Example: Change wallpaper every hour
systemctl --user edit --force --full carbonfox-wallpaper.timer
```

Add:
```ini
[Unit]
Description=Carbonfox Wallpaper Rotation Timer

[Timer]
OnBootSec=5min
OnUnitActiveSec=1h

[Install]
WantedBy=timers.target
```

And create the service:
```bash
systemctl --user edit --force --full carbonfox-wallpaper.service
```

Add:
```ini
[Unit]
Description=Carbonfox Wallpaper Rotation

[Service]
Type=oneshot
ExecStart=%h/.local/bin/carbonfox-wallpaper random
```

Then enable:
```bash
systemctl --user enable --now carbonfox-wallpaper.timer
```

## Recommendations

My favorites for different moods:
- **Focus work**: `gradient-subtle.png` or `solid.png`
- **Creative work**: `soft-glow.png` or `blurred-orbs.png`
- **Minimal**: `grid-minimal.png` or `corner-glow.png`
- **Artistic**: `plasma-dark.png` or `circles-abstract.png`
