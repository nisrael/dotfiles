# Neovim Cheatsheet

Leader = Space

## File Navigation

| Keys         | Action                       |
|--------------|------------------------------|
| `Space e`    | Toggle file tree             |
| `Space ff`   | Find files                   |
| `Space fg`   | Grep across project          |
| `Space fw`   | Grep word under cursor       |
| `Space fb`   | Switch buffers               |
| `Space fr`   | Recent files                 |
| `Space fc`   | Commands                     |
| `Space fk`   | Keymaps                      |
| `Shift-L/H`  | Next / previous buffer       |
| `Space bd`   | Close buffer                 |

## LSP / IntelliSense

| Keys         | Action                       |
|--------------|------------------------------|
| `K`          | Hover documentation          |
| `Ctrl-Space` | Trigger completion           |
| `Tab/S-Tab`  | Navigate completion menu     |
| `Enter`      | Confirm completion           |
| `gd`         | Go to definition             |
| `gD`         | Go to declaration            |
| `gr`         | Go to references             |
| `gi`         | Go to implementation         |
| `Space ca`   | Code actions                 |
| `Space rn`   | Rename symbol                |
| `Space d`    | Show diagnostic              |
| `Space f`    | Format buffer                |
| `[d / ]d`    | Prev / next diagnostic       |

## Diagnostics (Trouble)

| Keys         | Action                       |
|--------------|------------------------------|
| `Space xx`   | Toggle diagnostics panel     |
| `Space xX`   | Buffer diagnostics           |
| `Space xq`   | Quickfix list                |

## Git

| Keys         | Action                       |
|--------------|------------------------------|
| `]c / [c`    | Next / prev hunk             |
| `Space hs`   | Stage hunk                   |
| `Space hr`   | Reset hunk                   |
| `Space hp`   | Preview hunk                 |
| `Space hb`   | Blame line                   |
| `Space hd`   | Diff this                    |

## Editing

| Keys             | Action                       |
|------------------|------------------------------|
| `gcc`            | Toggle line comment          |
| `gc` (visual)    | Comment selection            |
| `ys{motion}{c}`  | Add surround                 |
| `cs{old}{new}`   | Change surround              |
| `ds{c}`          | Delete surround              |

## PlatformIO Development

| Keys         | Action                       |
|--------------|------------------------------|
| `Space pb`   | Build project                |
| `Space pu`   | Upload to device             |
| `Space pm`   | Serial monitor               |
| `Space pc`   | Clean build files            |
| `Space pt`   | Run tests                    |
| `Space pp`   | Show all PIO commands        |
| `Space or`   | Run task (with picker)       |
| `Space ot`   | Toggle task output           |

## Terminal

| Keys         | Action                       |
|--------------|------------------------------|
| `Ctrl-\`     | Toggle terminal              |
| `Space tf`   | Floating terminal            |
| `Space th`   | Horizontal terminal          |
| `Space tv`   | Vertical terminal            |
| `Esc` (term) | Exit terminal mode           |

## General

| Keys           | Action                       |
|----------------|------------------------------|
| `Space w`      | Save                         |
| `Space q`      | Quit                         |
| `Space Q`      | Quit all (no save)           |
| `Space n`      | Toggle line numbers          |
| `Ctrl-h/j/k/l` | Move between splits         |
| `Ctrl-d/u`     | Scroll down/up (centered)    |
| `Esc`          | Clear search highlight       |
| `< / >`        | Indent (visual, reselects)   |

> Tip: Press Space and wait 300ms for which-key popup
