return {
  -- PlatformIO integration
  {
    "anurag3301/nvim-platformio.lua",
    dependencies = {
      { "akinsho/nvim-toggleterm.lua" },
      { "nvim-telescope/telescope.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
    lazy = true, -- Only load when PIO commands are used
    cmd = { "PIOInit", "PIOBuild", "PIOUpload", "PIOMonitor", "PIOClean", "PIOTest", "PIODebug" },
    ft = { "c", "cpp", "arduino" }, -- Load for C/C++/Arduino files
    config = function()
      -- Check if platformio is installed
      if vim.fn.executable("pio") == 0 then
        vim.notify("PlatformIO CLI not found. Install with: pip install platformio", vim.log.levels.WARN)
        return
      end
      
      require("platformio").setup({
        -- PlatformIO CLI path (auto-detected)
        platformio_cli = "pio",
      })
      
      -- Keymaps for PlatformIO commands
      vim.keymap.set('n', '<leader>pb', ':PIOBuild<CR>', { desc = 'PlatformIO: Build' })
      vim.keymap.set('n', '<leader>pu', ':PIOUpload<CR>', { desc = 'PlatformIO: Upload' })
      vim.keymap.set('n', '<leader>pm', ':PIOMonitor<CR>', { desc = 'PlatformIO: Serial Monitor' })
      vim.keymap.set('n', '<leader>pc', ':PIOClean<CR>', { desc = 'PlatformIO: Clean' })
      vim.keymap.set('n', '<leader>pi', ':PIOInit<CR>', { desc = 'PlatformIO: Initialize' })
      vim.keymap.set('n', '<leader>pt', ':PIOTest<CR>', { desc = 'PlatformIO: Test' })
      vim.keymap.set('n', '<leader>pd', ':PIODebug<CR>', { desc = 'PlatformIO: Debug' })
      vim.keymap.set('n', '<leader>pp', ':Telescope platformio commands<CR>', { desc = 'PlatformIO: Commands' })
    end,
  },

  -- ToggleTerm for terminal management
  {
    "akinsho/nvim-toggleterm.lua",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<C-\>]],
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
        },
      })

      -- Keymaps for terminal
      vim.keymap.set('n', '<leader>tf', ':ToggleTerm direction=float<CR>', { desc = 'Toggle floating terminal' })
      vim.keymap.set('n', '<leader>th', ':ToggleTerm direction=horizontal<CR>', { desc = 'Toggle horizontal terminal' })
      vim.keymap.set('n', '<leader>tv', ':ToggleTerm direction=vertical<CR>', { desc = 'Toggle vertical terminal' })
      
      -- Terminal mode escape
      vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], { desc = 'Move to left window' })
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], { desc = 'Move to bottom window' })
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], { desc = 'Move to top window' })
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], { desc = 'Move to right window' })
    end,
  },
}
