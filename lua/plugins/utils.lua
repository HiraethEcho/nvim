return {
  {
    "folke/lazy.nvim",
    version = "*",
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    dependencies = {
      "Shatur/neovim-session-manager",
      -- "olimorris/persisted.nvim",
    },
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        sections = {
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
      explorer = { enabled = true },
      indent = { enabled = false },
      input = { enabled = true },
      notifier = { enabled = true, },
      picker = {
        sources = {
          explorer = {
            -- layout = { layout = { position = "right" } },
            win = {
              list = {
                keys = {
                  ["."] = "tcd",
                  ["zh"] = "toggle_hidden",
                },
              },
            },
          },
        },
        layout = {
          cycle = false,
        },
        matcher = {
          frecency = true,
          history_bonus = true,
        },
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n" } },
              ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
              ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["<c-b>"] = { "list_scroll_up", mode = { "i", "n" } },
              ["<c-f>"] = { "list_scroll_down", mode = { "i", "n" } },
            },
          },
        },
      },
      quickfile = { enabled = true },
      scope = { enabled = true },
      debug = { enabled = false },
      scroll = { enabled = false },
      lazygit = { enabled = true },
      statuscolumn = {
        enabled = true,
        left = {},                 -- priority of signs on the left (high to low)
      },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true } -- Wrap notifications
        },
      },
    },
    keys = {
      -- Top Pickers & Explorer
      { "<leader>ff", function() Snacks.picker.smart() end,                                                  desc = "Smart Find Files", },
      { "<leader>b",  function() Snacks.picker.buffers() end,                                                desc = "Buffers", },
      { "<leader>/",  function() Snacks.picker.grep() end,                                                   desc = "Grep", },
      { "<leader>:",  function() Snacks.picker.command_history() end,                                        desc = "Command History", },
      { "<leader>e",  function() Snacks.explorer() end,                                                      desc = "File Explorer", },
      -- find
      { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,                desc = "Find Config File", },
      { "<leader>fp", function() Snacks.picker.projects() end,                                               desc = "Projects", },
      { "<leader>fr", function() Snacks.picker.recent() end,                                                 desc = "Recent", },
      -- git
      { "<leader>gB", function() Snacks.gitbrowse() end,                                                     desc = "Git Browse",                mode = { "n", "v" }, },
      { "<leader>gg", function() Snacks.lazygit() end,                                                       desc = "Lazygit", },
      { "<leader>gb", function() Snacks.picker.git_branches() end,                                           desc = "Git Branches", },
      { "<leader>gl", function() Snacks.picker.git_log() end,                                                desc = "Git Log", },
      { "<leader>gL", function() Snacks.picker.git_log_line() end,                                           desc = "Git Log Line", },
      { "<leader>gs", function() Snacks.picker.git_status() end,                                             desc = "Git Status", },
      { "<leader>gS", function() Snacks.picker.git_stash() end,                                              desc = "Git Stash", },
      { "<leader>gd", function() Snacks.picker.git_diff() end,                                               desc = "Git Diff (Hunks)", },
      { "<leader>gf", function() Snacks.picker.git_log_file() end,                                           desc = "Git Log File", },
      -- Grep
      { "<leader>sb", function() Snacks.picker.lines() end,                                                  desc = "Buffer Lines", },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end,                                           desc = "Grep Open Buffers", },
      -- { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" }, },
      -- search
      { '<leader>"',  function() Snacks.picker.registers() end,                                              desc = "Registers", },
      { "<leader>s/", function() Snacks.picker.search_history() end,                                         desc = "Search History", },
      { "<leader>sa", function() Snacks.picker.autocmds() end,                                               desc = "Autocmds", },
      { "<leader>sC", function() Snacks.picker.commands() end,                                               desc = "Commands", },
      { "<leader>sd", function() Snacks.picker.diagnostics() end,                                            desc = "Diagnostics", },
      { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end,                                     desc = "Buffer Diagnostics", },
      { "<leader>sh", function() Snacks.picker.help() end,                                                   desc = "Help Pages", },
      { "<leader>sH", function() Snacks.picker.highlights() end,                                             desc = "Highlights", },
      { "<leader>si", function() Snacks.picker.icons() end,                                                  desc = "Icons", },
      { "<leader>j",  function() Snacks.picker.jumps() end,                                                  desc = "Jumps", },
      { "<leader>sk", function() Snacks.picker.keymaps() end,                                                desc = "Keymaps", },
      { "<leader>m",  function() Snacks.picker.marks() end,                                                  desc = "Marks", },
      { "<leader>sM", function() Snacks.picker.man() end,                                                    desc = "Man Pages", },
      { "<leader>sp", function() Snacks.picker.lazy() end,                                                   desc = "Search for Plugin Spec", },
      { "<leader>sq", function() Snacks.picker.qflist() end,                                                 desc = "Quickfix List", },
      { "<leader>sl", function() Snacks.picker.loclist() end,                                                desc = "Location List", },
      { "<leader>ss", function() Snacks.picker.resume() end,                                                 desc = "Resume", },
      { "<leader>su", function() Snacks.picker.undo() end,                                                   desc = "Undo History", },
      { "<leader>uC", function() Snacks.picker.colorschemes() end,                                           desc = "Colorschemes", },
      -- LSP
      { "gd",         function() Snacks.picker.lsp_definitions() end,                                        desc = "Goto Definition", },
      { "gD",         function() Snacks.picker.lsp_declarations() end,                                       desc = "Goto Declaration", },
      { "gr",         function() Snacks.picker.lsp_references() end,                                         nowait = true,                      desc = "References", },
      { "gI",         function() Snacks.picker.lsp_implementations() end,                                    desc = "Goto Implementation", },
      { "gy",         function() Snacks.picker.lsp_type_definitions() end,                                   desc = "Goto T[y]pe Definition", },
      -- { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols", },
      { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end,                                  desc = "LSP Workspace Symbols", },
      -- Other
      { "<leader>z",  function() Snacks.zen() end,                                                           desc = "Toggle Zen Mode", },
      { "<leader>Z",  function() Snacks.zen.zoom() end,                                                      desc = "Toggle Zoom", },
      { "<leader>n",  function() Snacks.notifier.show_history() end,                                         desc = "Notification History", },
      { "<leader>cR", function() Snacks.rename.rename_file() end,                                            desc = "Rename File", },

      { "<leader>n",  function() Snacks.picker.notifications() end,                                          desc = "Notification History", },
      { "<leader>un", function() Snacks.notifier.hide() end,                                                 desc = "Dismiss All Notifications", },
      { "<c-/>",      function() Snacks.terminal() end,                                                      desc = "Toggle Terminal", },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end,                                        desc = "Next Reference",            mode = { "n", "t" }, },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end,                                       desc = "Prev Reference",            mode = { "n", "t" }, },

      { "<leader>iT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.indent():map("<leader>ug")
        end,
      })
    end,
  },
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      { "<C-f>", function() require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } }) end, desc = "search and replace", },
    },
    config = function()
      require("grug-far").setup({
        -- options, see Configuration section below
        -- there are no required options atm
        -- engine = 'ripgrep' is default, but 'astgrep' can be specified
      })
    end,
  },
  {
    "OXY2DEV/helpview.nvim",
    ft = "help",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "lambdalisue/suda.vim",
    cmd = { "SudaRead", "SudaWrite" },
  },
  {
    "gelguy/wilder.nvim",
    -- enabled = false,
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
        max_height = "75%",      -- max height of the palette
        min_height = 0,          -- set to the same as 'max_height' for a fixed height window
        prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
        pumblend = 20,
        reverse = 0,             -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
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
  {
    "phaazon/hop.nvim",
    -- event = "BufRead",
    keys = {
      -- {'<leader>j', "<cmd>lua require'hop'.hint_vertical()<cr>",  mode={"n","v"}},
      -- {'F', "<cmd>lua require'hop'.hint_char1()<cr>", mode={"n","v"}},
      { "f",                ":HopChar1<cr>",    desc = "Hop Char",    { noremap = true, silent = true } },
      { "F",                ":HopWord<cr>",     desc = "Hop Word",    { noremap = true, silent = true } },
      { "<leader><leader>", ":HopAnywhere<cr>", desc = "HopAnywhere", { noremap = true, silent = true } },
    },
    -- TODO: more keys
    config = function()
      require("hop").setup()
    end,
  },
  {
    "folke/which-key.nvim",
    cmd = "WhichKey",
    keys = {
      {
        "?",
        function()
          require("which-key").show()
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    event = "BufRead",
    opts = {
      preset = "classic",
      layout = {
        align = "center", -- align columns left, center or right
      },
    },
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      local wk = require("which-key")
      wk.add({
        { "<leader>i", group = "list" },
        { "<leader>D", group = "Diff" },
        { "<leader>u", group = "ui" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>l", group = "lsp" },
        { "<leader>m", group = "markdown" },
        { "<leader>h", group = "hunk" },
        { "<leader>c", group = "Copilot" },
        -- { "m", group = "bookmark", },
      })
    end,
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    "rmagatti/auto-session",
    enabled = false,
    event = "BufRead",
    config = function()
      require("auto-session").setup({
        -- log_level = "error",
        --[[ pre_save_cmds = {
          "tabdo Neotree close" -- Close NERDTree before saving session
        }, ]]
        post_cwd_changed_cmds = {
          function()
            require("lualine").refresh() -- example refreshing the lualine status line _after_ the cwd changes
          end,
        },
        auto_session_root_dir = vim.fn.stdpath("state") .. "/sessions/",
        auto_create = false,
        auto_save = true, -- Enables/disables auto saving session on exit
        previewer = true, -- File preview for session picker
        mappings = {
          delete_session = { "n", "d" },
          alternate_session = { "n", "<CR>" },
          copy_session = { "n", "Y" },
        },
      })
      vim.keymap.set("n", "<leader>is", require("auto-session.session-lens").search_session, { noremap = true })
      vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,terminal,localoptions"
    end,
  },
  {
    "echasnovski/mini.sessions",
    version = "*",
    enabled = false,
    opts = {
      directory = vim.fn.stdpath("data") .. "/sessions",
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "LspAttach",
    -- enabled = false,
    dependencies = {
      -- "luukvbaal/statuscol.nvim",
      "kevinhwang91/promise-async",
    },
    keys = {
      -- { "zR", function() require('ufo').openAllFolds() end,               desc = "Open All Folds" },
      -- { "zM", function() require('ufo').closeAllFolds() end,              desc = "Close All Folds" },
      -- { "zr", function() require('ufo').openFoldsExceptKinds() end,       desc = "Open Folds Except Kinds" },
      -- { "zm", function() require('ufo').closeFoldsWith() end,             desc = "Close Folds With" },
      {
        "KK",
        function()
          require("ufo").peekFoldedLinesUnderCursor()
        end,
        desc = "Peek Folded Lines Under Cursor",
      },
    },
    config = function()
      -- vim.o.foldcolumn = 'auto:3' -- '0' is not bad
      -- vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      local function customizeSelector(bufnr)
        local function handleFallbackException(err, providerName)
          if type(err) == "string" and err:match("UfoFallbackException") then
            return require("ufo").getFolds(bufnr, providerName)
          else
            return require("promise").reject(err)
          end
        end
        return require("ufo")
            .getFolds(bufnr, "lsp")
            :catch(function(err)
              return handleFallbackException(err, "treesitter")
            end)
            :catch(function(err)
              return handleFallbackException(err, "indent")
            end)
      end
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          -- return customizeSelector
          return { "treesitter", "indent" }
          -- return ''
        end,
        preview = {
          mappings = {
            scrollU = "<C-u>",
            scrollD = "<C-d>",
            jumpTop = "[",
            jumpBot = "]",
          },
        },
      })
      --[[ vim.keymap.set('n', 'K', function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end) ]]
    end,
  },
  {
    "axieax/urlview.nvim",
    -- enabled = false,
    -- lazy = false,
    cmd = "UrlView",
    keys = {
      { "<leader>iu", "<cmd>UrlView<cr>", desc = "List URL" },
      { "<leader>iL", "<cmd>UrlView<cr>", desc = "List Lazy plugin url" },
    },
    opts = {
      -- default_picker = "telescope",
    },
  },
  {
    "sontungexpt/url-open",
    -- enabled = false,
    branch = "mini",
    keys = {
      { "gw", "<esc>:URLOpenUnderCursor<cr>", desc = "Open URL under cursor" },
    },
    config = function()
      local status_ok, url_open = pcall(require, "url-open")
      if not status_ok then
        return
      end
      url_open.setup({})
    end,
  },
  -- disable
  {
    "nvim-pack/nvim-spectre",
    enabled = false,
    build = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<C-f>",     function() require("spectre").open_file_search() end,                       desc = "toggle spectre" },
      { "<leader>s", function() require("spectre").open_file_search({ select_word = true }) end, mode = { "x", "v" },    desc = "search word on current file" },
    },
  },
  {
    "jedrzejboczar/possession.nvim",
    enabled = false,
    -- lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("possession").setup({
        session_dir = vim.fn.stdpath("data") .. "/sessions",
        silent = false,
        load_silent = true,
        debug = false,
        logfile = false,
        prompt_no_cr = false,
        autosave = {
          current = true, -- or fun(name): boolean
          tmp = true,     -- or fun(): boolean
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
  {
    "Shatur/neovim-session-manager",
    -- enabled = false,
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
        autosave_only_in_session = true,              -- Always autosaves session. If true, only autosaves after a session is active.
        autoload_mode = config.AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
      })
    end,
  },
  -- Lua
  --
  {
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
  {
    "olimorris/persisted.nvim",
    enabled = false,
    opts = {
      save_dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- Directory where session files are saved
      allowed_dirs = {},                                                 -- Table of dirs that the plugin will start and autoload from
      ignored_dirs = {},                                                 -- Table of dirs that are ignored for starting and autoloading
    },
  },
  {
    "ActivityWatch/aw-watcher-vim",
    -- lazy = false,
    event = "BufRead",
    enabled = false,
    cmd = "AWStart",
  },
  {
    "matbme/JABS.nvim",
    -- lazy = false,
    enabled = false,
    keys = {
      { "<leader>b", "<cmd>JABSOpen<cr>", desc = "buffer lists" },
    },
    config = function()
      require("jabs").setup({
        -- options
        position = "center",      -- left or right
        symbols = {
          current = "C",          -- default 
          split = "S",            -- default 
          alternate = "A",        -- default 
          hidden = "H",           -- default ﬘
          locked = "L",           -- default 
          ro = "R",               -- default 
          edited = "E",           -- default 
          terminal = "T",         -- default 
          default_file = "D",     -- Filetype icon if not present in nvim-web-devicons. Default 
          terminal_symbol = ">_", -- Filetype icon for a terminal split. Default 
        },
        keymap = {
          close = "d",   -- Close buffer. Default D
          preview = "p", -- Open buffer preview. Default P
        },
      })
    end,
  },
  {
    "EL-MASTOR/bufferlist.nvim",
    -- lazy = true,
    enabled = false,
    keys = { { "<Leader>b", ":BufferList<CR>", desc = "Open bufferlist" } },
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = "BufferList",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      keymap = {
        close_buf_prefix = "c",
        force_close_buf_prefix = "f",
        save_buf = "s",
        multi_close_buf = "m",
        multi_save_buf = "w",
        save_all_unsaved = "a",
        close_all_saved = "d0",
        toggle_path = "p",
        close_bufferlist = "q",
      },
      win_keymaps = {}, -- add keymaps to the BufferList window
      bufs_keymaps = {}, -- add keymaps to each line number in the BufferList window
      width = 40,
      prompt = "", -- for multi_{close,save}_buf prompt
      save_prompt = "󰆓 ",
      top_prompt = true, -- set this to false if you want the prompt to be at the bottom of the window instead of on top of it.
      show_path = false, -- show the relative paths the first time BufferList window is opened
    },
  },
  {
    "ghillb/cybu.nvim",
    branch = "main", -- timely updates
    enabled = false,
    -- branch = "v1.x", -- won't receive breaking changes
    -- dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" }, -- optional for icon support
    -- lazy = false,
    config = function()
      require("cybu").setup({
        position = {
          relative_to = "win",  -- win, editor, cursor
          anchor = "topcenter", -- topleft, topcenter, topright,
          -- centerleft, center, centerright,
          -- bottomleft, bottomcenter, bottomright
          vertical_offset = 10,  -- vertical offset from anchor in lines
          horizontal_offset = 0, -- vertical offset from anchor in columns
          -- float for relative to win/editor width
        },
        behavior = { -- set behavior for different modes
          mode = {
            default = {
              switch = "immediate", -- immediate, on_close
              view = "rolling",     -- paging, rolling
            },
            last_used = {
              switch = "immediate", -- immediate, on_close
              view = "paging",      -- paging, rolling
            },
            auto = {
              view = "rolling", -- paging, rolling
            },
          },
          show_on_autocmd = false, -- event to trigger cybu (eg. "BufEnter")
        },
        display_time = 750,        -- time the cybu window is displayed
        exclude = {                -- filetypes, cybu will not be active
          "neo-tree",
          "fugitive",
          "qf",
        },
      })
      -- vim.keymap.set("n", "[b", "<Plug>(CybuPrev)")
      -- vim.keymap.set("n", "]b", "<Plug>(CybuNext)")
      -- vim.keymap.set("n", "<s-tab>", "<plug>(CybuLastusedPrev)")
      -- vim.keymap.set("n", "<tab>", "<plug>(CybuLastusedNext)")
      vim.keymap.set("n", "<s-tab>", "<plug>(CybuPrev)")
      vim.keymap.set("n", "<tab>", "<plug>(CybuNext)")
    end,
  },
  {
    "gh-liu/fold_line.nvim",
    event = "BufRead",
    enabled = false,
    config = function()
      -- change the char of the line, see the `Appearance` section
      vim.g.fold_line_char_open_start = "╭"
      vim.g.fold_line_char_open_end = "╰"
    end,
  },
  {
    "anuvyklack/pretty-fold.nvim",
    -- lazy = false,
    enabled = false,
    config = function()
      require("pretty-fold").setup()
    end,
  },
  {
    "echasnovski/mini.test",
    enabled = false,
    version = "*",
  },
  {
    "Zeioth/hot-reload.nvim",
    enabled = false,
    dependencies = "nvim-lua/plenary.nvim",
    event = "BufEnter",
    opts = {},
  },
  {
    "stevearc/quicker.nvim",
    enabled = false,
    lazy = false,
    event = "FileType qf",
    keys = {
      {
        "<leader>x",
        function()
          require("quicker").toggle()
        end,
        desc = "toggle quicker",
      },
    },
    opts = {},
  },
  {
    "rhysd/nyaovim-mini-browser",
    enabled = false,
    event = "CmdlineEnter",
    -- keys = {
    --   { "<leader>B", "<cmd>StartMarkdownPreview<cr>", desc = "markdown Html Preview" },
    -- },
  },
}
