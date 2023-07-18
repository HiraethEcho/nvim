return {
  {
    "neovim/nvim-lspconfig",
    -- event = { "BufReadPre", "BufNewFile" },
    -- lazy=false,
    cmd="LspStart",
    keys={
      { "<leader>ll", "<cmd>LspStart<cr>", desc = "Start lsp" },
      { "<leader>li", "<cmd>LspInfo<cr>", desc = "lsp info" },
      { "<leader>lL", "<cmd>LspRestart<cr>", desc = "Restart lsp" },
    },
    dependencies = {
     { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "SmiteshP/nvim-navbuddy",
      -- "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      -- local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- local lsp_defaults = require('lspconfig').util.default_config
      require'lspconfig'.texlab.setup{
        settings = {
          texlab = {
            build = {
              forwardSearchAfter = true,
            },
            forwardSearch = {
              executable = 'Sioyek',
              args = {
                '--reuse-window',
                '--execute-command', 'toggle_synctex', -- Open Sioyek in synctex mode.
                '--inverse-search',
                [[nvim --server ]] .. vim.v.servername .. [[ --remote-send ":e %%%1<cr>:%%%2<cr>"]],
                '--forward-search-file', '%f',
                '--forward-search-line', '%l', '%p'
              },
            },
            chktex = {
              onOpenAndSave = true,
              onEdit = false,
            },
            bibtexFormatter = 'texlab',
            latexFormatter = 'texlab',
            formatterLineLength = 80,
          },
        },
      }
      require'lspconfig'.grammarly.setup{
        filetypes = {'tex','plaintex','markdown'},
        settings = {
          grammarly = {
            config = {
              documentDomain = "academic",
            }
          }

        }
      }
      require'lspconfig'.lua_ls.setup{
        settings={
          lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {'vim'},
            },
          },
          checkThirdParty = false,
        },
      }
      -- require'lspconfig'.ltex.setup{
      --   settings={
      --     ltex = {
      --       enabled = { "latex", "tex", "bib", "markdown" },
      --       language = "en",
      --       diagnosticSeverity = "information",
      --       setenceCacheSize = 2000,
      --       additionalRules = {
      --         enablePickyRules = true,
      --         motherTongue = "en",
      --       },
      --       trace = { server = "verbose" },
      --       dictionary = {},
      --       disabledRules = {},
      --       hiddenFalsePositives = {},
      --     },
      --   },
      -- }
      -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- local lsp_defaults = require('lspconfig').util.default_config
      local servers = {
        "html",
        "yamlls",
        -- "typst_lsp",
        "marksman",
        "clangd",
      }
      for _, lsp in pairs(servers) do
        require'lspconfig'[lsp].setup({
          on_attach = on_attach,
        })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    -- lazy=false,
    cmd = "Mason",
    keys = { { "<leader>lm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate" ,-- :MasonUpdate updates registry contents
    opts = {
      ensure_installed = {
        -- "flake8",
        "texlab",
        "grammarly-languageserver",
        "lua-language-server",
        "clangd",
        "marksman",
        "ltex-ls",
        "html-lsp",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    -- lazy=false,
    config=function()
      require("mason-lspconfig").setup()
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          nls.builtins.formatting.fish_indent,
          nls.builtins.diagnostics.fish,
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,
          -- nls.builtins.diagnostics.flake8,
        },
      }
    end,
  },
}
