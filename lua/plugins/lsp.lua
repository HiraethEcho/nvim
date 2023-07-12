local tree={
  'nvim-treesitter/nvim-treesitter',
  build = ":TSUpdate",
  lazy=false,
  -- ft={'md','latex','tex','bib'},
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      config=function ()
        require'nvim-treesitter.configs'.setup {
          textobjects = {
            select = {
              enable = true,
              -- Automatically jump forward to textobjects, similar to targets.vim
              lookahead = true,
              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                -- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              },
              -- You can choose the select mode (default is charwise 'v')
              selection_modes = {
                ['@parameter.outer'] = 'v', -- charwise
                ['@function.outer'] = 'V', -- linewise
                ['@class.outer'] = '<c-v>', -- blockwise
              },
              -- If you set this to `true` (default is `false`) then any textobject is
              -- extended to include preceding or succeeding whitespace. Succeeding
              -- whitespace has priority in order to act similarly to eg the built-in
              -- `ap`.
              -- include_surrounding_whitespace = false,
            },
          },
        }
      end,
    },
  },
  config=function()
    require'nvim-treesitter.configs'.setup {
      -- A list of parser names, or "all" (the five listed parsers should always be installed)
      ensure_installed = { "c", "lua", "latex","markdown","yaml"},
      fold={
        enable=true,
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection    = "<cr><cr>", -- set to `false` to disable one of the mappings
          node_incremental  = "<cr>",
          -- scope_incremental = "]",
          node_decremental  = "<BS>",
        },
        indent = {
          enable = true
        },
      },
    }
  end,
}

local lspconfig={
  "neovim/nvim-lspconfig",
  -- lazy=false,
  -- event = { "BufReadPre", "BufNewFile" },
  cmd="LspStart",
  keys={
    { "<leader>ll", "<cmd>LspStart<cr>", desc = "Start lsp" },
  },
  dependencies = {
    -- { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
    {
      "SmiteshP/nvim-navbuddy",
      keys={
        { "<leader>j", "<cmd>Navbuddy<cr>", desc = "Jump by symbol" },
      },
      dependencies = {
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim"
      },
      opts = { lsp = { auto_attach = true } }
    },
    {"folke/neodev.nvim", opts = {} },
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    'nvim-treesitter/nvim-treesitter',
  },
  config=function()
    -- require'lspconfig'.texlab.setup{}
    -- require'lspconfig'.grammarly.setup{}
    -- require'lspconfig'.prosemd_lsp.setup{}
    -- require'lspconfig'.marksman.setup{}
    -- require'lspconfig'.remark_ls.setup{}
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lsp_defaults = require('lspconfig').util.default_config
    lsp_defaults.capabilities = vim.tbl_deep_extend("force", lsp_defaults.capabilities, capabilities)

    local servers = {
      "lua_ls",
      "html",
      "yamlls",
      "texlab",
      "grammarly",
      "prosemd_lsp",
      "marksman",
      "remark_ls",
      "clangd",
    }

    for _, lsp in pairs(servers) do
      require'lspconfig'[lsp].setup({
        on_attach = on_attach,
      })
    end

    require'lspconfig'.lua_ls.setup{
      settings={
        checkThirdParty = false,
      },
    }
  end,
}

local lsp_server={
  {
    "williamboman/mason.nvim",
    -- cmd = "Mason",
    build = ":MasonUpdate" ,-- :MasonUpdate updates registry contents
    config=function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    -- lazy=false,
    config=function()
      require("mason-lspconfig").setup()
    end,
  },
}

local lspsaga = {
  "glepnir/lspsaga.nvim",
  event = "LspAttach",
  dependencies = {
    {"nvim-tree/nvim-web-devicons"},
    --Please make sure you install markdown and markdown_inline parser
    {"nvim-treesitter/nvim-treesitter"},
    "neovim/nvim-lspconfig",
  },
  keys={
    { "K", "<cmd>Lspsaga hover_doc<cr>", desc = "hover doc" },
    { "<leader>lo", "<cmd>Lspsaga outline<cr>", desc = "lsp outline" },
    { "<leader>ld", "<cmd>Lspsaga show_workspace_diagnostics<cr>", desc = "lsp diagnostic" },
    { "<leader>lf", "<cmd>Lspsaga lsp_finder<cr>", desc = "lsp finder" },
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
        separator = " ",
        ignore_patterns={},
        hide_keyword = true,
        show_file = false,
        -- folder_level = 2,
        -- respect_root = false,
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
    sign({ name = "DiagnosticSignError", text = "✘" })
    sign({ name = "DiagnosticSignWarn", text = "" })
    sign({ name = "DiagnosticSignHint", text = "⚑" })
    sign({ name = "DiagnosticSignInfo", text = "" })
	vim.diagnostic.config({
		virtual_text = true,
		-- virtual_text = false,
		severity_sort = true,
		signs = true,
		update_in_insert = false,
		underline = true,
		float = {
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	})
  end,
}

local spec={
  tree,
  lsp_server,
  lspconfig,
  lspsaga,
}

return spec
