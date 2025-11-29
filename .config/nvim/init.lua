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
