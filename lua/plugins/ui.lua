return {
  {
    "stevearc/dressing.nvim",
    event = "BufReadPost",
    opts = {},
  },
  {
    "xiyaowong/nvim-transparent",
    cmd = "TransparentEnable",
    -- lazy=false,
    config = function()
      require("transparent").setup({})
    end,
  },
  {
    "neanias/everforest-nvim",
    enabled = false,
    version = false,
    event = "VimEnter",
    config = function()
      require("everforest").setup({
        ---Controls the "hardness" of the background. Options are "soft", "medium" or "hard".
        background = "soft",
        transparent_background_level = 0,
        italics = true,
        dim_inactive_windows = true,
        diagnostic_virtual_text = "grey",
        ---Some plugins support highlighting error/warning/info/hint lines, but this
        ---feature is disabled by default in this colour scheme.
        diagnostic_line_highlight = true,
      })
      vim.cmd("colorscheme everforest")
    end,
  },
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
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
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "meuter/lualine-so-fancy.nvim",
    },
    event = "BufEnter",
    -- event = "VeryLazy",
    config = function()
      local function session_name()
        return require("possession.session").session_name or ""
      end
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "nordic",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {
              "neo-tree",
              "sagaoutline",
              "undotree",
            },
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
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
          lualine_c = {
            "branch",
            "fancy_diff",
          },
          lualine_x = { "fancy_diagnostics", "fancy_lsp_servers", "filetype" },
          lualine_y = { "progress", "location" },
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end,
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
            "branch",
          },
          lualine_c = {},
          lualine_x = { "progress" },
          lualine_y = { "Location" },
          lualine_z = {},
        },
        tabline = {
          lualine_a = {
            {
              "filename",
              symbols = {
                modified = "", -- Text to show when the file is modified.
                readonly = "", -- Text to show when the file is non-modifiable or readonly.
                unnamed = "", -- Text to show for unnamed buffers.
                newfile = "", -- Text to show for newly created file before first write
              },
            },
          },
          lualine_b = {
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
          lualine_c = {},

          lualine_x = {},
          lualine_y = {
            "windows",
          },
          lualine_z = {
            {
              "tabs",
              max_length = vim.o.columns / 3, -- Maximum width of tabs component.
              -- Note:
              -- It can also be a function that returns
              -- the value of `max_length` dynamically.
              mode = 0, -- 0: Shows tab_nr
              -- 1: Shows tab_name
              -- 2: Shows tab_nr + tab_name
            },
            session_name,
          },
        },
        extensions = { "neo-tree", "lazy" },
      })
    end,
  },
  { -- lazy.nvim
    "goolord/alpha-nvim",
    dependencies = {
      "jedrzejboczar/possession.nvim",
      "Shatur/neovim-session-manager",
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
        dashboard.button("e", " " .. " New Files", ":enew<CR>"),
        dashboard.button("t", "󰃨 " .. " TMP", [[<cmd>PLoad tmp<CR>]]),
        -- dashboard.button("s", " " .. " Sessions", ":SessionManager load_session<CR>"),
        dashboard.button("c", " " .. " Nvim Config", [[<cmd>PLoad config<CR>]]),
        dashboard.button("b", "󰖟 " .. " blog", [[<cmd>PLoad blog<CR>]]),
        dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
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
    "shellRaining/hlchunk.nvim",
    -- event = "BufRead",
    dependencies = {
      "rcarriga/nvim-notify",
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
          enable = false,
          use_treesitter = false,
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
    cmd = "ScrollbarToggle",
    config = function()
      require("scrollbar").setup()
    end,
  },
  {
    "gorbit99/codewindow.nvim",
    enabled = function()
      if vim.g.is_linux then
        return false
      else
        return true
      end
    end,
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
}
