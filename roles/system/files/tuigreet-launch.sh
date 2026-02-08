#!/bin/sh
# tuigreet launcher with carbonfox VT console palette

# Set Linux console color palette (carbonfox)
# Normal colors (0-7)
printf '\033]P0161616'   # black (carbonfox background)
printf '\033]P1ee5396'   # red
printf '\033]P225be6a'   # green
printf '\033]P308bdba'   # yellow
printf '\033]P478a9ff'   # blue
printf '\033]P5be95ff'   # magenta
printf '\033]P633b1ff'   # cyan
printf '\033]P7f2f4f8'   # white (carbonfox foreground)

# Bright colors (8-F)
printf '\033]P8282828'   # bright black
printf '\033]P9f16da6'   # bright red
printf '\033]PA46c880'   # bright green
printf '\033]PB2dc7c4'   # bright yellow
printf '\033]PC8cb6ff'   # bright blue
printf '\033]PDc8a5ff'   # bright magenta
printf '\033]PE52bdff'   # bright cyan
printf '\033]PFe4e4e5'   # bright white
clear

exec tuigreet \
    --time \
    --remember \
    --remember-session \
    --asterisks \
    --width 80 \
    --window-padding 1 \
    --container-padding 2 \
    --prompt-padding 1 \
    --greet-align center \
    --sessions /usr/share/wayland-sessions \
    --theme 'border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=dark_gray;input=red'
