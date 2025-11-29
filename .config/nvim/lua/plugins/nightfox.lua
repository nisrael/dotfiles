-- Nightfox colorscheme
return {
  {
    -- Use local submodule instead of downloading from GitHub
    dir = vim.fn.stdpath("config") .. "/pack/plugins/opt/nightfox.nvim",
    lazy = false,    -- Load immediately, not lazy-loaded
    priority = 1000, -- Load before other plugins
    config = function()
      -- Set colorscheme
      vim.cmd.colorscheme("carbonfox")
    end,
  },
}
