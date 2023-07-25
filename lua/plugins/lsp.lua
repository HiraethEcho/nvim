return {
  {
    "neovim/nvim-lspconfig",
    -- event = { "BufReadPost", "BufNewFile" },
    -- lazy=false,
    cmd = "LspStart",
    keys = {
      { "<leader>ll", "<cmd>LspStart<cr>",   desc = "Start lsp" },
      { "<leader>li", "<cmd>LspInfo<cr>",    desc = "lsp info" },
      { "<leader>lL", "<cmd>LspRestart<cr>", desc = "Restart lsp" },
    },
    dependencies = {
      { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
      "jose-elias-alvarez/null-ls.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "SmiteshP/nvim-navbuddy",
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
      }
      require("fidget").setup()
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
      require("lspconfig").texlab.setup({
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        settings = {
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
            latexFormatter = "latexindent",
            formatterLineLength = 80,
          },
        },
        on_attach = function(client, bufnr)
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "<cr><cr>", "<cmd>TexlabBuild<cr>", bufopts)
          vim.keymap.set("n", "<cr>", "<cmd>TexlabForward<cr>", bufopts)
        end,
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
          -- "stylua",
          "latexindent",
        },
        automatic_installation = true,
        -- handlers = {},
      })
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua.with({ extra_args = { "--indent_type", "Spaces", "indent_width", "2" },
          }),
          -- null_ls.builtins.code_actions.gitsigns,
      -- null_ls.builtins.diagnostics.textidote,
          -- null_ls.builtins.hover.dictionary,
        },
      })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "jay-babu/mason-null-ls.nvim",
    },
    config = true,
  },
}
