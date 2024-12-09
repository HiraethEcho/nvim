return {
  {
    'mvllow/modes.nvim',
    tag = 'v0.2.0',
    event = "InsertEnter",
    config = function()
      require('modes').setup({
        colors = {
          bg = "", -- Optional bg param, defaults to Normal hl group
          copy = "#f5c359",
          delete = "#c75c6a",
          insert = "#78ccc5",
          visual = "#9745be",
        },
        -- Set opacity for cursorline and number background
        line_opacity = 0.2,
      })
    end
  },
  {
    'edluffy/hologram.nvim',
    enabled = false,
  },
  {
    'echasnovski/mini.starter',
    -- enabled = false,
    version = '*',
    event = "VimEnter",
    dependencies = {
      -- 'Shatur/neovim-session-manager',
      'rmagatti/auto-session',
      'echasnovski/mini.sessions',
    },
    config = function()
      local starter = require('mini.starter')
      starter.setup({
        evaluate_single = true,
        items = {
          starter.sections.sessions(4, true),
          starter.sections.recent_files(3, false),
          -- starter.sections.telescope(),
          -- starter.sections.recent_files(3, true), -- local
          starter.sections.builtin_actions(),
          { name = 'start up time', action = [[StartupTime]], section = 'Builtin actions' },
        },
        header = nil,
        content_hooks = {
          -- starter.gen_hook.adding_bullet(),
          -- starter.gen_hook.indexing('all', { 'Builtin actions' }),
          starter.gen_hook.padding(3, 2),
          starter.gen_hook.aligning('center', 'center'),
        },
      })
    end,
  },
  { -- lazy.nvim
    "goolord/alpha-nvim",
    enabled = false,
    dependencies = {
      "jedrzejboczar/possession.nvim",
      -- "nvim-telescope/telescope.nvim",
      -- "Shatur/neovim-session-manager",
    },
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.buttons.val = {
        (function()
          local group = { type = "group", opts = { spacing = 0 } }
          group.val = {
            {
              type = "text",
              val = "Sessions",
              opts = {
                position = "center",
              },
            },
          }
          local path = vim.fn.stdpath("data") .. "/sessions"
          local files = vim.split(vim.fn.glob(path .. "/*.json"), "\n")
          local i = 1
          for _, file in pairs(files) do
            local basename = vim.fs.basename(file):gsub("%.json", "")
            if basename ~= "config" and basename ~= "tmp" and basename ~= "blog" then
              -- if basename ~= "tmp" then
              local button =
                  dashboard.button(tostring(i), "● " .. basename, "<cmd>PLoad " .. basename .. "<cr>")
              table.insert(group.val, button)
              i = i + 1
              -- end
            end
          end
          return group
        end)(),
        dashboard.button("e", " " .. " New Files", "<cmd>enew<CR>"),
        dashboard.button("t", "󰃨 " .. " TMP", [[<cmd>PLoad tmp<CR>]]),
        -- dashboard.button("h", " " .. " history files", [[<cmd>Telescope oldfiles<CR>]]),
        -- dashboard.button("s", " " .. " Sessions", ":SessionManager load_session<CR>"),
        dashboard.button("c", " " .. " Nvim Config", [[<cmd>PLoad config<CR>]]),
        dashboard.button("b", "󰖟 " .. " blog", [[<cmd>PLoad blog<CR>]]),
        dashboard.button("l", "󰒲 " .. " Lazy", "<cmd>Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", "<cmd>qa<CR>"),
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
      require("alpha").setup(dashboard.opts)
      -- config = function()
      local alpha = require("alpha")
      local startify = require("alpha.themes.startify")

      startify.section.header.val = {
        [[                                   __                ]],
        [[      ___     ___    ___   __  __ /\_\    ___ ___    ]],
        [[     / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
        [[    /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
        [[    \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[     \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      }
      startify.section.top_buttons.val = {
        startify.button("e", " " .. " New Files", ":enew<CR>"),
        -- startify.button("s", "  Sessions", ":SessionManager load_session  <CR>"),
        -- startify.button("c", " " .. " Nvim Config", ":<cmd>e $MYVIMRC<CR>"),
        -- startify.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
      }
      startify.section.mru.val = { { type = "padding", val = 3 } }
      startify.section.mru_cwd.val = { { type = "padding", val = 3 } }
      startify.section.bottom_buttons.val = {
        startify.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
      }
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          -- startify.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })

      -- alpha.setup(startify.config)
    end,
  },
  {
    'gen740/SmoothCursor.nvim',
    lazy = false,
    enabled = false,
    config = function()
      require('smoothcursor').setup({
        type = "default", -- Cursor movement calculation method, choose "default", "exp" (exponential) or "matrix".
      })
    end
  },
  {
    'eandrju/cellular-automaton.nvim',
    keys = {
      { "<leader>uR", "<cmd>CellularAutomaton make_it_rain<cr>", desc = "Rain" },
      { "<leader>uG", "<cmd>CellularAutomaton game_of_life<cr>", desc = "Rain" },
    },
    config = function()
      -- vim.api.nvim_create_user_command("Rain", require("cellular-automaton").start_animation("make_it_rain"), {})
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
      vim.cmd("colorscheme nightfox")
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
    'b0o/incline.nvim',
    enabled = false,
    config = function()
      local helpers = require 'incline.helpers'
      local navic = require 'nvim-navic'
      local devicons = require 'nvim-web-devicons'
      require('incline').setup {
        window = {
          padding = 0,
          margin = { horizontal = 0, vertical = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
          if filename == '' then
            filename = '[No Name]'
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified

          local function get_diagnostic_label()
            local icons = { error = '', warn = '', info = '', hint = '󰌵' }
            local label = {}

            for severity, icon in pairs(icons) do
              local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
              if n > 0 then
                table.insert(label, { icon .. n .. ' ', group = 'DiagnosticSign' .. severity })
              end
            end
            if #label > 0 then
              table.insert(label, { '┊ ' })
            end
            return label
          end
          local res = {
            ft_icon and { ' ', ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or '',
            ' ',
            { filename,              gui = modified and 'bold,italic' or 'bold' },
            { get_diagnostic_label() },
            guibg = '#44406e',
          }
          if props.focused then
            for _, item in ipairs(navic.get_data(props.buf) or {}) do
              table.insert(res, {
                { ' > ',     group = 'NavicSeparator' },
                { item.icon, group = 'NavicIcons' .. item.type },
                { item.name, group = 'NavicText' },
              })
            end
          end
          table.insert(res, ' ')
          return res
        end,
      }
    end,
    -- Optional: Lazy load Incline
    event = 'VeryLazy',
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
      --[[ local function session_name()
        return require('possession.session').get_session_name() or ''
      end ]]
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "onedark",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          -- section_separators = { left = '', right = '' },
          -- component_separators = { left = '', right = '' },
          -- section_separators = { left = '', right = '' },
          -- component_separators = '',
          -- section_separators = '',
          -- section_separators = { left = '', right = '' },
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
            { "fancy_branch" },
            -- "branch",
            -- "fancy_lsp_servers",
          },
          lualine_b = {
            { "fancy_diff" },
          },
          lualine_c = {
            -- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            {
              "filename",
              file_status = true,    -- Displays file status (readonly status, modified status)
              newfile_status = true, -- Display new file status (new file means no write after created)
              path = 1,
              symbols = {
                modified = "", -- Text to show when the file is modified.
                readonly = "", -- Text to show when the file is non-modifiable or readonly.
                unnamed = "", -- Text to show for unnamed buffers.
                newfile = "", -- Text to show for newly created file before first write
              },
            },
          },
          lualine_x = {
            -- "searchcount",
            { "fancy_searchcount" },
          },
          -- lualine_y = { "filetype" },
          lualine_y = {},
          lualine_z = {
            "progress",
            -- "location",
            { "fancy_location" },
            --[[ function()
              return " " .. os.date("%R")
            end, ]]
          },
        },
        inactive_sections = {
          lualine_a = {
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          },
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
                modified = "", -- Text to show when the file is modified.
                readonly = "", -- Text to show when the file is non-modifiable or readonly.
                unnamed = "", -- Text to show for unnamed buffers.
                newfile = "", -- Text to show for newly created file before first write
              },
            },
          },
          lualine_c = {
            -- "diff",
          },
          lualine_x = {
            -- "fancy_diagnostics",
            -- "fancy_lsp_servers",
          },
          lualine_y = { "progress" },
          lualine_z = {},
        },

        winbar = {
          lualine_b = {
            -- "fancy_lsp_servers",
            "fancy_diagnostics",
          },
          lualine_c = {
            {
              "navic",
            },
          },
          -- lualine_x = { "filetype" },
        },

        tabline = {
          lualine_a = {
            {
              "tabs",
              max_length = vim.o.columns / 3, -- Maximum width of tabs component.
              mode = 1,                       -- 0: Shows tab_nr
              -- 1: Shows tab_name
              -- 2: Shows tab_nr + tab_name
            },
          },
          lualine_b = {
            -- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          },
          lualine_c = {
            {
              "windows",
              show_filename_only = true, -- Shows shortened relative path when set to false.
              show_modified_status = true, -- Shows indicator when the window is modified.
              symbols = {
                modified = "", -- Text to show when the file is modified.
                readonly = "", -- Text to show when the file is non-modifiable or readonly.
                unnamed = "", -- Text to show for unnamed buffers.
                newfile = "", -- Text to show for newly created file before first write
              },
              mode = 2,
            },
          },
          lualine_x = {
          },
          lualine_y = {
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
                directory = "", -- Text to show when the buffer is a directory
              },
            },
          },
          lualine_z = {
            -- session_name,
            { "fancy_cwd", substitute_home = true },
            {
              function()
                return require('auto-session.lib').current_session_name(true)
              end
            },
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
      })
    end,
  },
  {
    "shellRaining/hlchunk.nvim",
    -- event = "BufRead",
    -- enabled = false,
    dependencies = {
      -- "rcarriga/nvim-notify",
      "kevinhwang91/nvim-ufo",
      "petertriho/nvim-scrollbar",
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
