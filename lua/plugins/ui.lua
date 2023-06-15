local transparent={
  "xiyaowong/nvim-transparent",
  cmd="TransparentEnable",
  -- lazy=false,
  config=function()
    require("transparent").setup({
      -- enable = true, -- boolean: enable transparent
      extra_groups = { -- table/string: additional groups that should be cleared
      "all",
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
'marko-cerovac/material.nvim',
event= 'VimEnter',
config=function()
require('material').setup({

    contrast = {
        terminal = true, -- Enable contrast for the built-in terminal default=false
        sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree ) default=false
        floating_windows = true, -- Enable contrast for floating windows default=false
        cursor_line = true, -- Enable darker background for the cursor line default=false
        non_current_windows = true, -- Enable contrasted background for non-current windows default=false
    },
    plugins = { -- Uncomment the plugins that you use to highlight them
        -- Available plugins:
        -- "dap",
        -- "dashboard",
        "gitsigns",
        "hop",
        "indent-blankline",
        "lspsaga",
        -- "mini",
        -- "neogit",
        -- "neorg",
        "nvim-cmp",
        -- "nvim-navic",
        -- "nvim-tree",
        -- "nvim-web-devicons",
        -- "sneak",
        "telescope",
        -- "trouble",
        "which-key",
    },

    -- disable = {
    --     colored_cursor = false, -- Disable the colored cursor
    --     borders = false, -- Disable borders between verticaly split windows
    --     background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
    --     term_colors = false, -- Prevent the theme from setting terminal colors
    --     eob_lines = false -- Hide the end-of-buffer lines
    -- },

    -- high_visibility = {
    --     darker = false -- Enable higher contrast text for darker style
    -- },

    lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

    async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)
})
vim.cmd 'colorscheme material'
end,

  },
  {
    'shaunsingh/nord.nvim',
    -- enabled=false,
    -- lazy =false, -- make sure we load this during startup if it is your main colorscheme
    -- event="VimEnter",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- vim.cmd([[colorscheme nord]])
    end,
  },
  {
    "folke/tokyonight.nvim",
    -- enabled=false,
    -- lazy =false, -- make sure we load this during startup if it is your main colorscheme
    event="VimEnter",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd([[colorscheme tokyonight]])
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
    local function session_name()
      return require('possession.session').session_name or ''
    end
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'nord',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
          statusline = {'neo-tree','minimap'},
          -- winbar = {},
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
        lualine_a = {
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
        },
        lualine_b = {
          'branch',
          -- 'diff',
        },
        -- lualine_c = {'g:coc_status'},
        lualine_c = {'diff'},
        lualine_x = {'filetype'},
        -- lualine_y = {'progress','location'},
        -- lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
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
              modified = ' ●',      -- Text to show when the file is modified.
              readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[No Name]', -- Text to show for unnamed buffers.
              newfile = '[New]',     -- Text to show for newly created file before first write
            }
          },
          'branch',
        },
        lualine_c = {},
        lualine_x = {'progress'},
        lualine_y = {'Location'},
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
            mode = 0, -- 0: Shows buffer name
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
        lualine_y = {
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
        },
        lualine_z = {session_name},
      },
      extensions = {}
    }
  end,
}




