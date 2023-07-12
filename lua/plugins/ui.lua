local transparent={
  "xiyaowong/nvim-transparent",
  cmd="TransparentEnable",
  -- lazy=false,
  config=function()
    require("transparent").setup({
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
          terminal = false, -- Enable contrast for the built-in terminal default=false
          sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree ) default=false
          floating_windows = true, -- Enable contrast for floating windows default=false
          cursor_line = true, -- Enable darker background for the cursor line default=false
          non_current_windows = true, -- Enable contrasted background for non-current windows default=false
        },
        plugins = { -- Uncomment the plugins that you use to highlight them
        -- Available plugins:
        -- "dap",
        "gitsigns",
        "hop",
        -- "indent-blankline",
        "lspsaga",
        -- "mini",
        -- "neogit",
        -- "neorg",
        "nvim-cmp",
        "nvim-navic",
        -- "nvim-tree",
        "nvim-web-devicons",
        -- "sneak",
        "telescope",
        -- "trouble",
        "which-key",
      },
        })
        vim.cmd 'colorscheme material'
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
  event = "BufRead",
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
          statusline = {'neo-tree'},
          -- winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
        }
      },
      sections = {
        lualine_a={'mode'},
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
        },
        lualine_c = {'branch','diff'},
        lualine_x = {'selectioncount','filetype','filesize'},
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

        lualine_x = {'windows'},
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
    --local logo = [[
----:::::::::..::::::..:..........::-==..-+-:-+==+---
---=-:::-::::..:::::..::..:.         .:..-=--+=++*=+*
--**=::--:::......:...   ..  .         ..::..:-+*++*+
--=-=------=-:::-:..    :=+=:           .::..:---===+
----===-----=--:..     :-=++=:.          .-:.::::-:--
---=++===+=-:..       ..-:==-=-.           ...-+:-===
----:-=---:           .:-.=+=++:         .:..::-:-+=:
---::-===:--:          :-:=++**.       .:::..:-=+==+-
---=--=++--==-:         ---=+*+       .:::..-==*+++##
--=+*=++=-=-:----:.     :-=+*##- ..   :::. .-----=++*
-----===+----------::..:-==+*####*=-.:::  .::::-----=
-----::-+=-::::::=+=++++++***#####%###*===-:::-:::---
--::-::--:-:::-+**##+=++**######%%#++****+::-:--:-==-
--:::::::::--:=**###+======+**#%#****+=-+#:::--=::--=
----:::.--==-:=+++=--==+++++++*++*+=---+#%=--:-------
----:::::::::-=++=-::::::--===+===-:=+*###=-+=-------
--::-::::-----==+=:::..::::---=+=::+*+*##*-:=+===----
--:::::.:::::--=-::-::==++=--=++++#%*=*##*:::::----==
--:::::.:::::-===::==+**##%*=-==+**#==*##*=--:-==--==
--::::::::::::==-:-===+*##%%+=--=+##==**#+:---==+=---
--:-::...::::-=---==-=+*##%%*=---=+#%%%##=::::::----=
--:--::::.:::----===-=+*##%%%++=-:-=+*###-::::::-:-:-
--::-::::....:::===--=+*##%%%#*+=-:--=++=:::::::::-:-
--..:::::.....:====--===*#%%%%***+..::::::::::::::---
--::::.:::.:..-=====--==+##%%%###*:...:::::::::::::::
--:::--.::.::-======---==*##%%%##%= ::::::::::::::-::
--::.:::-:.:-=======---=-=*#%%%##%*:-:.:::..::.:::=-:
--:..:.::..:=====-----=++-+##%%###%=::....:::::::::-:
--:.:..:::::----------=*#==*##%%%%%#:::::::.:.:::::..
--...::::---:---------==-=+=*##%%%%%-::::...:::::--::
--:::-:-----:::::::::::.-+*==*##%%%%+::.:::.::::::-::
--::::::::--:....::::..=####++**#%##*+-::::.::::::::-
--.::::::::..... ...  :**##%%*+**##**++=:::..::-:::::
--::::::........     .-+*#%%%%=+*#%#+++=+-::::-::::::
--:::::-:::::........ =*#%%%%%+-+**%%**+++=.:::::::::
--:----------:::::...-*%%%%%#%+:+**#%%*+++=-::::::..:
--..:::::---------=+#%%#%####*:.+#**###+++=+=::..::::
--.:::::::---=+##%%%%%%###*++:::-=+***##+++++=:::::::
------:-----:::+*+*##%##*::--=--=::-====**++==-::::::
--==:--::--:------+-===**-====:.:-=--===+*++-==-:-::-
    --]]

    --local logo = [[
    --]]
    -- dashboard.section.header.val = vim.split(logo, "\n")
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
          if basename ~= "config" and basename ~= "tmp" and basename ~="blog" then
            -- if basename ~= "tmp" then
            local button = dashboard.button(tostring(i), "● " .. basename, "<cmd>PLoad " .. basename .. "<cr>")
            table.insert(group.val, button)
            i = i + 1
            -- end
          end
        end
        return group
      end)(),
      -- dashboard.button("f", " " .. " Find Files",
      -- [[<cmd>lua Util.telescope("find_files", { prompt_title = "Find Files (cwd)", })() <CR>]]),
      dashboard.button("e", " " .. " New Files", ":enew<CR>"),
      -- dashboard.button("o", " " .. " Recent Files", ":Telescope frecency <CR>"),
      -- dashboard.button("g", " " .. " Find Text", ":Telescope live_grep <CR>"),
      dashboard.button("t", "󰃨 " .. " TMP", [[<cmd>PLoad tmp<CR>]]),
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

