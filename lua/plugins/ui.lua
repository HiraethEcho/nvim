local transparent={
    "xiyaowong/nvim-transparent",
    cmd="TransparentEnable",
    -- lazy=false,
    config=function()
      require("transparent").setup({
        -- enable = true, -- boolean: enable transparent
        extra_groups = { -- table/string: additional groups that should be cleared
        -- In particular, when you set it to 'all', that means all available groups

        -- example of akinsho/nvim-bufferline.lua
        -- "BufferLineTabClose",
        -- "BufferlineBufferSelected",
        -- "BufferLineFill",
        -- "BufferLineBackground",
        -- "BufferLineSeparator",
        -- "BufferLineIndicatorSelected",
      },
      -- exclude = {}, -- table: groups you don't want to clear
      -- ignore_linked_group = true, -- boolean: don't clear a group that links to another group
    })
  end,

}

local color={
  {
    'shaunsingh/nord.nvim',
    enabled=false,
    -- lazy =false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- vim.cmd([[colorscheme nord]])
    end,
  },
  {
    "folke/tokyonight.nvim",
    enabled=false,
    lazy =true, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "xiyaowong/nvim-transparent",
    -- cmd="TransparentToggle",
    lazy=false,
    config=function()
      require("transparent").setup({
        -- enable = true, -- boolean: enable transparent
        extra_groups = { -- table/string: additional groups that should be cleared
        -- In particular, when you set it to 'all', that means all available groups

        -- example of akinsho/nvim-bufferline.lua
        -- "BufferLineTabClose",
        -- "BufferlineBufferSelected",
        -- "BufferLineFill",
        -- "BufferLineBackground",
        -- "BufferLineSeparator",
        -- "BufferLineIndicatorSelected",
      },
      -- exclude = {}, -- table: groups you don't want to clear
      -- ignore_linked_group = true, -- boolean: don't clear a group that links to another group
    })
  end,
  },
  {
'norcalli/nvim-colorizer.lua',
cmd="ColorizerToggle",
config=function()
require 'colorizer'.setup()
end,
},
}

