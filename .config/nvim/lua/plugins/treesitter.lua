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
        -- Core
        "lua", "vim", "vimdoc", "query",
        
        -- Web
        "javascript", "typescript", "tsx", "html", "css",
        
        -- Systems
        "c", "cpp", "rust", "go", "zig",
        
        -- Scripting
        "python", "ruby", "elixir", "bash", "fish",
        
        -- Config/Data
        "json", "yaml", "toml", "xml", "ini",
        
        -- Markup
        "markdown", "markdown_inline", "latex",
        
        -- DevOps/Containers
        "dockerfile", "make", "cmake",
        
        -- Git
        "git_config", "git_rebase", "gitcommit", "gitignore", "diff",
        
        -- Other
        "arduino", "java", "sql", "regex",
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
