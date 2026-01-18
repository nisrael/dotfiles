return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local status_ok, configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      return
    end

    configs.setup({
      ensure_installed = {
        "lua", "vim", "vimdoc", "query",
        "javascript", "typescript", "python",
        "rust", "go", "elixir", "bash", "yaml",
        "json", "markdown", "html", "css",
        "c", "cpp", "java", "ruby", "toml",
      },
      sync_install = false,
      auto_install = true,
      highlight = { 
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    })
  end,
}