local line={
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "BufReadPost",
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        disabled_filetypes = {'coc-explorer'},
        theme = 'onedark',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = {'branch'},
        lualine_b = {
          {
            'filename',
            file_status = true,      -- Displays file status (readonly status, modified status)
            newfile_status = true,  -- Display new file status (new file means no write after created)
            path = 1,                -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path
            -- 3: Absolute path, with tilde as the home directory
            shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
            -- for other components. (terrible name, any suggestions?)
            symbols = {
              modified = '●',      -- Text to show when the file is modified.
              readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[No Name]', -- Text to show for unnamed buffers.
              newfile = '[New]',     -- Text to show for newly created file before first write
            }
          },
          'diff'
        },
        -- lualine_c = {'g:coc_status'},
lualine_c = {{ "aerial",
      -- The separator to be used to separate symbols in status line.
      sep = ' ) ',

      -- The number of symbols to render top-down. In order to render only 'N' last
      -- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
      -- be used in order to render only current symbol.
      depth = nil,

      -- When 'dense' mode is on, icons are not rendered near their symbols. Only
      -- a single icon that represents the kind of current symbol is rendered at
      -- the beginning of status line.
      dense = false,

      -- The separator to be used to separate symbols in dense mode.
      dense_sep = '.',

      -- Color the symbol icons.
      colored = true,
    }},
        lualine_x = {'filetype'},
        lualine_y = {'progress'},
        lualine_z = {}
      },
      inactive_sections = {
        lualine_a = {
          'branch',
          {
            'filename',
            file_status = true,      -- Displays file status (readonly status, modified status)
            newfile_status = true,  -- Display new file status (new file means no write after created)
            path = 1,                -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path
            -- 3: Absolute path, with tilde as the home directory
            shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
            -- for other components. (terrible name, any suggestions?)
            symbols = {
              modified = ' ●',      -- Text to show when the file is modified.
              readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[No Name]', -- Text to show for unnamed buffers.
              newfile = '[New]',     -- Text to show for newly created file before first write
            }
          }
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {'progress'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {
        lualine_a = {
          {
            'filename',
            symbols = {
              modified = '●',      -- Text to show when the file is modified.
              readonly = '-',      -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[unnamed]', -- Text to show for unnamed buffers.
              newfile = '[New]',     -- Text to show for newly created file before first write
            }
          }
        },
        lualine_b = {
          { 
            'buffers',
            show_filename_only = true,   -- Shows shortened relative path when set to false.
            show_modified_status = true, -- Shows indicator when the buffer is modified.
            mode = 2, -- 0: Shows buffer name
            -- 1: Shows buffer index
            -- 2: Shows buffer name + buffer index
            -- 3: Shows buffer number
            -- 4: Shows buffer name + buffer number
            symbols = {
              modified = ' ●',      -- Text to show when the buffer is modified
              alternate_file = '', -- Text to show to identify the alternate file
              directory =  '',     -- Text to show when the buffer is a directory
            },
          }
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          {
            'tabs',
            max_length = vim.o.columns / 3, -- Maximum width of tabs component.
            -- Note:
            -- It can also be a function that returns
            -- the value of `max_length` dynamically.
            mode = 2, -- 0: Shows tab_nr
            -- 1: Shows tab_name
            -- 2: Shows tab_nr + tab_name
          }
        }
      },
      winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      inactive_winbar = {},
      extensions = {}
    }
    -- vim.keymap.set("n", "<A-1>", "<cmd>LualineBuffersJump! 1<CR>", { noremap = true, silent = true })
    -- vim.keymap.set("n", "<A-2>", "<cmd>LualineBuffersJump! 2<CR>", { noremap = true, silent = true })
    -- vim.keymap.set("n", "<A-3>", "<cmd>LualineBuffersJump! 3<CR>", { noremap = true, silent = true })
    -- vim.keymap.set("n", "<A-4>", "<cmd>LualineBuffersJump! 4<CR>", { noremap = true, silent = true })
    -- vim.keymap.set("n", "<A-5>", "<cmd>LualineBuffersJump! 5<CR>", { noremap = true, silent = true })
    -- vim.keymap.set("n", "<A-6>", "<cmd>LualineBuffersJump! 6<CR>", { noremap = true, silent = true })
    -- vim.keymap.set("n", "<A-7>", "<cmd>LualineBuffersJump! 7<CR>", { noremap = true, silent = true })
    -- vim.keymap.set("n", "<A-8>", "<cmd>LualineBuffersJump! 8<CR>", { noremap = true, silent = true })
    -- vim.keymap.set("n", "<A-9>", "<cmd>LualineBuffersJump! 9<CR>", { noremap = true, silent = true })
    -- vim.keymap.set("n", "<A-$>", "<cmd>LualineBuffersJump! $<CR>", { noremap = true, silent = true })
  end,
}


local bar={
  "utilyre/barbecue.nvim",
  enabled=false,
  dependencies = {
    "neovim/nvim-lspconfig",
    "SmiteshP/nvim-navic",
  },
  config = function()
    require("barbecue").setup()
  end,
}


local start={
  {
    "mhinz/vim-startify",
    event = "VimEnter",
    -- lazy=false,

    config=function()
      vim.g.startify_session_dir = "~/AppData/Local/nvim/session/"
      vim.g.startify_files_number= 3
      vim.cmd([[
      let g:startify_lists= [
      \ { 'type': 'sessions'  , 'header': ['   Sessions'  ] } ,
      \ { 'type': 'files'     , 'header': ['   Recent'    ] } ,
      \ ]
      ]])
      -- let g:startify_custom_header=startify#pad(split(system('figlet -w 100 Carpe diem'), '\n'))
      -- let g:startify_custom_footer=startify#pad(split(system('figlet -w 100 Seize the day'), '\n'))
    end,
  },

  {
    "echasnovski/mini.starter",
    enabled=false,
    -- lazy=false,
    version = false, -- wait till new 0.7.0 release to put it back on semver
    -- event = "VimEnter",
    config=function()
      require('mini.starter').setup() 
    end,
  },
}

local indentline={
  {
    "lukas-reineke/indent-blankline.nvim",
    -- enabled=false,
    event = "BufRead",
    config = function()
      -- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
      -- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
      -- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
      -- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
      -- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
      -- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
      use_treesitter = false,
      require("indent_blankline").setup({
        -- for example, context is off by default, use this to turn it on
        char = "¦", -- ['|', '¦', '┆', '┊']
        show_end_of_line = true,
        space_char_blankline = " ",
        -- show_current_context = true,
        show_first_indent_level = false,
        -- show_current_context_start = false,
        buftype_exclude = {
          "terminal",
          "[No Name]",
          "prompt",
          "nofile",
          "help",
          -- "TelescopePrompt",
        },
        filetype_exclude = {
          "packer",
          "log",
          "markdown",
          "org",
          "lspinfo",
          "plugin",
          "text",
          "starify",
          "txt"
        },
        -- char_highlight_list = {
        --   "IndentBlanklineIndent1",
        --   "IndentBlanklineIndent2",
        --   "IndentBlanklineIndent3",
        --   "IndentBlanklineIndent4",
        --   "IndentBlanklineIndent5",
        --   "IndentBlanklineIndent6",
        -- },
      })
    end,
  },

  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "BufReadPre",
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require("mini.indentscope").setup(opts)
    end,
  }
}

local spec={color,transparent,line,indentline,start}

return spec
