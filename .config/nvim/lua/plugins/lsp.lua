return {
  -- Mason for LSP server management (must load first)
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason-lspconfig bridge
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- Core Languages
          "lua_ls",
          "rust_analyzer",
          "pyright",
          "elixirls",
          
          -- Web Development
          "ts_ls",           -- TypeScript/JavaScript
          "html",            -- HTML
          "cssls",           -- CSS/SCSS/LESS
          "eslint",          -- JavaScript/TypeScript linting
          "emmet_ls",        -- HTML/CSS abbreviations
          "jsonls",          -- JSON with schema support
          
          -- DevOps/Scripts
          "bashls",          -- Bash/Shell scripts
          "yamlls",          -- YAML with schema validation
          
          -- Note: clangd is installed via system package manager (dnf install clang-tools-extra)
          -- Mason doesn't support ARM64 for clangd
        },
        automatic_installation = true,
      })
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "b0o/schemastore.nvim", -- JSON schemas
    },
    config = function()
      -- Get capabilities from cmp if available, otherwise use defaults
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if has_cmp then
        capabilities = cmp_nvim_lsp.default_capabilities()
      end

      -- Keymaps (set on LspAttach for better performance)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'Go to definition' }))
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = 'Go to declaration' }))
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, { desc = 'Go to implementation' }))
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = 'Go to references' }))
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'Hover documentation' }))
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'Code action' }))
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'Rename symbol' }))
          vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, vim.tbl_extend('force', opts, { desc = 'Show diagnostic' }))
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, vim.tbl_extend('force', opts, { desc = 'Previous diagnostic' }))
          vim.keymap.set('n', ']d', vim.diagnostic.goto_next, vim.tbl_extend('force', opts, { desc = 'Next diagnostic' }))
        end,
      })

      -- Use new Neovim 0.11+ API for LSP configuration
      if vim.lsp.config then
        -- Modern API (Neovim 0.11+)
        local servers = { 
          'lua_ls', 'rust_analyzer', 'ts_ls', 'pyright', 'elixirls', 'clangd',
          'html', 'cssls', 'eslint', 'emmet_ls', 'jsonls', 'bashls', 'yamlls'
        }
        for _, server in ipairs(servers) do
          vim.lsp.config[server] = {
            capabilities = capabilities,
          }
        end
      else
        -- Fallback to lspconfig for older Neovim versions
        local lspconfig = require("lspconfig")
        
        -- Standard servers
        local servers = { 
          'lua_ls', 'rust_analyzer', 'ts_ls', 'pyright', 'elixirls', 'clangd',
          'html', 'cssls', 'bashls'
        }
        for _, server in ipairs(servers) do
          lspconfig[server].setup({
            capabilities = capabilities,
          })
        end
        
        -- ESLint with specific configuration
        lspconfig.eslint.setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            -- Enable auto-fix on save
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
            })
          end,
        })
        
        -- Emmet with HTML/CSS file types
        lspconfig.emmet_ls.setup({
          capabilities = capabilities,
          filetypes = { 
            "html", "css", "scss", "javascript", "javascriptreact", 
            "typescript", "typescriptreact", "vue", "astro", "svelte" 
          },
        })
        
        -- JSON with schema support
        lspconfig.jsonls.setup({
          capabilities = capabilities,
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        })
        
        -- YAML with schema support for CI files
        lspconfig.yamlls.setup({
          capabilities = capabilities,
          settings = {
            yaml = {
              schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "/.gitlab-ci.yml",
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "/docker-compose*.yml",
              },
              validate = true,
              completion = true,
            },
          },
        })
      end
      
      -- Note: clangd LSP is configured above, but installed via system package
      -- On Fedora: sudo dnf install clang-tools-extra
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },
}
