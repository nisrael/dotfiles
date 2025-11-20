#!/bin/bash
# Automatically switch Alacritty theme based on macOS appearance

CONFIG_DIR="$HOME/.config/alacritty"
COMMON_CONFIG="$CONFIG_DIR/common.toml"

# Check current macOS appearance
if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -q "Dark"; then
    THEME="carbonfox"
else
    THEME="dayfox"
fi

# Update the theme import in common.toml
sed -i.bak "s|\"themes/.*\.toml\"|\"themes/${THEME}.toml\"|" "$COMMON_CONFIG"

echo "Switched Alacritty theme to: $THEME"