local alpha={  -- lazy.nvim
  "goolord/alpha-nvim",
  dependencies={
    'jedrzejboczar/possession.nvim',
  },
  event = "VimEnter",
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    -- TODO: start logo <28-05-23, > 
    local logo = [[
    ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
    ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z
    ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z
    ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z
    ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
    ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
    ]]

    dashboard.section.header.val = vim.split(logo, "\n")
    dashboard.section.buttons.val = {
      (function()
        local group = { type = "group", opts = { spacing = 0 } }
        group.val = {
          {
            type = "text",
            val = "Sessions",
            opts = {
              position = "center"
            }
          }
        }
        local path = vim.fn.stdpath("data") .. "/sessions"
        local files = vim.split(vim.fn.glob(path .. "/*.json"), "\n")
        local i = 1
        for _, file in pairs(files) do
          local basename = vim.fs.basename(file):gsub("%.json", "")
          if basename ~= "config" then
            if basename ~= "tmp" then
            local button = dashboard.button(tostring(i), "● " .. basename, "<cmd>PLoad " .. basename .. "<cr>")
            table.insert(group.val, button)
            i = i + 1
            end
          end
        end
        return group
      end)(),
      -- dashboard.button("f", " " .. " Find Files",
      -- [[<cmd>lua Util.telescope("find_files", { prompt_title = "Find Files (cwd)", })() <CR>]]),
      dashboard.button("e", " " .. " New Files", ":enew<CR>"),
      -- dashboard.button("o", " " .. " Recent Files", ":Telescope frecency <CR>"),
      -- dashboard.button("g", " " .. " Find Text", ":Telescope live_grep <CR>"),
      dashboard.button("t", " " .. " TMP", [[<cmd>PLoad tmp<CR>]]),
      dashboard.button("c", " " .. " Nvim Config", [[<cmd>PLoad config<CR>]]),
      dashboard.button("l", "󰒲" .. " Lazy", ":Lazy<CR>"),
      dashboard.button("q", " " .. " Quit", ":qa<CR>"),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end
    dashboard.section.footer.opts.hl = "Type"
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.opts.layout[1].val = 8
    return dashboard
    end,
  config = function(_, dashboard)
    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
      end,
      })
  end

  require("alpha").setup(dashboard.opts)

  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
      pcall(vim.cmd.AlphaRedraw)
    end,
  })
end,
}

local indentline = {
  "lukas-reineke/indent-blankline.nvim",
  -- TODO: better ui lazyload
  -- enabled=false,
  event = "BufRead",
  config = function()
    require("indent_blankline").setup({
      space_char_blankline = " ",
      char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
      },
      -- space_char_highlight_list = {
        --   "IndentBlanklineIndent7",
        --   "IndentBlanklineIndent8",
        -- },
      show_end_of_line = true,
      show_current_context = true,
      show_current_context_start = true,
      show_first_indent_level = false,
      show_trailing_blankline_indent = true,
      buftype_exclude = {
        "terminal",
        "[No Name]",
        "prompt",
        "nofile",
        "help",
      },
      filetype_exclude = {
        "log",
        "markdown",
        "org",
        "lspinfo",
        "plugin",
        "text",
        "txt"
      },
    })
  end,
}

local notify={
  'rcarriga/nvim-notify',
  -- lazy=false,
  -- TODO: better ui lazyload
  config=function ()
    require("notify").setup({
      background_colour = "NotifyBackground",
      fps = 60,
      icons = {
        -- NOTE:icons here
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = ""
      },
      level = 2,
      minimum_width = 50,
      render = "default",
      stages = "slide",
      timeout = 2000,
      top_down = true
    })
    vim.notify = require("notify")
  end,
}

local minimap={
  'wfxr/minimap.vim',
  -- lazy=false,
  dependencies={
  'rcarriga/nvim-notify',
  'petertriho/nvim-scrollbar',
  'lewis6991/gitsigns.nvim',
  },
  keys={
    { "<leader>m", "<cmd>MinimapToggle<cr>", desc = "Minimap Toggle" },
  },
  cmd={
    "MinimapOpen",
    "MinimapClose",
    "MinimapToggle",
  },
  config=function ()
    vim.g.minimap_width = 20
    vim.g.minimap_highlight_search=1
    vim.g.minimap_git_colors=1
  end,
}

local scrollbar={
  'petertriho/nvim-scrollbar',
  dependencies ={
    "kevinhwang91/nvim-hlslens",
    config = function()
      -- require('hlslens').setup() is not required
      require("scrollbar.handlers.search").setup({
        -- hlslens config overrides
      })
    end,
  },
  -- lazy =false,
  cmd = "ScrollbarToggle",
  config = function()
    -- require('hlslens').setup() is not required
    require("scrollbar").setup()
  end,
}

local spec={color,transparent,line,indentline,alpha,notify,minimap,scrollbar}

return spec
