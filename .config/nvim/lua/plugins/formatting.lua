return {
  -- Formatting with conform.nvim
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        -- Web Development
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        mdx = { "prettier" },
        graphql = { "prettier" },
        handlebars = { "prettier" },
        astro = { "prettier" },
        svelte = { "prettier" },
        
        -- Systems Languages
        lua = { "stylua" },
        python = { "isort", "black" },
        rust = { "rustfmt" },
        go = { "goimports", "gofmt" },
        
        -- Shell
        sh = { "shfmt" },
        bash = { "shfmt" },
        
        -- Config files
        toml = { "taplo" },
        
        -- Use LSP formatting for others
        ["_"] = { "trim_whitespace" },
      },
      
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
      },
      
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
    },
  },

  -- Mason tool installer (for formatters and linters)
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- Formatters
          "prettier",      -- JS/TS/CSS/HTML/JSON/YAML/Markdown
          "stylua",        -- Lua
          "black",         -- Python
          "isort",         -- Python imports
          "shfmt",         -- Shell scripts
          "taplo",         -- TOML
          
          -- Linters (additional to LSP)
          "eslint_d",      -- Fast ESLint
          "shellcheck",    -- Shell script linter
          
          -- Note: rustfmt and gofmt come with rust/go toolchains
        },
        auto_update = false,
        run_on_start = true,
      })
    end,
  },
}
