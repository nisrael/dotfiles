return {
  -- Git signs in the gutter
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup({
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          -- Navigation
          vim.keymap.set('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true, buffer = bufnr, desc = 'Next hunk' })

          vim.keymap.set('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true, buffer = bufnr, desc = 'Previous hunk' })

          -- Actions
          vim.keymap.set('n', '<leader>hs', gs.stage_hunk, { buffer = bufnr, desc = 'Stage hunk' })
          vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { buffer = bufnr, desc = 'Reset hunk' })
          vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, { buffer = bufnr, desc = 'Undo stage hunk' })
          vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { buffer = bufnr, desc = 'Preview hunk' })
          vim.keymap.set('n', '<leader>hb', function() gs.blame_line({ full = true }) end, { buffer = bufnr, desc = 'Blame line' })
          vim.keymap.set('n', '<leader>hd', gs.diffthis, { buffer = bufnr, desc = 'Diff this' })
        end,
      })
    end,
  },
}
