# Neovim Configuration

A minimal Neovim configuration using lazy.nvim plugin manager.

## Structure

```
~/.config/nvim/
├── init.lua                    # Entry point - bootstraps lazy.nvim and loads plugins
├── lua/
│   └── plugins/
│       └── nightfox.lua        # Nightfox colorscheme configuration
└── pack/plugins/opt/
    └── nightfox.nvim/          # Nightfox theme (git submodule)
```

## Leader Key

- Leader: `<Space>`
- Local Leader: `\`

## Basic Settings

- Line numbers enabled
- Mouse support enabled
- Smart case-insensitive search
- System clipboard integration
- True color support

## Adding Plugins

To add a new plugin, create a new file in `lua/plugins/`:

**Example: `lua/plugins/telescope.lua`**
```lua
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",  -- Lazy-load on command
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    },
  },
}
```

Lazy.nvim will automatically detect and load all plugin files in `lua/plugins/`.

## Managing Plugins

- `:Lazy` - Open lazy.nvim UI
- `:Lazy sync` - Install/update/clean plugins
- `:Lazy update` - Update plugins
- `:Lazy clean` - Remove unused plugins

## Next Steps

Start simple and add plugins as you need them:

1. **File Navigation**: nvim-tree.lua or oil.nvim
2. **Fuzzy Finding**: telescope.nvim or fzf-lua
3. **LSP**: nvim-lspconfig + mason.nvim
4. **Completion**: nvim-cmp or blink.cmp
5. **Syntax**: nvim-treesitter
6. **Git**: gitsigns.nvim or vim-fugitive

## Learning Resources

- `:help lazy.nvim`
- https://lazy.folke.io
- https://github.com/LazyVim/LazyVim (full-featured starter config)
