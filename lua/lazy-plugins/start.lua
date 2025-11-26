vim.o.sessionoptions = "buffers,curdir,help,tabpages,terminal,localoptions,folds"
return {
  { -- "echasnovski/mini.starter",
    "echasnovski/mini.starter",
    -- enabled = false,
    version = "*",
    event = "VimEnter",
    dependencies = {
      "echasnovski/mini.sessions",
    },
    config = function()
      local starter = require("mini.starter")
      starter.setup({
        evaluate_single = true,
        items = {
          starter.sections.sessions(8, true),
          starter.sections.recent_files(5, false),
          -- starter.sections.telescope(),
          -- starter.sections.recent_files(3, true), -- local
          -- starter.sections.builtin_actions(),
          { name = "start up time", action = [[StartupTime]], section = "actions" },
          { name = "find files", action = [[lua Snacks.dashboard.pick('oldfiles')]], section = "actions" },
          { name = "lazy.nvim", action = [[Lazy]], section = "actions" },
          { name = "quit", action = [[quit]], section = "actions" },
          -- { name = "profile", action = [[lua Snacks.profiler.toggle()]], section = "actions" },
          { name = "new file", action = "enew", section = "actions" },
        },
        header = "",
        footer = "",
        content_hooks = {
          -- starter.gen_hook.adding_bullet(),
          starter.gen_hook.indexing("all", { "Sessions", "actions" }),
          -- starter.gen_hook.indexing('all', { 'Builtin actions' }),
          starter.gen_hook.padding(3, 2),
          starter.gen_hook.aligning("center", "center"),
        },
      })
    end,
  },
  { -- "goolord/alpha-nvim",
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
  { -- "echasnovski/mini.sessions",
    "echasnovski/mini.sessions",
    version = "*",
    -- cmd = { "SessionSave", "SessionSearch" },
    -- enabled = false,
    opts = {
      directory = vim.fn.stdpath("state") .. "/sessions",
    },
  },
  { -- "rmagatti/auto-session",
    "rmagatti/auto-session",
    -- enabled = false,
    event = "BufRead",
    keys = {
      -- Will use Telescope if installed or a vim.ui.select picker otherwise
      { "<leader>Ss", "<cmd>AutoSession search<CR>", desc = "Session search" },
      { "<leader>SS", "<cmd>AutoSession save<CR>", desc = "Save session" },
      { "<leader>Sa", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
    },
    config = function()
      require("auto-session").setup({
        post_cwd_changed_cmds = {
          function()
            require("lualine").refresh() -- example refreshing the lualine status line _after_ the cwd changes
          end,
        },
        auto_session_root_dir = vim.fn.stdpath("state") .. "/sessions/",
        auto_create = false,
        session_lens = {
          load_on_setup = false, -- Initialize on startup (requires Telescope)
          previewer = true, -- File preview for session picker
          mappings = {
            delete_session = { "n", "d" },
            alternate_session = { "n", "<CR>" },
            copy_session = { "n", "Y" },
          },
          session_control = {
            control_dir = vim.fn.stdpath("state") .. "/auto_session/", -- Auto session control dir, for control files, like alternating between two sessions with session-lens
            control_filename = "session_control.json", -- File name of the session control file
          },
        },
      })
    end,
  },
  { -- "dstein64/vim-startuptime",
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  { -- "folke/persistence.nvim",
    "folke/persistence.nvim",
    enabled = false,
    opts = {
      branch = false,
    },
    config = function()
      -- load the session for the current directory
      vim.keymap.set("n", "<leader>qs", function()
        require("persistence").load()
      end)

      -- select a session to load
      vim.keymap.set("n", "<leader>qS", function()
        require("persistence").select()
      end)

      -- load the last session
      vim.keymap.set("n", "<leader>ql", function()
        require("persistence").load({ last = true })
      end)

      -- stop Persistence => session won't be saved on exit
      vim.keymap.set("n", "<leader>qd", function()
        require("persistence").stop()
      end)
    end,
  },
  { -- "olimorris/persisted.nvim",
    "olimorris/persisted.nvim",
    enabled = false,
    opts = {
      save_dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- Directory where session files are saved
      allowed_dirs = {}, -- Table of dirs that the plugin will start and autoload from
      ignored_dirs = {}, -- Table of dirs that are ignored for starting and autoloading
    },
  },
  { -- "Shatur/neovim-session-manager",
    "Shatur/neovim-session-manager",
    enabled = false,
    dependencies = {
      "stevearc/dressing.nvim",
    },
    config = function()
      local config = require("session_manager.config")
      require("session_manager").setup({
        sessions_dir = vim.fn.stdpath("state") .. "/sessions/",
        autosave_last_session = true, -- Automatically save last session on exit and on session switch.
        autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
          "gitcommit",
          "gitrebase",
          "undotree",
          "neo-tree",
          "sagaoutline",
          "Outline",
        },
        autosave_only_in_session = true, -- Always autosaves session. If true, only autosaves after a session is active.
        autoload_mode = config.AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
      })
    end,
  },
  { -- "jedrzejboczar/possession.nvim",
    "jedrzejboczar/possession.nvim",
    enabled = false,
    -- lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("possession").setup({
        session_dir = vim.fn.stdpath("state") .. "/sessions",
        silent = false,
        load_silent = true,
        debug = false,
        logfile = false,
        prompt_no_cr = false,
        autosave = {
          current = true, -- or fun(name): boolean
          tmp = true, -- or fun(): boolean
          tmp_name = "tmp",
          on_load = true,
          on_quit = true,
        },
        commands = {
          save = "PSave",
          load = "PLoad",
          rename = "PRename",
          close = "PClose",
          delete = "PDelete",
          show = "PShow",
          list = "PList",
          migrate = "PMigrate",
        },
        hooks = {
          before_save = function(name)
            return {}
          end,
          after_save = function(name, user_data, aborted) end,
          before_load = function(name, user_data)
            return user_data
          end,
          after_load = function(name, user_data) end,
        },
        plugins = {
          close_windows = {
            hooks = { "before_save", "before_load" },
            preserve_layout = true, -- or fun(win): boolean
            match = {
              floating = true,
              buftype = {},
              filetype = {},
              custom = false, -- or fun(win): boolean
            },
          },
          delete_hidden_buffers = {
            hooks = {
              "before_load",
              vim.o.sessionoptions:match("buffer") and "before_save",
            },
            force = false, -- or fun(buf): boolean
          },
          nvim_tree = true,
          tabby = true,
          dap = true,
          delete_buffers = false,
        },
      })
    end,
  },
}