local hlchunk={
  "shellRaining/hlchunk.nvim",
  event = "BufReadPost",
  init = function()
    require('hlchunk').setup({
      exclude_filetypes = {
        aerial = true,
        dashboard = true,
        glow = true,
      },
      chunk = {
        enable = true,
        use_treesitter = true,
        style = {
          { fg = "#806d9c" },
        },
      },
      indent = {
        chars = { "│", "¦", "┆", "┊", },
        use_treesitter = false,
      },
      blank = {
        enable = false,
      },
      line_num = {
        use_treesitter = true,
      },
    })
  end,
}

local notify={
  'rcarriga/nvim-notify',
  -- lazy=false,
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

local scrollbar={
  'petertriho/nvim-scrollbar',
  -- lazy =false,
  cmd = "ScrollbarToggle",
  config = function()
    require("scrollbar").setup()
  end,
}

local scrollview={
  'dstein64/nvim-scrollview',
  cmd = "ScrollViewToggle",
  config = function()
    require('scrollview').setup({
      current_only = true,
      winblend = 75,
      base = 'buffer',
      signs_on_startup = {'all'},
      diagnostics_severities = {vim.diagnostic.severity.ERROR}
    })
    vim.g.scrollview_current_only = true
    vim.g.scrollview_winblend = 75
    vim.g.scrollview_base = 'buffer'
    vim.g.scrollview_column = 80
  end,
}

local codewindow={
  'gorbit99/codewindow.nvim',
  keys={
    { "<leader>m", function() require('codewindow').toggle_minimap() end , desc = "Minimap Toggle" },
    { "<leader>M", function() require('codewindow').toggle_focus() end , desc = "Minimap Toggle" },
  },
  -- codewindow.open_minimap()
  -- codewindow.close_minimap()
  -- codewindow.toggle_minimap()
  -- codewindow.toggle_focus()
  config = function()
    local codewindow = require('codewindow')
    codewindow.setup({
      active_in_terminals = false, -- Should the minimap activate for terminal buffers
      auto_enable = false, -- Automatically open the minimap when entering a (non-excluded) buffer (accepts a table of filetypes)
      exclude_filetypes = { 'help' }, -- Choose certain filetypes to not show minimap on
      max_minimap_height = nil, -- The maximum height the minimap can take (including borders)
      max_lines = nil, -- If auto_enable is true, don't open the minimap for buffers which have more than this many lines.
      minimap_width = 20, -- The width of the text part of the minimap
      use_lsp = true, -- Use the builtin LSP to show errors and warnings
      use_treesitter = true, -- Use nvim-treesitter to highlight the code
      use_git = true, -- Show small dots to indicate git additions and deletions
      width_multiplier = 4, -- How many characters one dot represents
      z_index = 1, -- The z-index the floating window will be on
      show_cursor = true, -- Show the cursor position in the minimap
      window_border = 'single', -- The border style of the floating window (accepts all usual options)
      relative = "win", -- What will be the minimap be placed relative to, "win": the current window, "editor": the entire editor
      events = { 'TextChanged', 'InsertLeave', 'DiagnosticChanged', 'FileWritePost' },-- Events that update the code window
    })
    -- codewindow.apply_default_keybinds()
  end,
}

local satellite={
  'lewis6991/satellite.nvim',
  cmd='SatelliteEnable',
  config=function()
  require('satellite').setup {
    winblend = 50,
    zindex = 40,
    excluded_filetypes = {},
    width = 2,
    handlers = {
      cursor = {
        enable = true,
        -- Supports any number of symbols
        symbols = { '⎺', '⎻', '⎼', '⎽' }
        -- symbols = { '⎻', '⎼' }
        -- Highlights:
        -- - SatelliteCursor (default links to NonText
        },
      gitsigns = {
        enable = true,
        signs = { -- can only be a single character (multibyte is okay)
        add = "+",
        change = "~",
        delete = "-",
        },
      },
    },
  }
  end,
}

local spec={
  color,
  transparent,
  line,
  hlchunk,
  alpha,
  notify,
  scrollbar,
  -- scrollview,
  codewindow,
  -- satellite,
}

return spec
