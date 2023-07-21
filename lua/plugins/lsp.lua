return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    -- lazy=false,
    cmd = "LspStart",
    keys = {
      { "<leader>ll", "<cmd>LspStart<cr>",   desc = "Start lsp" },
      { "<leader>li", "<cmd>LspInfo<cr>",    desc = "lsp info" },
      { "<leader>lL", "<cmd>LspRestart<cr>", desc = "Restart lsp" },
    },
    dependencies = {
      { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "SmiteshP/nvim-navbuddy",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      local servers = {
        lua_ls = {
          lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
            },
          },
          checkThirdParty = false,
        },
        marksman = {},
        html = {},
        clangd = {},
        grammarly = {
          grammarly = {
            config = {
              documentDomain = "academic",
            },
          },
        },
        texlab = {
          texlab = {
            build = {
              forwardSearchAfter = true,
            },
            forwardSearch = {
              executable = "Sioyek",
              args = {
                "--reuse-window",
                "--execute-command",
                "toggle_synctex", -- Open Sioyek in synctex mode.
                "--inverse-search",
                [[nvim --server ]] .. vim.v.servername .. [[ --remote-send ":e %%%1<cr>:%%%2<cr>"]],
                -- [[nvim --server ]] .. vim.v.servername .. [[ --remote-send ":%%%2<cr>"]],
                "--forward-search-file",
                "%f",
                "--forward-search-line",
                "%l",
                "%p",
              },
            },
            chktex = {
              onOpenAndSave = true,
              onEdit = false,
            },
            bibtexFormatter = "texlab",
            latexFormatter = "texlab",
            formatterLineLength = 80,
          },
        },
      }
      require("fidget").setup()
      -- require("lspsaga").setup()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
        handlers = {
          function(server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup({
              capabilities = require("cmp_nvim_lsp").default_capabilities(),
              settings = servers[server_name],
            })
          end,
        },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>lm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
      require("mason-null-ls").setup({
        ensure_installed = {
          -- Opt to list sources here, when available in mason.
          "prettier",
          "markdownlint",
          "stylua",
          "latexindent",
        },
        automatic_installation = true,
        handlers = {},
      })
      require("null-ls").setup({
        sources = {
          -- Anything not supported by mason.
        },
      })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPost", "BufNewFile" }, dependencies = {
      "jay-babu/mason-null-ls.nvim",   
    },
    config = true,  
  },
}
