return {
  {
    'gen740/SmoothCursor.nvim',
    lazy = false,
    enabled = false,
    config = function()
      require('smoothcursor').setup({
        type = "matrix", -- Cursor movement calculation method, choose "default", "exp" (exponential) or "matrix".

        cursor = "", -- Cursor shape (requires Nerd Font). Disabled in fancy mode.
        texthl = "SmoothCursor", -- Highlight group. Default is { bg = nil, fg = "#FFD400" }. Disabled in fancy mode.
        linehl = nil, -- Highlights the line under the cursor, similar to 'cursorline'. "CursorLine" is recommended. Disabled in fancy mode.

        fancy = {
          enable = true, -- enable fancy mode
          head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil }, -- false to disable fancy head
          body = {
            { cursor = "󰝥", texthl = "SmoothCursorRed" },
            { cursor = "󰝥", texthl = "SmoothCursorOrange" },
            { cursor = "●", texthl = "SmoothCursorYellow" },
            { cursor = "●", texthl = "SmoothCursorGreen" },
            { cursor = "•", texthl = "SmoothCursorAqua" },
            { cursor = ".", texthl = "SmoothCursorBlue" },
            { cursor = ".", texthl = "SmoothCursorPurple" },
          },
          tail = { cursor = nil, texthl = "SmoothCursor" } -- false to disable fancy tail
        },

        matrix = { -- Loaded when 'type' is set to "matrix"
          head = {
            -- Picks a random character from this list for the cursor text
            cursor = require('smoothcursor.matrix_chars'),
            -- Picks a random highlight from this list for the cursor text
            texthl = {
              'SmoothCursor',
            },
            linehl = nil, -- No line highlight for the head
          },
          body = {
            length = 6, -- Specifies the length of the cursor body
            -- Picks a random character from this list for the cursor body text
            cursor = require('smoothcursor.matrix_chars'),
            -- Picks a random highlight from this list for each segment of the cursor body
            texthl = {
              'SmoothCursorGreen',
            },
          },
          tail = {
            -- Picks a random character from this list for the cursor tail (if any)
            cursor = nil,
            -- Picks a random highlight from this list for the cursor tail
            texthl = {
              'SmoothCursor',
            },
          },
          unstop = false, -- Determines if the cursor should stop or not (false means it will stop)
        },

        autostart = true,          -- Automatically start SmoothCursor
        always_redraw = true,      -- Redraw the screen on each update
        flyin_effect = nil,        -- Choose "bottom" or "top" for flying effect
        speed = 25,                -- Max speed is 100 to stick with your current position
        intervals = 35,            -- Update intervals in milliseconds
        priority = 10,             -- Set marker priority
        timeout = 3000,            -- Timeout for animations in milliseconds
        threshold = 3,             -- Animate only if cursor moves more than this many lines
        max_threshold = nil,       -- If you move more than this many lines, don't animate (if `nil`, deactivate check)
        disable_float_win = false, -- Disable in floating windows
        enabled_filetypes = nil,   -- Enable only for specific file types, e.g., { "lua", "vim" }
        disabled_filetypes = nil,  -- Disable for these file types, ignored if enabled_filetypes is set. e.g., { "TelescopePrompt", "NvimTree" }
        -- Show the position of the latest input mode positions.
        -- A value of "enter" means the position will be updated when entering the mode.
        -- A value of "leave" means the position will be updated when leaving the mode.
        -- `nil` = disabled
        show_last_positions = nil,
      })
    end
  },
  {
    "stevearc/dressing.nvim",
    enabled = false,
    event = "BufReadPost",
    opts = {},
  },
  {
    "xiyaowong/nvim-transparent",
    enabled = false,
    cmd = "TransparentEnable",
    -- lazy=false,
    config = function()
      require("transparent").setup({})
    end,
  },
  {
    "neanias/everforest-nvim",
    enabled = false,
    -- lazy = false,
    -- cmd = "colorscheme",
    version = false,
    -- event = "VimEnter",
    config = function()
      require("everforest").setup({
        ---Controls the "hardness" of the background. Options are "soft", "medium" or "hard".
        background = "soft",
        italics = true,
        ---By default, the colour of the sign column background is the same as the as normal text
        ---background, but you can use a grey background by setting this to `"grey"`.
        sign_column_background = "grey",
        ---The contrast of line numbers, indent lines, etc. Options are `"high"` or
        ---`"low"` (default).
        ui_contrast = "high",
        dim_inactive_windows = true,
        diagnostic_text_highlight = true,
        ---Which colour the diagnostic text should be. Options are `"grey"` or `"coloured"` (default)
        diagnostic_virtual_text = "coloured",
        diagnostic_line_highlight = true,
        float_style = "bright",
      })
      -- require("everforest").load()
    end,
  },
  {
    "rose-pine/neovim",
    -- cmd = "colorscheme",
    enabled = false,
    -- name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "dawn",      -- auto, main, moon, or dawn
        dark_variant = "main", -- main, moon, or dawn
        dim_inactive_windows = true,
        extend_background_behind_borders = true,
        enable = {
          terminal = false,
          legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
          migrations = true,        -- Handle deprecated options automatically
        },
        styles = {
          bold = true,
          italic = true,
        },
      })
      -- vim.cmd("colorscheme rose-pine")
      -- vim.cmd("colorscheme rose-pine-main")
      -- vim.cmd("colorscheme rose-pine-moon")
      -- vim.cmd("colorscheme rose-pine-dawn")
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    event = "VimEnter",
    config = function()
      require('nightfox').setup({
        options = {
          dim_inactive = true,     -- Non focused panes set to alternative background
          module_default = true,   -- Default enable value for modules
          colorblind = {
            enable = true,         -- Enable colorblind support
            simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
          },
          styles = {               -- Style to be applied to different syntax groups
            -- bold
            -- underline
            -- undercurl  curly underline
            -- underdouble  double underline
            -- underdotted  dotted underline
            -- underdashed  dashed underline
            -- strikethrough
            -- reverse
            -- inverse    same as reverse
            -- italic
            -- standout
            -- altfont
            -- nocombine  override attributes instead of combining them
            -- NONE   no attributes used (used to reset it)
            comments = "italic", -- Value is any valid attr-list value `:help attr-list`
            conditionals = "italic",
            constants = "bold",
            functions = "bold,italic",
            keywords = "italic",
            numbers = "italic",
            operators = "NONE",
            strings = "underdotted",
            types = "NONE",
            variables = "NONE",
          },
          inverse = { -- Inverse highlight for different types
            match_paren = false,
            visual = false,
            search = false,
          },
        },
      })
      -- setup must be called before loading
      vim.cmd("colorscheme dayfox")
    end,
  },
  {
    'AlexvZyl/nordic.nvim',
    enabled = false,
    -- event = "VimEnter",
    -- cmd = "colorscheme",
    config = function()
      local palette = require 'nordic.colors'
      require 'nordic'.setup {
        -- This callback can be used to override the colors used in the palette.
        on_palette = function(palette) return palette end,
        -- Enable bold keywords.
        bold_keywords = true,
        -- Enable italic comments.
        bright_border = true,
        -- Reduce the overall amount of blue in the theme (diverges from base Nord).
        reduced_blue = false,
        -- Override the styling of any highlight group.
        override = {
          TelescopePromptTitle = {
            fg = palette.red.bright,
            bg = palette.green.base,
            italic = true,
            underline = true,
            sp = palette.yellow.dim,
            undercurl = false
          }
        },
        -- Cursorline options.  Also includes visual/selection.
        cursorline = {
          -- Bold font in cursorline.
          bold = true,
          -- Bold cursorline number.
          bold_number = true,
          -- Available styles: 'dark', 'light'.
          theme = 'dark',
          -- Blending the cursorline bg with the buffer bg.
          blend = 0.85,
        },
        noice = {
          -- Available styles: `classic`, `flat`.
          style = 'fat',
        },
        telescope = {
          -- Available styles: `classic`, `flat`.
          style = 'classic',
        },
      }
      vim.cmd.colorscheme 'nordic'
    end
  },
  {
    "norcalli/nvim-colorizer.lua",
    cmd = "ColorizerToggle",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    -- enabled = false,
    event = "VimEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "meuter/lualine-so-fancy.nvim",
    },
    -- event = "BufRead",
    -- event = "VeryLazy",
    config = function()
      local function session_name()
        return require('possession.session').get_session_name() or ''
      end
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "everforest",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {
              "neo-tree",
              "sagaoutline",
              "Outline",
              "undotree",
            },
          },
        },
        sections = {
          lualine_a = {
            -- "mode",
            {
              "filename",
              file_status = true,    -- Displays file status (readonly status, modified status)
              newfile_status = true, -- Display new file status (new file means no write after created)
              path = 1,
              -- 0: Just the filename
              -- 1: Relative path
              -- 2: Absolute path
              -- 3: Absolute path, with tilde as the home directory
              shorting_target = 40, -- Shortens path to leave 40 spaces in the window
              -- for other components. (terrible name, any suggestions?)
              symbols = {
                modified = "", -- Text to show when the file is modified.
                readonly = "", -- Text to show when the file is non-modifiable or readonly.
                unnamed = "", -- Text to show for unnamed buffers.
                newfile = "", -- Text to show for newly created file before first write
              },
            },
          },
          lualine_b = {
            -- "diff",
            "branch",
            "fancy_diff",
          },
          lualine_c = {
            "fancy_lsp_servers",
            "fancy_diagnostics",
          },
          lualine_x = {
            "searchcount",
          },
          lualine_y = { "filetype" },
          lualine_z = {
            "progress",
            "location",
            --[[ function()
              return " " .. os.date("%R")
            end, ]]
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {
            {
              "filename",
              file_status = true,    -- Displays file status (readonly status, modified status)
              newfile_status = true, -- Display new file status (new file means no write after created)
              path = 1,              -- 0: Just the filename
              -- 1: Relative path
              -- 2: Absolute path
              -- 3: Absolute path, with tilde as the home directory
              shorting_target = 40, -- Shortens path to leave 40 spaces in the window
              -- for other components. (terrible name, any suggestions?)
              symbols = {
                modified = "", -- Text to show when the file is modified.
                readonly = "", -- Text to show when the file is non-modifiable or readonly.
                unnamed = "", -- Text to show for unnamed buffers.
                newfile = "", -- Text to show for newly created file before first write
              },
            },
          },
          lualine_c = {
            -- "diff",
          },
          lualine_x = {
            -- "hfancy_diagnostics",
            -- "fancy_lsp_servers",
            "filetype"
          },
          lualine_y = { "progress" },
          lualine_z = {},
        },
        tabline = {
          lualine_a = {
            {
              "tabs",
              max_length = vim.o.columns / 3, -- Maximum width of tabs component.
              -- Note:
              -- It can also be a function that returns
              -- the value of `max_length` dynamically.
              mode = 1, -- 0: Shows tab_nr
              -- 1: Shows tab_name
              -- 2: Shows tab_nr + tab_name
            },
          },
          lualine_b = {
            -- "windows",
            -- {
            --   "filename",
            --   symbols = {
            --     modified = "", -- Text to show when the file is modified.
            --     readonly = "", -- Text to show when the file is non-modifiable or readonly.
            --     unnamed = "", -- Text to show for unnamed buffers.
            --     newfile = "", -- Text to show for newly created file before first write
            --   },
            -- },
          },
          lualine_c = {
          },
          lualine_x = {
            {
              "buffers",
              show_filename_only = true,   -- Shows shortened relative path when set to false.
              show_modified_status = true, -- Shows indicator when the buffer is modified.
              mode = 0,                    -- 0: Shows buffer name
              -- 1: Shows buffer index
              -- 2: Shows buffer name + buffer index
              -- 3: Shows buffer number
              -- 4: Shows buffer name + buffer number
              symbols = {
                modified = "", -- Text to show when the buffer is modified
                alternate_file = "", -- Text to show to identify the alternate file
                directory = "", -- Text to show when the buffer is a directory
              },
            },
          },
          lualine_y = {
          },
          lualine_z = {
            session_name,
            -- "branch",
            --[[ {
              "tabs",
              max_length = vim.o.columns / 3, -- Maximum width of tabs component.
              -- Note:
              -- It can also be a function that returns
              -- the value of `max_length` dynamically.
              mode = 1, -- 0: Shows tab_nr
              -- 1: Shows tab_name
              -- 2: Shows tab_nr + tab_name
            }, ]]
          },
        },
        extensions = { "neo-tree", "lazy" },
      })
    end,
  },
  {
    "luukvbaal/statuscol.nvim",
    -- lazy = false,
    enabled = false,
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        setopt = true, -- Whether to set the 'statuscolumn' option, may be set to false for those who
        -- want to use the click handlers in their own 'statuscolumn': _G.Sc[SFL]a().
        -- Although I recommend just using the segments field below to build your
        -- statuscolumn to benefit from the performance optimizations in this plugin.
        -- builtin.lnumfunc number string options
        thousands = false,   -- or line number thousands separator string ("." / ",")
        relculright = false, -- whether to right-align the cursor line number with 'relativenumber' set
        -- Builtin 'statuscolumn' options
        ft_ignore = nil,     -- lua table with 'filetype' values for which 'statuscolumn' will be unset
        bt_ignore = nil,     -- lua table with 'buftype' values for which 'statuscolumn' will be unset
        -- Default segments (fold -> sign -> line number + separator), explained below
        segments = {
          { text = { "%C" }, click = "v:lua.ScFa" },
          { text = { "%s" }, click = "v:lua.ScSa" },
          {
            text = { builtin.lnumfunc, " " },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
          }
        },
        clickmod = "c",   -- modifier used for certain actions in the builtin clickhandlers:
        -- "a" for Alt, "c" for Ctrl and "m" for Meta.
        clickhandlers = { -- builtin click handlers
          Lnum                   = builtin.lnum_click,
          FoldClose              = builtin.foldclose_click,
          FoldOpen               = builtin.foldopen_click,
          FoldOther              = builtin.foldother_click,
          DapBreakpointRejected  = builtin.toggle_breakpoint,
          DapBreakpoint          = builtin.toggle_breakpoint,
          DapBreakpointCondition = builtin.toggle_breakpoint,
          ["diagnostic/signs"]   = builtin.diagnostic_click,
          gitsigns               = builtin.gitsigns_click,
        },
      })
    end,
  },
  {
    "shellRaining/hlchunk.nvim",
    -- event = "BufRead",
    -- enabled = false,
    dependencies = {
      -- "rcarriga/nvim-notify",
      -- "petertriho/nvim-scrollbar",
    },
    keys = {
      { "<leader>uh", "<cmd>EnableHL<cr>", desc = "Enable hlchunk" },
    },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
          use_treesitter = true,
          style = {
            { fg = "#806d9c" },
          },
        },
        indent = {
          enable = true,
          use_treesitter = true,
        },
        blank = {
          enable = true,
          chars = {
            " ",
          },
          style = {
            { bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("cursorline")), "bg", "gui") },
            { bg = "",                                                                         fg = "" },
          },
        },
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    dependencies = {
      "hiphish/rainbow-delimiters.nvim",
    },
    keys = {
      { "<leader>ui", "<cmd>IBLToggle<cr>",      desc = "toggle indent" },
      { "<leader>uf", "<cmd>IBLToggleScope<cr>", desc = "toggle scope" },
    },
    main = "ibl",
    -- opts = { },
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }
      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)
      vim.g.rainbow_delimiters = { highlight = highlight }

      require "ibl".setup({
        scope = {
          enabled = true,
          highlight = highlight,
        },
        indent = {
          highlight = highlight,
          char = ""
        },
        whitespace = {
          highlight = highlight,
          remove_blankline_trail = false,
        },
      })
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
  {
    "utilyre/sentiment.nvim",
    version = "*",
    event = "InsertEnter", -- keep for lazy loading
    opts = {
      pairs = {
        { "(", ")" },
        { "{", "}" },
        { "[", "]" },
      }, -- config
    },
    init = function()
      -- `matchparen.vim` needs to be disabled manually in case of lazy loading
      vim.g.loaded_matchparen = 1
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "NotifyBackground",
        fps = 60,
        icons = {
          -- Nalpha OTE:icons here
          DEBUG = "",
          ERROR = "",
          INFO = "",
          TRACE = "✎",
          WARN = "",
        },
        level = 2,
        minimum_width = 50,
        render = "default",
        stages = "slide",
        timeout = 2000,
        top_down = true,
      })
      vim.notify = require("notify")
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    enabled = false,
    cmd = "ScrollbarToggle",
    config = function()
      require("scrollbar").setup()
    end,
  },
  {
    "gorbit99/codewindow.nvim",
    enabled = false,
    keys = {
      {
        "<leader>um",
        function()
          require("codewindow").toggle_minimap()
        end,
        desc = "Minimap Toggle",
      },
      {
        "<leader>uM",
        function()
          require("codewindow").toggle_focus()
        end,
        desc = "Minimap Toggle",
      },
    },
    config = function()
      local codewindow = require("codewindow")
      codewindow.setup({
        exclude_filetypes = { "help" }, -- Choose certain filetypes to not show minimap on
        minimap_width = 5,              -- The width of the text part of the minimap
        use_lsp = true,                 -- Use the builtin LSP to show errors and warnings
        use_treesitter = false,         -- Use nvim-treesitter to highlight the code
        use_git = true,                 -- Show small dots to indicate git additions and deletions
        width_multiplier = 8,           -- How many characters one dot represents
        z_index = 1,                    -- The z-index the floating window will be on
        show_cursor = true,             -- Show the cursor position in the minimap
        window_border = "single",       -- The border style of the floating window (accepts all usual options)
      })
    end,
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    enabled = false,
    config = true,
    event = { "BufRead", "BufNewFile" },
  },
}
