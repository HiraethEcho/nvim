local tree={
  'nvim-treesitter/nvim-treesitter',
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  -- lazy=false,
  -- ft={'lua','md','latex','tex','bib'},
  -- 'do': ':TSUpdate'
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
      ensure_installed = { "c", "lua", "latex","markdown"  },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = true,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      -- List of parsers to ignore installing (for "all")
      -- ignore_install = { "javascript" },

      ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
      -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

      highlight = {
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        -- disable = { "c", "rust" },
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        --
        -- disable = function(lang, buf)
        --     local max_filesize = 100 * 1024 -- 100 KB
        --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        --     if ok and stats and stats.size > max_filesize then
        --         return true
        --     end
        -- end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn", -- set to `false` to disable one of the mappings
          node_incremental = "gin",
          scope_incremental = "gic",
          node_decremental = "gim",
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
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
    { "folke/neodev.nvim", opts = {} },
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config=function()
    require'lspconfig'.texlab.setup{}
    require'lspconfig'.lua_ls.setup{}
    -- 
    -- require'lspconfig'.latexindent.setup{}
    require'lspconfig'.ltex_ls.setup{}
    require'lspconfig'.marksman.setup{}
    require'lspconfig'.remark_ls.setup{}
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

local lspsaga={
  "glepnir/lspsaga.nvim",
  -- lazy=false,
  event = "LspAttach",
  dependencies = {
    {"nvim-tree/nvim-web-devicons"},
    --Please make sure you install markdown and markdown_inline parser
    {"nvim-treesitter/nvim-treesitter"},
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

      -- See Customizing Lspsaga's Appearance
      -- ui = { ... },

      -- For default options for each command, see below
      finder = {
        max_height = 0.5,
        min_width = 30,
        force_max_height = false,
        keys = {
          jump_to = 'p',
          expand_or_jump = 'o',
          vsplit = 's',
          split = 'i',
          tabe = 't',
          tabnew = 'r',
          quit = { 'q', '<ESC>' },
          close_in_preview = '<ESC>',
        },
      },
      code_action = {
        num_shortcut = true,
        show_server_name = false,
        extend_gitsigns = true,
        keys = {
          -- string | table type
          quit = "q",
          exec = "<CR>",
        },
      },
      -- etc.
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
          expand_or_jump = 'o',
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
    show_file = true,
    folder_level = 2,
    respect_root = false,
    color_mode = true,
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
