return {
  -- Task runner for build systems
  {
    "stevearc/overseer.nvim",
    config = function()
      require("overseer").setup({
        templates = { "builtin", "platformio" },
        strategy = {
          "toggleterm",
          direction = "horizontal",
          open_on_start = true,
        },
        component_aliases = {
          default = {
            { "display_duration", detail_level = 2 },
            "on_output_summarize",
            "on_exit_set_status",
            "on_complete_notify",
          },
        },
      })

      -- Keymaps for Overseer
      vim.keymap.set('n', '<leader>or', ':OverseerRun<CR>', { desc = 'Overseer: Run task' })
      vim.keymap.set('n', '<leader>ot', ':OverseerToggle<CR>', { desc = 'Overseer: Toggle' })
      vim.keymap.set('n', '<leader>oo', ':OverseerOpen<CR>', { desc = 'Overseer: Open' })
      vim.keymap.set('n', '<leader>oc', ':OverseerClose<CR>', { desc = 'Overseer: Close' })
      vim.keymap.set('n', '<leader>ol', ':OverseerLoadBundle<CR>', { desc = 'Overseer: Load bundle' })
      vim.keymap.set('n', '<leader>os', ':OverseerSaveBundle<CR>', { desc = 'Overseer: Save bundle' })
      vim.keymap.set('n', '<leader>oa', ':OverseerTaskAction<CR>', { desc = 'Overseer: Task action' })
      vim.keymap.set('n', '<leader>oq', ':OverseerQuickAction<CR>', { desc = 'Overseer: Quick action' })
      
      -- Register PlatformIO tasks
      require("overseer").register_template({
        name = "platformio build",
        builder = function()
          return {
            cmd = { "pio" },
            args = { "run" },
            components = { "default" },
          }
        end,
        condition = {
          filetype = { "c", "cpp", "arduino" },
          callback = function()
            return vim.fn.filereadable("platformio.ini") == 1
          end,
        },
      })

      require("overseer").register_template({
        name = "platformio upload",
        builder = function()
          return {
            cmd = { "pio" },
            args = { "run", "--target", "upload" },
            components = { "default" },
          }
        end,
        condition = {
          filetype = { "c", "cpp", "arduino" },
          callback = function()
            return vim.fn.filereadable("platformio.ini") == 1
          end,
        },
      })

      require("overseer").register_template({
        name = "platformio clean",
        builder = function()
          return {
            cmd = { "pio" },
            args = { "run", "--target", "clean" },
            components = { "default" },
          }
        end,
        condition = {
          filetype = { "c", "cpp", "arduino" },
          callback = function()
            return vim.fn.filereadable("platformio.ini") == 1
          end,
        },
      })

      require("overseer").register_template({
        name = "platformio test",
        builder = function()
          return {
            cmd = { "pio" },
            args = { "test" },
            components = { "default" },
          }
        end,
        condition = {
          filetype = { "c", "cpp", "arduino" },
          callback = function()
            return vim.fn.filereadable("platformio.ini") == 1
          end,
        },
      })

      require("overseer").register_template({
        name = "platformio monitor",
        builder = function()
          return {
            cmd = { "pio" },
            args = { "device", "monitor" },
            components = { "default" },
          }
        end,
        condition = {
          filetype = { "c", "cpp", "arduino" },
          callback = function()
            return vim.fn.filereadable("platformio.ini") == 1
          end,
        },
      })
    end,
  },
}
