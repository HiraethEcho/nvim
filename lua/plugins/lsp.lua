return {
  {
    "neovim/nvim-lspconfig",
    -- event = { "BufReadPost", "BufNewFile" },
    enabled =false,
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
      -- "hrsh7th/cmp-nvim-lsp",
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
        prosemd_lsp = {},
        bashls = {},
        -- latexindent = {},
        html = {},
        clangd = {},
      }
      require("fidget").setup()
      -- require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
        handlers = {
          function(server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup({
              -- capabilities = require("cmp_nvim_lsp").default_capabilities(),
              settings = servers[server_name],
            })
          end,
        },
      })
      require("lspconfig").texlab.setup({
        -- capabilities = require("cmp_nvim_lsp").default_capabilities(),
        settings = {
          texlab = {
            build = {
              forwardSearchAfter = true,
            },
            forwardSearch = {
              executable = "sioyek",
              args = {
                "--reuse-window",
                "--execute-command", "toggle_synctex", -- Open Sioyek in synctex mode.
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
            latexindent = {
              indent = 2,
            },
            formatterLineLength = 80,
          },
        },
        on_attach = function(client, bufnr)
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "<cr><cr>", "<cmd>TexlabBuild<cr>", bufopts)
          vim.keymap.set("n", "<cr>", "<cmd>TexlabForward<cr>", bufopts)
        end,
      })
      require("lspconfig").grammarly.setup({
        filetypes = { "markdown", "tex", "plaintex" },
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        settings = {
          grammarly = {},
        },
        on_attach = on_attach,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = {
      { "<leader>lm", "<cmd>Mason<cr>", desc = "Mason" },
    },
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      -- { "nvim-treesitter/nvim-treesitter" },
      "neovim/nvim-lspconfig",
    },
    keys = {
      -- { "K", "<cmd>Lspsaga hover_doc<cr>", desc = "hover doc" },
      { "<leader>lo", "<cmd>Lspsaga outline<cr>",                    desc = "lsp outline" },
      { "<leader>la", "<cmd>Lspsaga code_action<cr>",                desc = "lsp code_action" },
      { "<leader>ld", "<cmd>Lspsaga show_buf_diagnostics<cr>",       desc = "lsp buff diagnostic" },
      { "<leader>lD", "<cmd>Lspsaga show_workspace_diagnostics<cr>", desc = "lsp workspace diagnostic" },
      { "<leader>lf", "<cmd>Lspsaga finder<cr>",                     desc = "lsp finder" },
      { "<leader>lF", ":lua vim.lsp.buf.format()<cr>",               desc = "lsp formart" },
      { "gp",         "<cmd>Lspsaga peek_definition<cr>",            desc = "lsp peek definition" },
      { "gd",         "<cmd>Lspsaga goto_definition<cr>",            desc = "go to definition" },
      { "[d",         "<cmd>Lspsaga diagnostic_jump_prev<cr>",       desc = "previous diagnostic" },
      { "]d",         "<cmd>Lspsaga diagnostic_jump_next<cr>",       desc = "next diagnostic" },
    },
    config = function()
      require("lspsaga").setup({
        scroll_preview = {
          scroll_down = "<C-u>",
          scroll_up = "<C-d>",
        },
        finder = {
          keys = {
            jump_to = "p",
            expand_or_jump = "<cr>",
            vsplit = "v",
            split = "s",
            tabe = "t",
            tabnew = "r",
            quit = { "q", "<ESC>" },
            close_in_preview = "<ESC>",
          },
        },
        outline = {
          keys = {
            expand_or_jump = "<cr>",
            quit = "q",
            jump = "<space>"
          },
        },
        lightbulb = {
          enable = false,
        },
        symbol_in_winbar = {
          enable = true,
          show_file = false,
          folder_level = 5,
          color_mode = true,
        },
        hover = {
          max_width = 0.6,
          open_link = "gw",
          open_browser = "!msedge",
        },
        diagnostic = {
          keys = {
            exec_action = "o",
            quit = "q",
            expand_or_jump = "<CR>",
            quit_in_show = { "q", "<ESC>" },
          },
        },
        ui = {
          winblend = 30,
        },
      })
      local sign = function(opts)
        vim.fn.sign_define(opts.name, {
          texthl = opts.name,
          text = opts.text,
          numhl = "",
        })
      end
      sign({ name = "DiagnosticSignError", text = "" })
      sign({ name = "DiagnosticSignWarn", text = "" })
      sign({ name = "DiagnosticSignHint", text = "" })
      sign({ name = "DiagnosticSignInfo", text = "" })
      vim.diagnostic.config({
        virtual_text = true,
        severity_sort = true,
        signs = true,
        underline = false,
      })
    end,
  },
}
