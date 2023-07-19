local vim = vim
return {
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      {"nvim-tree/nvim-web-devicons"},
      --Please make sure you install markdown and markdown_inline parser
      {"nvim-treesitter/nvim-treesitter"},
      "neovim/nvim-lspconfig",
    },
    keys={
      -- { "K", "<cmd>Lspsaga hover_doc<cr>", desc = "hover doc" },
      { "<leader>lo", "<cmd>Lspsaga outline<cr>", desc = "lsp outline" },
      { "<leader>ld", "<cmd>Lspsaga show_buf_diagnostics<cr>", desc = "lsp diagnostic" },
      { "<leader>lf", "<cmd>Lspsaga finder<cr>", desc = "lsp finder" },
      { "gp", "<cmd>Lspsaga peek_definition<cr>", desc = "lsp peek definition" },
      { "<leader>t", "<cmd>Lspsaga term_toggle<cr>", desc = "lsp terminal" },
      { "gd", "<cmd>Lspsaga goto_definition<cr>", desc = "go to definition" },
      { "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "previous diagnostic" },
      { "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "next diagnostic" },
    },
    config = function()
      require("lspsaga").setup({
        preview = {
          lines_above = 0,
          lines_below = 10,
        },
        scroll_preview = {
          scroll_down = "<C-u>",
          scroll_up = "<C-d>",
        },
        request_timeout = 2000,

        -- For default options for each command, see below
        finder = {
          max_height = 0.5,
          min_width = 30,
          force_max_height = false,
          keys = {
            jump_to = 'p',
            expand_or_jump = '<cr>',
            vsplit = 'v',
            split = 's',
            tabe = 't',
            tabnew = 'r',
            quit = { 'q', '<ESC>' },
            close_in_preview = '<ESC>',
          },
        },
        outline = {
          win_position = "right",
          win_with = "",
          win_width = 30,
          preview_width= 0.4,
          show_detail = true,
          auto_preview = true,
          auto_refresh = true,
          auto_close = true,
          auto_resize = false,
          custom_sort = nil,
          keys = {
            expand_or_jump = '<cr>',
            quit = "q",
          },
        },
        lightbulb = {
          enable = false,
        },
        symbol_in_winbar = {
          enable = true,
          separator = "",
          ignore_patterns={},
          hide_keyword = true,
          show_file = false,
          folder_level = 5,
          color_mode = true,
        },
        hover = {
          max_width = 0.6,
          open_link = 'gw',
          open_browser = '!msedge',
        },
        diagnostic = {
          on_insert = false,
          on_insert_follow = false,
          insert_winblend = 40,
          show_code_action = true,
          show_source = true,
          jump_num_shortcut = true,
          max_width = 0.7,
          max_height = 0.6,
          max_show_width = 0.9,
          max_show_height = 0.6,
          text_hl_follow = true,
          border_follow = true,
          extend_relatedInformation = false,
          keys = {
            exec_action = 'o',
            quit = 'q',
            expand_or_jump = '<CR>',
            quit_in_show = { 'q', '<ESC>' },
          },
        },
        ui = {
          -- This option only works in Neovim 0.9
          title = true,
          -- Border type can be single, double, rounded, solid, shadow.
          border = "single",
          winblend = 30,
          expand = "",
          collapse = "",
          code_action = "💡",
          -- incoming = " ",
          -- outgoing = " ",
          hover = ' ',
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
      underline = true,
      float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
    end,
  },
}

