return {
  {
    "folke/lazy.nvim",
    version = "*",
  },
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      {
        "<C-f>",
        function()
          require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
        end,
        desc = "search and replace",
      },
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
  {
    "folke/flash.nvim",
    -- event = "VeryLazy",
    opts = {
      -- labels = "abcdefghijklmnopqrstuvwxyz",
      -- labels = "asdfghjklqwertyuiopzxcvbnm",
      labels = "asdfjklzxcvuioewr",
      search = {
        -- Each mode will take ignorecase and smartcase into account.
        -- * exact: exact match
        -- * search: regular search
        -- * fuzzy: fuzzy search
        -- * fun(str): custom function that returns a pattern
        --   For example, to only match at the beginning of a word:
        --   mode = function(str)
        --     return "\\<" .. str
        --   end,
        mode = "search", -- default exact
      },
      label = {
        -- Enable this to use rainbow colors to highlight labels
        -- Can be useful for visualizing Treesitter ranges.
        rainbow = {
          enabled = true, --default false
        },
      },
      -- You can override the default options for a specific mode.
      -- Use it with `require("flash").jump({mode = "forward"})`
      modes = {
        -- options used when flash is activated through
        -- `f`, `F`, `t`, `T`, `;` and `,` motions
        char = {
          enabled = true, -- default true
          -- by default all keymaps are enabled, but you can disable some of them,
          -- by removing them from the list.
          -- If you rather use another key, you can map them
          -- to something else, e.g., { [";"] = "L", [","] = H }
          keys = { "f", "F", ";", "," },
          -- keys = { "f", "F", "t", "T", ";", "," }, -- default
        },
        treesitter = {
          labels = "asdfjklzxcviouqwernm", -- default asdfghjklzxcvbnmqwertyuiop
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      -- { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      -- { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  {
    "phaazon/hop.nvim",
    -- event = "BufRead",
    -- enabled = false,
    keys = {
      -- {'<leader>j', "<cmd>lua require'hop'.hint_vertical()<cr>",  mode={"n","v"}},
      -- {'F', "<cmd>lua require'hop'.hint_char1()<cr>", mode={"n","v"}},
      -- { "f",               ":HopChar1<cr>",    desc = "Hop Char",    { noremap = true, silent = true } },
      { "W", ":HopWord<cr>", desc = "Hop Word", { noremap = true, silent = true } },
      { "<leader><space>", ":HopAnywhere<cr>", desc = "HopAnywhere", { noremap = true, silent = true } },
    },
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
        { "<leader>c", group = "copilot" },
        { "<leader>s", group = "search" },
        { "<leader>S", group = "Session" },
        { "<leader>x", group = "trouble" },
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
    -- enabled = false,
    event = "BufRead",
    keys = {
      -- Will use Telescope if installed or a vim.ui.select picker otherwise
      { "<leader>Sr", "<cmd>SessionSearch<CR>", desc = "Session search" },
      { "<leader>Ss", "<cmd>SessionSave<CR>", desc = "Save session" },
      { "<leader>Sa", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave" },
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
      vim.o.sessionoptions = "buffers,curdir,help,tabpages,terminal,localoptions"
    end,
  },
  {
    "echasnovski/mini.starter",
    -- enabled = false,
    version = "*",
    event = "VimEnter",
    dependencies = {
      -- 'rmagatti/auto-session',
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
          { name = "lazy.nvim", action = [[Lazy]], section = "actions" },
          { name = "quit", action = [[quit]], section = "actions" },
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
  {
    "echasnovski/mini.sessions",
    version = "*",
    -- enabled = false,
    opts = {
      directory = vim.fn.stdpath("state") .. "/sessions",
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    -- event = "LspAttach",
    event = "BufRead",
    enabled = false,
    dependencies = {
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
      vim.o.foldcolumn = "0" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
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
      { "gw", "<cmd>URLOpenUnderCursor<cr>", desc = "Open URL under cursor" },
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
      { "<C-f>",      function() require("spectre").open_file_search() end,                       desc = "toggle spectre" },
      { "<leader>sW", function() require("spectre").open_file_search({ select_word = true }) end, mode = { "x", "v" },    desc = "search word on current file" },
    },
  },
  {
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
        autosave_only_in_session = true, -- Always autosaves session. If true, only autosaves after a session is active.
        autoload_mode = config.AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
      })
    end,
  },
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
      allowed_dirs = {}, -- Table of dirs that the plugin will start and autoload from
      ignored_dirs = {}, -- Table of dirs that are ignored for starting and autoloading
    },
  },
  {
    "lowitea/aw-watcher.nvim",
    event = "BufRead",
    -- enabled = false,
    cmd = "AWStart",
    config = function()
      require("aw_watcher").setup({})
      vim.cmd([[ AWStart ]])
    end,
  },
  {
    "ActivityWatch/aw-watcher-vim",
    -- lazy = false,
    event = "BufRead",
    enabled = false,
    cmd = "AWStart",
    config = function()
      vim.cmd([[ AWStart ]])
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
  {
    "rainzm/flash-zh.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = "folke/flash.nvim",
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash-zh").jump({
            chinese_only = false,
          })
        end,
        desc = "Flash between Chinese",
      },
    },
  },
}
