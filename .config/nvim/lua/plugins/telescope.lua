return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        file_ignore_patterns = { "node_modules", ".git/", "%.lock" },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    })
    telescope.load_extension('fzf')

    -- Keymaps
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
    vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent files' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find word under cursor' })
    vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Find commands' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find keymaps' })
  end,
}
