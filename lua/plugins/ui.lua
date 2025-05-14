return {
  {
    "mvllow/modes.nvim",
    enabled = false,
    tag = "v0.2.0",
    event = "InsertEnter",
    config = function()
      require("modes").setup({
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
    end,
  },
  {
    "eandrju/cellular-automaton.nvim",
    keys = {
      { "<leader>uR", "<cmd>CellularAutomaton make_it_rain<cr>", desc = "Rain" },
      { "<leader>uG", "<cmd>CellularAutomaton game_of_life<cr>", desc = "Rain" },
    },
    config = function()
      -- vim.api.nvim_create_user_command("Rain", require("cellular-automaton").start_animation("make_it_rain"), {})
    end,
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
    event = "BufReadPost",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      -- "meuter/lualine-so-fancy.nvim",
    },
    -- event = "BufRead",
    -- event = "VeryLazy",
    config = function()
      --[[ local function session_name()
        return require('possession.session').get_session_name() or ''
      end ]]
      local function cwd_fancy()
        local result = vim.fn.getcwd()
        local home = os.getenv("HOME")
        if home and vim.startswith(result, home) then
          result = "~" .. result:sub(home:len() + 1)
        end
        return result
      end
      -- vim.cmd("colorscheme github_dark")
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "nord",
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
            -- { "fancy_cwd", substitute_home = true },
            -- { "fancy_branch" },
            -- "filetype"
            "branch",
            -- "fancy_lsp_servers",
          },
          lualine_b = {
            -- { "fancy_diff" },
            "diff",
          },
          lualine_c = {
            -- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            {
              "filename",
              file_status = true, -- Displays file status (readonly status, modified status)
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
            "searchcount",
            -- { "fancy_searchcount" },
            -- "lsp_status",
          },
          -- lualine_y = { "filetype" },
          lualine_y = {
            -- "fancy_diagnostics",
            -- "fancy_lsp_servers",
          },
          lualine_z = {
            -- "progress",
            -- "location",
            {
              "%l/%L:%c",
            },
            -- { "fancy_location" },
            --[[ function()
              return " " .. os.date("%R")
            end, ]]
          },
        },
        inactive_sections = {
          lualine_a = {
            -- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          },
          lualine_b = {
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            {
              "filename",
              file_status = true, -- Displays file status (readonly status, modified status)
              newfile_status = true, -- Display new file status (new file means no write after created)
              path = 1, -- 0: Just the filename
              -- 1: Relative path
              -- 2: Absolute path
              -- 3: Absolute path, with tilde as the home directory
              shorting_target = 40, -- Shortens path to leave 40 spaces in the window
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
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
          --[[ lualine_b = {
            "fancy_lsp_servers",
            "fancy_diagnostics",
          },
          lualine_c = {
            {
              "navic",
            },
          },
          lualine_y = {
            "fancy_lsp_servers",
          },
          lualine_x = {
            "filetype",
            "fancy_diagnostics",
          },
          lualine_z = {
          }, ]]
        },
        tabline = {
          lualine_a = {
            cwd_fancy,
          },
          lualine_b = {
            {
              "buffers",
              show_filename_only = true, -- Shows shortened relative path when set to false.
              hide_filename_extension = true,
              show_modified_status = false, -- Shows indicator when the buffer is modified.
              mode = 2, -- 0: Shows buffer name 1: Shows buffer index 2: Shows buffer name + buffer index 3: Shows buffer number 4: Shows buffer name + buffer number
              symbols = {
                modified = "", -- Text to show when the buffer is modified
                alternate_file = "", -- Text to show to identify the alternate file
                directory = "", -- Text to show when the buffer is a directory
              },
            },
            -- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          },
          lualine_c = {
            --[[ {
              "windows",
              show_filename_only = true, -- Shows shortened relative path when set to false.
              show_modified_status = true, -- Shows indicator when the window is modified.
              symbols = {
                modified = "", -- Text to show when the file is modified.
                readonly = "", -- Text to show when the file is non-modifiable or readonly.
                unnamed = "", -- Text to show for unnamed buffers.
                newfile = "", -- Text to show for newly created file before first write
              },
              mode = 0,
            }, ]]
          },
          lualine_x = {},
          lualine_y = {
            -- { "fancy_cwd", substitute_home = true },
            {
              "tabs",
              max_length = vim.o.columns / 3, -- Maximum width of tabs component.
              mode = 1, -- 0: Shows tab_nr
              -- 1: Shows tab_name
              -- 2: Shows tab_nr + tab_name
            },
          },
          lualine_z = {
            -- session_name,
            -- cwd_fancy,
            {
              function()
                return require("auto-session.lib").current_session_name(true)
              end,
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
    "shellRaining/hlchunk.nvim",
    -- event = "BufRead",
    -- enabled = false,
    dependencies = {
      -- "rcarriga/nvim-notify",
      "kevinhwang91/nvim-ufo",
      "petertriho/nvim-scrollbar",
    },
    cmd = "EnableHL",
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
            { bg = "", fg = "" },
          },
        },
      })
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
  },
  {
    "rcarriga/nvim-notify",
    event = "BufRead",
    enabled = false,
    config = function()
      require("notify").setup({
        fps = 60,
        level = 2,
        render = "default",
        stages = "slide",
        timeout = 2000,
      })
      vim.notify = require("notify")
    end,
  },
  -- disable
  {
    "luukvbaal/statuscol.nvim",
    -- lazy = false,
    enabled = false,
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({})
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    dependencies = {
      "hiphish/rainbow-delimiters.nvim",
    },
    keys = {
      { "<leader>ui", "<cmd>IBLToggle<cr>", desc = "toggle indent" },
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
      local hooks = require("ibl.hooks")
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

      require("ibl").setup({
        scope = {
          enabled = true,
          highlight = highlight,
        },
        indent = {
          highlight = highlight,
          char = "",
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
    "folke/noice.nvim",
    enabled = false,
    event = "BufReadPost",
    opts = {
      -- add any options here
      -- cmdline = {enabled = false,}
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
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
    "wsdjeg/scrollbar.vim",
    enabled = false,
    event = "BufRead",
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
        minimap_width = 5, -- The width of the text part of the minimap
        use_lsp = true, -- Use the builtin LSP to show errors and warnings
        use_treesitter = false, -- Use nvim-treesitter to highlight the code
        use_git = true, -- Show small dots to indicate git additions and deletions
        width_multiplier = 8, -- How many characters one dot represents
        z_index = 1, -- The z-index the floating window will be on
        show_cursor = true, -- Show the cursor position in the minimap
        window_border = "single", -- The border style of the floating window (accepts all usual options)
      })
    end,
  },
  {
    "Isrothy/neominimap.nvim",
    version = "v3.*.*",
    enabled = false,
    -- lazy = false, -- NOTE: NO NEED to Lazy load
    -- Optional
    keys = {
      -- Global Minimap Controls
      { "<leader>nm", "<cmd>Neominimap toggle<cr>", desc = "Toggle global minimap" },
      { "<leader>no", "<cmd>Neominimap on<cr>", desc = "Enable global minimap" },
      { "<leader>nc", "<cmd>Neominimap off<cr>", desc = "Disable global minimap" },
      { "<leader>nr", "<cmd>Neominimap refresh<cr>", desc = "Refresh global minimap" },

      -- Window-Specific Minimap Controls
      { "<leader>nwt", "<cmd>Neominimap winToggle<cr>", desc = "Toggle minimap for current window" },
      { "<leader>nwr", "<cmd>Neominimap winRefresh<cr>", desc = "Refresh minimap for current window" },
      { "<leader>nwo", "<cmd>Neominimap winOn<cr>", desc = "Enable minimap for current window" },
      { "<leader>nwc", "<cmd>Neominimap winOff<cr>", desc = "Disable minimap for current window" },

      -- Tab-Specific Minimap Controls
      { "<leader>ntt", "<cmd>Neominimap tabToggle<cr>", desc = "Toggle minimap for current tab" },
      { "<leader>ntr", "<cmd>Neominimap tabRefresh<cr>", desc = "Refresh minimap for current tab" },
      { "<leader>nto", "<cmd>Neominimap tabOn<cr>", desc = "Enable minimap for current tab" },
      { "<leader>ntc", "<cmd>Neominimap tabOff<cr>", desc = "Disable minimap for current tab" },

      -- Buffer-Specific Minimap Controls
      { "<leader>nbt", "<cmd>Neominimap bufToggle<cr>", desc = "Toggle minimap for current buffer" },
      { "<leader>nbr", "<cmd>Neominimap bufRefresh<cr>", desc = "Refresh minimap for current buffer" },
      { "<leader>nbo", "<cmd>Neominimap bufOn<cr>", desc = "Enable minimap for current buffer" },
      { "<leader>nbc", "<cmd>Neominimap bufOff<cr>", desc = "Disable minimap for current buffer" },

      ---Focus Controls
      { "<leader>nf", "<cmd>Neominimap focus<cr>", desc = "Focus on minimap" },
      { "<leader>nu", "<cmd>Neominimap unfocus<cr>", desc = "Unfocus minimap" },
      { "<leader>ns", "<cmd>Neominimap toggleFocus<cr>", desc = "Switch focus on minimap" },
    },
    init = function()
      vim.g.neominimap = {
        auto_enable = false,
        layout = "split",
        split = {
          minimap_width = 20, ---@type integer
          fix_width = false, ---@type boolean
          ---@alias Neominimap.Config.SplitDirection "left" | "right"
          direction = "right", ---@type Neominimap.Config.SplitDirection
        },
      }
    end,
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    enabled = false,
    config = true,
    event = { "BufRead", "BufNewFile" },
  },
  {
    "edluffy/hologram.nvim",
    enabled = false,
  },
  {
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
              local button = dashboard.button(tostring(i), "● " .. basename, "<cmd>PLoad " .. basename .. "<cr>")
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
    "gen740/SmoothCursor.nvim",
    lazy = false,
    enabled = false,
    config = function()
      require("smoothcursor").setup({
        type = "default", -- Cursor movement calculation method, choose "default", "exp" (exponential) or "matrix".
      })
    end,
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
}
