---
title: lines
---
```lua
return {
  -- top and bottom
  { -- lualine
    "nvim-lualine/lualine.nvim",
    -- enabled = false,
    -- event = "BufEnter",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      -- "meuter/lualine-so-fancy.nvim",
      -- "Rics-Dev/flow",
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
        extensions = { "quickfix" },
        options = {
          theme = "OceanicNext",
          -- theme = "material",
          -- theme = "jellybeans",
          -- theme = "flow",
          -- component_separators = { left = "", right = "" },
          -- section_separators = { left = "", right = "" },
          -- section_separators = { left = '', right = '' },
          -- component_separators = { left = '', right = '' },
          -- section_separators = { left = '', right = '' },
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
            -- "branch",
            -- "fancy_lsp_servers",
          },
          lualine_b = {
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
          lualine_c = {
            -- { "fancy_diff" },
            "diff",
          },
          lualine_x = {
            --[[ {
              function()
                if not vim.g.loaded_mcphub then
                  return "󰐻 -"
                end
                local count = vim.g.mcphub_servers_count or 0
                local status = vim.g.mcphub_status or "stopped"
                local executing = vim.g.mcphub_executing
                if status == "stopped" then
                  return "󰐻 -"
                end
                if executing or status == "starting" or status == "restarting" then
                  local frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
                  local frame = math.floor(vim.loop.now() / 100) % #frames + 1
                  return "󰐻 " .. frames[frame]
                end
                return "󰐻 " .. count
              end,
              color = function()
                if not vim.g.loaded_mcphub then
                  return { fg = "#18181f" } -- Gray for not loaded
                end
                local status = vim.g.mcphub_status or "stopped"
                if status == "ready" or status == "restarted" then
                  return { fg = "#50fa7b" } -- Green for connected
                elseif status == "starting" or status == "restarting" then
                  return { fg = "#ffb86c" } -- Orange for connecting
                else
                  return { fg = "#ff5555" } -- Red for error/stopped
                end
              end,
            }, ]]
          },
          -- lualine_y = { "filetype" },
          lualine_y = {
            -- "lsp_status",
            { "%l/%L:%c" },
          },
          lualine_z = {
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
              path = 0, -- 0: Just the filename
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
        winbar = {},
        tabline = {
          lualine_a = {
            {
              "tabs",
              max_length = vim.o.columns / 3, -- Maximum width of tabs component.
              mode = 1, -- 0: Shows tab_nr
              symbols = {
                modified = "", -- Text to show when the file is modified.
                readonly = "", -- Text to show when the file is non-modifiable or readonly.
                unnamed = "", -- Text to show for unnamed buffers.
                newfile = "", -- Text to show for newly created file before first write
              },
              -- 1: Shows tab_name
              -- 2: Shows tab_nr + tab_name
            },
          },
          lualine_b = {
            -- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          },
          lualine_c = {
            {
              "buffers",
              show_filename_only = true, -- Shows shortened relative path when set to false.
              hide_filename_extension = true,
              show_modified_status = false, -- Shows indicator when the buffer is modified.
              mode = 2, -- 0: Shows buffer name 1: Shows buffer index 2: Shows buffer name + buffer index 3: Shows buffer number 4: Shows buffer name + buffer number

              symbols = {
                modified = "", -- Text to show when the file is modified.
                readonly = "", -- Text to show when the file is non-modifiable or readonly.
                unnamed = "", -- Text to show for unnamed buffers.
                newfile = "", -- Text to show for newly created file before first write
                alternate_file = "", -- Text to show to identify the alternate file
              },
            },
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
          lualine_x = {
            "lsp_status",
          },
          lualine_y = {
            cwd_fancy,
          },
          lualine_z = {
            "branch",
            {
              function()
                return require("auto-session.lib").current_session_name(true)
              end,
            },
          },
        },
      })
      vim.keymap.set("n", "<C-1>", "<cmd>LualineBuffersJump 1<CR>")
      vim.keymap.set("n", "<C-2>", "<cmd>LualineBuffersJump 2<CR>")
      vim.keymap.set("n", "<C-3>", "<cmd>LualineBuffersJump 3<CR>")
      vim.keymap.set("n", "<C-4>", "<cmd>LualineBuffersJump 4<CR>")
      vim.keymap.set("n", "<C-5>", "<cmd>LualineBuffersJump 5<CR>")
      vim.keymap.set("n", "<C-6>", "<cmd>LualineBuffersJump 6<CR>")
      vim.keymap.set("n", "<C-7>", "<cmd>LualineBuffersJump 7<CR>")
      vim.keymap.set("n", "<C-8>", "<cmd>LualineBuffersJump 8<CR>")
      vim.keymap.set("n", "<C-9>", "<cmd>LualineBuffersJump 9<CR>")
      vim.keymap.set("n", "<C-0>", "<cmd>LualineBuffersJump 10<CR>")
    end,
  },
  -- cmdline
  { -- "hachy/cmdpalette.nvim",
    "hachy/cmdpalette.nvim",
    enabled = false,
    event = "CmdlineEnter",
    config = function()
      require("cmdpalette").setup()
    end,
  },
  { -- wilder
    "gelguy/wilder.nvim",
    enabled = false,
    event = "CmdlineEnter",
    -- event = "CmdlineEnter",
    config = function()
      local wilder = require("wilder")
      wilder.setup({ modes = { ":", "/" } })
      -- wilder.setup({ modes = { "/" } })
      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.cmdline_pipeline({
            fuzzy = 1,
            set_pcre2_pattern = 1,
          }),
          wilder.python_search_pipeline({
            pattern = "fuzzy",
          })
        ),
      })
      local popupmenu_palette = wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
        border = "rounded",
        max_height = "75%", -- max height of the palette
        min_height = 0, -- set to the same as 'max_height' for a fixed height window
        prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
        pumblend = 20,
        reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
        winblend = 30,
        left = { " ", wilder.popupmenu_devicons() },
        right = { " ", wilder.popupmenu_scrollbar() },
      }))
      local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
        border = "rounded",
        pumblend = 20,
        winblend = 30,
        -- highlighter = highlighters,
        left = { " ", wilder.popupmenu_devicons() },
        right = { " ", wilder.popupmenu_scrollbar() },
      }))
      local wildmenu_renderer = wilder.wildmenu_renderer({
        separator = " · ",
        left = { " ", wilder.wildmenu_spinner(), " " },
        right = { " ", wilder.wildmenu_index() },
      })
      wilder.set_option(
        "renderer",
        wilder.renderer_mux({
          [":"] = popupmenu_palette,
          -- [':'] =popupmenu_renderer,
          ["/"] = wildmenu_renderer,
          substitute = wildmenu_renderer,
        })
      )
    end,
  },
  { -- "folke/noice.nvim",
    "folke/noice.nvim",
    enabled = false,
    event = "BufReadPost",
    -- event = {"InsertEnter","CmdlineEnter"},
    opts = {
      -- lsp = { progress = { enabled = false } },
      presets = {
        bottom_search = true,
      },
    },
    -- dependencies = { "MunifTanjim/nui.nvim" },
  },
  -- left
  { -- "luukvbaal/statuscol.nvim",
    "luukvbaal/statuscol.nvim",
    -- lazy = false,
    enabled = false,
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({})
    end,
  },
  -- right
  { -- "petertriho/nvim-scrollbar",
    "petertriho/nvim-scrollbar",
    enabled = false,
    cmd = "ScrollbarToggle",
    config = function()
      require("scrollbar").setup()
    end,
  },
  { -- "wsdjeg/scrollbar.vim",
    "wsdjeg/scrollbar.vim",
    enabled = false,
    event = "BufRead",
    config = function()
      require("scrollbar").setup()
    end,
  },
  { -- "gorbit99/codewindow.nvim",
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
    -- "Isrothy/neominimap.nvim",
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
  -- inside
  { -- "nvim-zh/colorful-winsep.nvim",
    "nvim-zh/colorful-winsep.nvim",
    enabled = false,
    config = true,
    event = { "BufRead", "BufNewFile" },
  },
  -- inside horizontal
  { -- "mvllow/modes.nvim",
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
  -- inside verticle
  { -- "shellRaining/hlchunk.nvim",
    "shellRaining/hlchunk.nvim",
    event = "BufRead",
    enabled = false,
    dependencies = {
      -- "rcarriga/nvim-notify",
      -- "kevinhwang91/nvim-ufo",
      -- "petertriho/nvim-scrollbar",
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
  { -- "lukas-reineke/indent-blankline.nvim",
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
}
```
