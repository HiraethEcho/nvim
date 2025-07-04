return {
  {
    "neovim/nvim-lspconfig",
    -- event = { "BufReadPost", "BufNewFile" },
    -- lazy=false,
    -- cmd = "LspStart",
    keys = {
      { "<leader>ll", "<cmd>LspStart<cr>", desc = "Start lsp" },
      { "<leader>ls", "<cmd>LspStop<cr>", desc = "stop lsp" },
      { "<leader>li", "<cmd>LspInfo<cr>", desc = "lsp info" },
      { "<leader>lL", "<cmd>LspRestart<cr>", desc = "Restart lsp" },
    },
    dependencies = {
      -- "rachartier/tiny-inline-diagnostic.nvim",
      -- "williamboman/mason.nvim",
      -- "williamboman/mason-lspconfig.nvim",
      -- "saghen/blink.cmp",
      -- "nvimdev/guard.nvim",
      -- "hrsh7th/cmp-nvim-lsp",
      -- "kevinhwang91/nvim-ufo",
    },
    config = function()
      --[[ local capabilities = require("blink.cmp").get_lsp_capabilities()
      -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
      vim.lsp.config('*', {
        root_markers = { '.obsidian', '.git' },
        capabilities = capabilities,
        offset_encoding = "utf-8",
      }) ]]
      --[[ require("lspconfig").texlab.setup({
        offset_encoding = "utf-8",
        on_attach = function(client, bufnr)
          vim.keymap.set("n", "<cr><cr>", "<cmd>TexlabBuild<cr>",
            { noremap = true, silent = true, buffer = bufnr, desc = "texlab build" })
          vim.keymap.set("n", "<cr>", "<cmd>TexlabForward<cr>",
            { noremap = true, silent = true, buffer = bufnr, desc = "texlab forward" })
        end,
        settings = {
          texlab = {
            build = {
              -- executable = 'xelatex',
              onSave = true,
              forwardSearchAfter = false,
            },
            forwardSearch = {
              -- https://github.com/latex-lsp/texlab/wiki/Previewing#inverse-search-3
              executable = "sioyek",
              args = {
                "--reuse-window",
                "--inverse-search",
                "texlab inverse-search -i %%1 -l %%2",
                "--forward-search-file",
                "%f",
                "--forward-search-line",
                "%l",
                "%p",
              },
              executable = "zathura",
              args = {
                "--synctex-forward",
                "%l:1:%f",
                "%p",
                -- "--synctex-editor-command",
                -- "texlab inverse-search -i %{input} -l %{line}", -- add this in zathurarc, not here
              },
            },
            chktex = {
              onOpenAndSave = true,
              onEdit = false,
            },
            bibtexFormatter = "texlab",
            latexFormatter = "latexindent",
            latexindent = {
              ["local"] = nil, -- local is a reserved keyword
              modifyLineBreaks = false,
            },
            formatterLineLength = 80,
          },
        },
      }) ]]
      -- require("lspconfig").lua_ls.setup({})
      -- require("lspconfig").marksman.setup({})
      -- require("lspconfig").clangd.setup({})
      --[[ require("lspconfig").tinymist.setup({
        single_file_support = true,
        on_attach = function(client, bufnr)
          vim.keymap.set("n", "<cr>", "<cmd>TypstPreviewSyncCursor<cr>",
            { noremap = true, silent = true, buffer = bufnr, desc = "Typst Preview" })
        end,
      }) ]]
    end,
  },
  {
    "williamboman/mason.nvim",
    -- enabled = false,
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
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      vim.diagnostic.config({ virtual_text = false })
      require("tiny-inline-diagnostic").setup({
        preset = "powerline", -- Can be: "modern", "classic", "minimal", "powerline", ghost", "simple", "nonerdfont", "amongus"
        options = {
          show_source = true,
          -- multiple_diag_under_cursor = true,
        },
      })
    end,
  },
  {
    "b0o/incline.nvim",
    -- enabled = false,
    event = "LspAttach",

    config = function()
      local helpers = require("incline.helpers")
      local navic = require("nvim-navic")
      local devicons = require("nvim-web-devicons")
      require("incline").setup({
        window = {
          padding = 2,
          margin = { horizontal = 0, vertical = 0 },
        },
        render = function(props)
          local function get_lsp_clients()
            local buf_clients = nil
            buf_clients = vim.lsp.get_clients({ bufnr = 0 })
            local buf_client_names = {}
            -- table.insert(buf_client_names, "")
            for _, client in pairs(buf_clients) do
              table.insert(buf_client_names, client.name)
            end
            return table.concat(buf_client_names, ",")
          end
          local function get_diagnostic_label()
            local icons = {
              error = " ",
              warn = " ",
              info = " ",
              hint = "󰌵 ",
            }
            local label = {}
            for severity, icon in pairs(icons) do
              local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
              if n > 0 then
                table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
              end
            end
            -- if #label > 0 then
            --   table.insert(label, { "" })
            -- end
            return label
          end
          return {
            -- { filename },
            { get_diagnostic_label() },
            { get_lsp_clients() },
          }
        end,
      })
    end,
  },
  -- disabled
  {
    "folke/trouble.nvim",
    enabled = false,
    opts = {
      modes = {
        split = {
          mode = "diagnostics",
          preview = {
            type = "split",
            relative = "win",
            position = "right",
            size = 0.3,
          },
        },
      },
    }, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xb",
        "<cmd>Trouble diagnostics toggle filter.buf=0 focus=false<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>xs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>xl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xq",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "glepnir/lspsaga.nvim",
    enabled = false,
    event = "LspAttach",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      -- { "nvim-treesitter/nvim-treesitter" },
      "neovim/nvim-lspconfig",
    },
    keys = {
      -- { "K", "<cmd>Lspsaga hover_doc<cr>", desc = "hover doc" },
      { "<leader>lo", "<cmd>Lspsaga outline<cr>", desc = "lsp outline" },
      { "<leader>la", "<cmd>Lspsaga code_action<cr>", desc = "lsp code_action" },
      { "<leader>ld", "<cmd>Lspsaga show_buf_diagnostics<cr>", desc = "lsp buff diagnostic" },
      { "<leader>lD", "<cmd>Lspsaga show_workspace_diagnostics<cr>", desc = "lsp workspace diagnostic" },
      { "<leader>lf", "<cmd>Lspsaga finder<cr>", desc = "lsp finder" },
      -- { "<leader>lF", ":lua vim.lsp.buf.format()<cr>",               desc = "lsp formart" },
      { "gp", "<cmd>Lspsaga peek_definition<cr>", desc = "lsp peek definition" },
      { "gd", "<cmd>Lspsaga goto_definition<cr>", desc = "go to definition" },
      { "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "previous diagnostic" },
      { "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "next diagnostic" },
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
            jump = "<space>",
          },
        },
        lightbulb = {
          enable = false,
        },
        symbol_in_winbar = {
          enable = false,
          show_file = false,
          folder_level = 5,
          color_mode = true,
        },
        hover = {
          max_width = 0.6,
          open_link = "gw",
          open_browser = "qutebrowser",
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
  {
    "jinzhongjia/LspUI.nvim",
    branch = "main",
    enabled = false,
    config = function()
      require("LspUI").setup({
        -- config options go here
      })
    end,
  },
}
