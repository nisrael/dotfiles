return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- Disable netrw
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

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
        dotfiles = false,  -- Show dotfiles by default (was true)
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
  end,
}
