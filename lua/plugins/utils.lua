return {
  { "folke/lazy.nvim", version = "*" },
  {
    "folke/snacks.nvim",
    enabled = false,
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      -- dashboard = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true } -- Wrap notifications
        }
      }
    },
    keys = {
      { "<leader>.",  function() Snacks.scratch() end,               desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end,        desc = "Select Scratch Buffer" },
      { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
      -- { "<leader>bd", function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
      { "<leader>cR", function() Snacks.rename.rename_file() end,    desc = "Rename File" },
      { "<leader>gW", function() Snacks.gitbrowse() end,             desc = "Git Browse" },
      { "<leader>gb", function() Snacks.git.blame_line() end,        desc = "Git Blame Line" },
      { "<leader>gf", function() Snacks.lazygit.log_file() end,      desc = "Lazygit Current File History" },
      { "<leader>gg", function() Snacks.lazygit() end,               desc = "Lazygit" },
      { "<leader>gl", function() Snacks.lazygit.log() end,           desc = "Lazygit Log (cwd)" },
      { "<leader>un", function() Snacks.notifier.hide() end,         desc = "Dismiss All Notifications" },
      { "<c-/>",      function() Snacks.terminal() end,              desc = "Toggle Terminal" },
      { "<c-_>",      function() Snacks.terminal() end,              desc = "which_key_ignore" },
      -- { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",              mode = { "n", "t" } },
      -- { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",              mode = { "n", "t" } },
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
      }
    },
    init = function()
      require("snacks").scratch({ ft = "markdown" })
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
            "<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
        end,
      })
    end,
  },
  {
    'stevearc/quicker.nvim',
    enabled = false,
    lazy = false,
    event = "FileType qf",
    keys = {
      { "<leader>x", function() require("quicker").toggle() end, desc = "toggle quicker" },
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
    "folke/which-key.nvim",
    cmd = "WhichKey",
    keys = {
      { "?", function() require("which-key").show() end, desc = "Buffer Local Keymaps (which-key)" },
    },
    event = "VeryLazy",
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
        { "<leader>i", group = "list", },
        { "<leader>D", group = "Diff", },
        { "<leader>u", group = "ui", },
        { "<leader>f", group = "find", },
        { "<leader>g", group = "git", },
        { "<leader>l", group = "lsp", },
        { "<leader>m", group = "markdown", },
        { "<leader>h", group = "hunk", },
        { "<leader>c", group = "Copilot", },
        -- { "m", group = "bookmark", },
      })
    end,
  },
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
    'MagicDuck/grug-far.nvim',
    keys = {
      { "<C-f>", function() require('grug-far').open({ prefills = { paths = vim.fn.expand("%") } }) end, desc = "search and replace" },
    },
    config = function()
      require('grug-far').setup({
        -- options, see Configuration section below
        -- there are no required options atm
        -- engine = 'ripgrep' is default, but 'astgrep' can be specified
      });
    end
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    'rmagatti/auto-session',
    enabled = false,
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/github", "~/documents" },
        auto_session_root_dir = vim.fn.stdpath('data') .. "/autosessions/",
        auto_session_enabled = true,
      }
      vim.keymap.set("n", "<leader>fs", require("auto-session.session-lens").search_session, { noremap = true, })
    end
  },
  {
    'Shatur/neovim-session-manager',
    enabled = false,
    dependencies = {
      'stevearc/dressing.nvim',
    },
    config = function()
      local config = require('session_manager.config')
      require('session_manager').setup({
        sessions_dir = vim.fn.stdpath('data') .. '/autosessions/', -- The directory where the session files will be saved.
        autosave_last_session = true,                              -- Automatically save last session on exit and on session switch.
        autosave_ignore_dirs = {},                                 -- A list of directories where the session will not be autosaved.
        autosave_ignore_filetypes = {                              -- All buffers of these file types will be closed before the session is saved.
          'gitcommit',
          'gitrebase',
          'undotree',
          'neo-tree',
          "sagaoutline",
          "Outline",
        },
        autosave_only_in_session = false,             -- Always autosaves session. If true, only autosaves after a session is active.
        autoload_mode = config.AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
      })
    end,
  },
  {
    'ActivityWatch/aw-watcher-vim',
    -- lazy = false,
    event = "VimEnter",
    -- enabled = false,
    cmd = "AWStart",
  },
  {
    'matbme/JABS.nvim',
    -- lazy = false,
    keys = {
      { "<leader>b", "<cmd>JABSOpen<cr>", desc = "buffer lists" },
    },
    config = function()
      require('jabs').setup({
        -- options
        position = 'center',     -- left or right
        symbols = {
          current = "C",         -- default 
          split = "S",           -- default 
          alternate = "A",       -- default 
          hidden = "H",          -- default ﬘
          locked = "L",          -- default 
          ro = "R",              -- default 
          edited = "E",          -- default 
          terminal = "T",        -- default 
          default_file = "D",    -- Filetype icon if not present in nvim-web-devicons. Default 
          terminal_symbol = ">_" -- Filetype icon for a terminal split. Default 
        },
        keymap = {
          close = "d",   -- Close buffer. Default D
          preview = "p", -- Open buffer preview. Default P
        },
      })
    end,
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
    "kevinhwang91/nvim-ufo",
    -- enabled = false,
    dependencies = {
      -- "luukvbaal/statuscol.nvim",
      "kevinhwang91/promise-async",
      {
        -- enabled = false,
        'yaocccc/nvim-foldsign',
        opts = {
          foldsigns = {
            open = '', -- mark the beginning of a fold
            close = '', -- show a closed fold
            seps = { '│', '┃' }, -- open fold middle marker
          }
        },
      },
    },
    keys = {
      { "zR", function() require('ufo').openAllFolds() end,               desc = "Open All Folds" },
      { "zM", function() require('ufo').closeAllFolds() end,              desc = "Close All Folds" },
      { "zr", function() require('ufo').openFoldsExceptKinds() end,       desc = "Open Folds Except Kinds" },
      { "zm", function() require('ufo').closeFoldsWith() end,             desc = "Close Folds With" },
      { "PP", function() require('ufo').peekFoldedLinesUnderCursor() end, desc = "Peek Folded Lines Under Cursor" },
    },
    config = function()
      -- vim.o.foldcolumn = 'auto:3' -- '0' is not bad
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldenable = true
      vim.o.foldlevel = 99        -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      local function customizeSelector(bufnr)
        local function handleFallbackException(err, providerName)
          if type(err) == 'string' and err:match('UfoFallbackException') then
            return require('ufo').getFolds(bufnr, providerName)
          else
            return require('promise').reject(err)
          end
        end
        return require('ufo').getFolds(bufnr, 'lsp'):catch(function(err)
          return handleFallbackException(err, 'treesitter')
        end):catch(function(err)
          return handleFallbackException(err, 'indent')
        end)
      end
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return customizeSelector
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
    'anuvyklack/pretty-fold.nvim',
    -- lazy = false,
    config = function()
      require('pretty-fold').setup()
    end
  },
}
