#!/bin/bash
# Automatically switch Alacritty theme based on macOS appearance

CONFIG_DIR="$HOME/.config/alacritty"
COMMON_CONFIG="$CONFIG_DIR/common.toml"

# Get mode from argument (passed by dark-notify) or check system
if [ -n "$1" ]; then
    MODE="$1"
else
    # Fallback: check current macOS appearance
    if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -q "Dark"; then
        MODE="dark"
    else
        MODE="light"
    fi
fi

# Select theme based on mode
if [ "$MODE" = "dark" ]; then
    THEME="carbonfox"
else
    THEME="dayfox"
fi

# Update the theme import in common.toml
sed -i.bak "s|\"themes/.*\.toml\"|\"themes/${THEME}.toml\"|" "$COMMON_CONFIG"

echo "Switched Alacritty theme to: $THEME (mode: $MODE)"
