-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Basic settings
vim.opt.number = true              -- Show line numbers
vim.opt.mouse = "a"                -- Enable mouse support
vim.opt.ignorecase = true          -- Case insensitive search
vim.opt.smartcase = true           -- Case sensitive if uppercase in search
vim.opt.termguicolors = true       -- True color support
vim.opt.clipboard = "unnamedplus"  -- Use system clipboard

-- Load plugins
require("lazy").setup("plugins", {
  change_detection = {
    notify = false,  -- Don't notify on config changes
  },
})

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')

    -- Default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- Yazi-like arrow key navigation
    vim.keymap.set('n', '<Right>', api.node.open.edit, { buffer = bufnr, desc = 'Open' })
    vim.keymap.set('n', '<Left>', api.node.navigate.parent_close, { buffer = bufnr, desc = 'Close Directory' })

    -- Toggle hidden files with .
    vim.keymap.set('n', '.', api.tree.toggle_hidden_filter, { buffer = bufnr, desc = 'Toggle hidden files' })
  end,
})

-- Keybinding to toggle nvim-tree
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
