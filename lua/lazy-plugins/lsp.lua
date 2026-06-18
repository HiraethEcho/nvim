return {
  { -- "neovim/nvim-lspconfig",
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
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {},
  },
  { -- "williamboman/mason.nvim",
    "williamboman/mason.nvim",
    -- enabled = false,
    cmd = "Mason",
    keys = {
      { "<leader>lm", "<cmd>Mason<cr>", desc = "Mason" },
    },
    build = ":MasonUpdate",
    opts = {},
  },
  { -- "rachartier/tiny-code-action.nvim",
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/snacks.nvim",
    },
    keys = {
      {
        "ga",
        function()
          require("tiny-code-action").code_action()
        end,
        desc = "code actions",
      },
    },
    -- event = "LspAttach",
    opts = {
      --- The backend to use, currently only "vim", "delta", "difftastic", "diffsofancy" are supported
      backend = "vim",
      -- The picker to use, "telescope", "snacks", "select" are supported
      picker = { "snacks" },
      signs = {
        quickfix = { "󰁨", { link = "DiagnosticInfo" } },
        others = { "?", { link = "DiagnosticWarning" } },
        refactor = { "", { link = "DiagnosticWarning" } },
        ["refactor.move"] = { "󰪹", { link = "DiagnosticInfo" } },
        ["refactor.extract"] = { "", { link = "DiagnosticError" } },
        ["source.organizeImports"] = { "", { link = "DiagnosticWarning" } },
        ["source.fixAll"] = { "", { link = "DiagnosticError" } },
        ["source"] = { "", { link = "DiagnosticError" } },
        ["rename"] = { "󰑕", { link = "DiagnosticWarning" } },
        ["codeAction"] = { "", { link = "DiagnosticError" } },
      },
    },
  },
  -- disabled
  { -- "rachartier/tiny-inline-diagnostic.nvim",
    "rachartier/tiny-inline-diagnostic.nvim",
    enabled = false,
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
  { -- "folke/trouble.nvim",
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
  { -- "glepnir/lspsaga.nvim",
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
}
