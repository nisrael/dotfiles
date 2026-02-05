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
vim.opt.number = true              -- Show absolute line numbers
vim.opt.relativenumber = false     -- Disable relative line numbers (can toggle)
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

-- Additional settings and keymaps
vim.opt.expandtab = true       -- Use spaces instead of tabs
vim.opt.shiftwidth = 2         -- Size of an indent
vim.opt.tabstop = 2            -- Number of spaces tabs count for
vim.opt.smartindent = true     -- Insert indents automatically
vim.opt.wrap = false           -- Disable line wrap
vim.opt.swapfile = false       -- No swap file
vim.opt.backup = false         -- No backup file
vim.opt.undofile = true        -- Persistent undo
vim.opt.hlsearch = true        -- Highlight search results
vim.opt.incsearch = true       -- Incremental search
vim.opt.scrolloff = 8          -- Lines of context around cursor
vim.opt.signcolumn = "yes"     -- Always show sign column
vim.opt.updatetime = 250       -- Faster completion
vim.opt.timeoutlen = 300       -- Faster key sequence completion
vim.opt.splitright = true      -- Vertical splits go to the right
vim.opt.splitbelow = true      -- Horizontal splits go below
vim.opt.cursorline = true      -- Highlight current line
vim.opt.pumheight = 10         -- Maximum number of items in popup menu
vim.opt.conceallevel = 0       -- Don't hide special characters in markdown
vim.opt.showmode = false       -- Don't show mode (lualine shows it)

-- Better search highlighting clear
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>', { desc = 'Clear search highlighting' })

-- Toggle line numbers (cycles: absolute → relative → off → absolute)
vim.keymap.set('n', '<leader>n', function()
  if vim.opt.number:get() and not vim.opt.relativenumber:get() then
    -- Currently absolute, switch to relative
    vim.opt.relativenumber = true
    print("Line numbers: relative")
  elseif vim.opt.number:get() and vim.opt.relativenumber:get() then
    -- Currently relative, switch to off
    vim.opt.number = false
    vim.opt.relativenumber = false
    print("Line numbers: off")
  else
    -- Currently off, switch to absolute
    vim.opt.number = true
    vim.opt.relativenumber = false
    print("Line numbers: absolute")
  end
end, { desc = 'Toggle line numbers (absolute/relative/off)' })

-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to top window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Resize windows with arrows
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Increase window width' })

-- Better indenting in visual mode
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })

-- Move lines up/down in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })

-- Better paste in visual mode (doesn't replace clipboard)
vim.keymap.set('v', 'p', '"_dP', { desc = 'Paste without yanking' })

-- Quick save
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save file' })

-- Quick quit
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>Q', ':qa!<CR>', { desc = 'Quit all without saving' })

-- Buffer navigation
vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = 'Delete buffer' })

-- Keep cursor centered when scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result and center' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result and center' })

-- Auto-commands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Detect docker-compose files as yaml
autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup('DockerCompose', {}),
  pattern = { "docker-compose*.yml", "docker-compose*.yaml", "compose*.yml", "compose*.yaml" },
  callback = function()
    vim.bo.filetype = "yaml.docker-compose"
  end,
})

-- Detect GitLab CI files
autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup('GitLabCI', {}),
  pattern = { ".gitlab-ci.yml", ".gitlab-ci.yaml", "*.gitlab-ci.yml", "*.gitlab-ci.yaml" },
  callback = function()
    vim.bo.filetype = "yaml.gitlab"
  end,
})

-- Detect Forgejo/Gitea CI files
autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup('ForgejoCI', {}),
  pattern = { ".forgejo/workflows/*.yml", ".forgejo/workflows/*.yaml", ".gitea/workflows/*.yml", ".gitea/workflows/*.yaml" },
  callback = function()
    vim.bo.filetype = "yaml.forgejo"
  end,
})

-- Highlight on yank
autocmd('TextYankPost', {
  group = augroup('HighlightYank', {}),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 200,
    })
  end,
})

-- Remove trailing whitespace on save (handled by conform.nvim now)
-- Disabled in favor of conform.nvim's trim_whitespace formatter

-- Auto-format on save (now handled by conform.nvim)
-- See lua/plugins/formatting.lua for format configuration
