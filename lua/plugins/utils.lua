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
      -- "Shatur/neovim-session-manager",
    },
    opts = {
      bigfile = { enabled = true },
      image = {
        enabled = true,
        force = true,
        doc = { enabled = true, inline = false, float = true },
        math = {
          enabled = false,
          typst = {
            tpl = [[
        #set page(width: auto, height: auto, margin: (x: 2pt, y: 2pt))
        #show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
        #set text(size: 12pt, fill: rgb("${color}"))
        ${header}
        ${content}]],
          },
          latex = {
            font_size = "Large", -- see https://www.sascha-frank.com/latex-font-size.html
            -- for latex documents, the doc packages are included automatically,
            -- but you can add more packages here. Useful for markdown documents.
            packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" },
            color = "#ffffff",
            tpl = [[
        \documentclass[preview,border=0pt,varwidth,12pt]{standalone}
        \usepackage{${packages}}
        \begin{document}
        ${header}
        { \${font_size} \selectfont
          \color[HTML]{${color}}
        ${content}}
        \end{document}]],
          },
        },
      },
      dashboard = {
        enabled = false,
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
      notifier = { enabled = true },
      picker = {
        sources = {
          explorer = {
            -- layout = { layout = { position = "right" } },
            win = {
              list = {
                keys = {
                  ["."] = "tcd",
                  ["zh"] = "toggle_hidden",
                  ["s"] = "edit_split",
                  ["v"] = "edit_vsplit",
                  ["<c-u>"] = { "preview_scroll_up" },
                  ["<c-d>"] = { "preview_scroll_down" },
                  ["w"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
                },
              },
            },
          },
          buffers = { layout = { preset = "ivy" } },
          colorschemes = { layout = { preset = "bottom" } },
        },
        layout = { cycle = false },
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
              ["s"] = { "flash", mode = { "n" } },
              -- ["<C-S>"] = { "flash", mode = { "n", "i" } },
            },
          },
        },
        actions = {
          flash = function(picker)
            require("flash").jump({
              pattern = "^",
              label = { after = { 0, 0 } },
              search = {
                mode = "search",
                exclude = {
                  function(win)
                    return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                  end,
                },
              },
              action = function(match)
                local idx = picker.list:row2idx(match.pos[1])
                picker.list:_move(idx, true, true)
              end,
            })
          end,
        },
      },
      quickfile = { enabled = true },
      scope = { enabled = true },
      debug = { enabled = false },
      scroll = { enabled = true },
      lazygit = { enabled = true },
      statuscolumn = { enabled = false },
      words = { enabled = false },
      zen = {
        zoom = {
          toggles = {},
          show = { statusline = true, tabline = false },
        },
        toggles = {
          dim = false,
          git_signs = true,
          mini_diff_signs = true,
          diagnostics = true,
        },
      },
      styles = {
        notification = {
          wo = { wrap = true }, -- Wrap notifications
        },
        snacks_image = {
          relative = "editor",
          col = 10,
          row = 1,
        },
      },
    },
    keys = {
      -- Top Pickers & Explorer
      {
        "<leader>b",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>X",
        function()
          Snacks.bufdelete.other()
        end,
        desc = "Delete other Buffers",
      },
      {
        "<leader>/",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep",
      },
      {
        "<leader>:",
        function()
          Snacks.picker.command_history()
        end,
        desc = "Command History",
      },
      {
        "<leader>e",
        function()
          Snacks.explorer()
        end,
        desc = "File Explorer",
      },
      {
        "<leader>P",
        function()
          Snacks.picker.pick()
        end,
        desc = "pickers",
      },
      {
        "<leader>p",
        function()
          Snacks.picker.resume()
        end,
        desc = "Resume",
      },
      -- find
      {
        "<leader>ff",
        function()
          Snacks.picker.smart()
        end,
        desc = "Smart Find Files",
      },
      {
        "<leader>fc",
        function()
          Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "Find Config File",
      },
      {
        "<leader>fp",
        function()
          Snacks.picker.projects()
        end,
        desc = "Projects",
      },
      {
        "<leader>fr",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent",
      },
      -- git
      {
        "<leader>gw",
        function()
          Snacks.gitbrowse()
        end,
        desc = "Git Browse",
        mode = { "n", "v" },
      },
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>gB",
        function()
          Snacks.picker.git_branches()
        end,
        desc = "Git Branches",
      },
      {
        "<leader>gl",
        function()
          Snacks.picker.git_log()
        end,
        desc = "Git Log",
      },
      {
        "<leader>gL",
        function()
          Snacks.picker.git_log_line()
        end,
        desc = "Git Log Line",
      },
      {
        "<leader>gs",
        function()
          Snacks.picker.git_status()
        end,
        desc = "Git Status",
      },
      -- { "<leader>gS", function() Snacks.picker.git_stash() end,                               desc = "Git Stash", },
      {
        "<leader>gd",
        function()
          Snacks.picker.git_diff()
        end,
        desc = "Git Diff (Hunks)",
      },
      {
        "<leader>gf",
        function()
          Snacks.picker.git_log_file()
        end,
        desc = "Git Log File",
      },
      -- search
      {
        '<leader>"',
        function()
          Snacks.picker.registers()
        end,
        desc = "Registers",
      },
      {
        "<leader>s/",
        function()
          Snacks.picker.search_history()
        end,
        desc = "Search History",
      },
      {
        "<leader>sa",
        function()
          Snacks.picker.autocmds()
        end,
        desc = "Autocmds",
      },
      {
        "<leader>sD",
        function()
          Snacks.picker.diagnostics()
        end,
        desc = "Diagnostics",
      },
      {
        "<leader>sd",
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = "Buffer Diagnostics",
      },
      {
        "<leader>sh",
        function()
          Snacks.picker.help()
        end,
        desc = "Help Pages",
      },
      {
        "<leader>sH",
        function()
          Snacks.picker.highlights()
        end,
        desc = "Highlights",
      },
      {
        "<leader>si",
        function()
          Snacks.picker.icons()
        end,
        desc = "Icons",
      },
      {
        "<leader>j",
        function()
          Snacks.picker.jumps()
        end,
        desc = "Jumps",
      },
      {
        "<leader>sk",
        function()
          Snacks.picker.keymaps()
        end,
        desc = "Keymaps",
      },
      {
        "<leader>M",
        function()
          Snacks.picker.marks()
        end,
        desc = "Marks",
      },
      {
        "<leader>sM",
        function()
          Snacks.picker.man()
        end,
        desc = "Man Pages",
      },
      {
        "<leader>sp",
        function()
          Snacks.picker.lazy()
        end,
        desc = "Search for Plugin Spec",
      },
      {
        "<leader>sq",
        function()
          Snacks.picker.qflist()
        end,
        desc = "Quickfix List",
      },
      {
        "<leader>sl",
        function()
          Snacks.picker.loclist()
        end,
        desc = "Location List",
      },
      {
        "<leader>su",
        function()
          Snacks.picker.undo()
        end,
        desc = "Undo History",
      },
      {
        "<leader>sb",
        function()
          Snacks.picker.lines()
        end,
        desc = "Buffer Lines",
      },
      {
        "<leader>sB",
        function()
          Snacks.picker.grep_buffers()
        end,
        desc = "Grep Open Buffers",
      },
      {
        "<leader>sw",
        function()
          Snacks.picker.grep_word()
        end,
        desc = "Visual selection or word",
        mode = { "n", "x" },
      },
      {
        "<leader>sC",
        function()
          Snacks.picker.colorschemes()
        end,
        desc = "Colorschemes",
      },
      -- LSP
      {
        "gd",
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = "Goto Definition",
      },
      {
        "gD",
        function()
          Snacks.picker.lsp_declarations()
        end,
        desc = "Goto Declaration",
      },
      {
        "gr",
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = "References",
      },
      {
        "gI",
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = "Goto Implementation",
      },
      {
        "gy",
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = "Goto T[y]pe Definition",
      },
      {
        "<leader>ss",
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = "LSP Symbols",
      },
      {
        "<leader>sS",
        function()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = "LSP Workspace Symbols",
      },
      -- Other
      {
        "<leader>z",
        function()
          Snacks.zen()
        end,
        desc = "Toggle Zen Mode",
      },
      {
        "<leader>Z",
        function()
          Snacks.zen.zoom()
        end,
        desc = "Toggle Zoom",
      },
      {
        "<leader>cR",
        function()
          Snacks.rename.rename_file()
        end,
        desc = "Rename File",
      },
      {
        "<leader>N",
        function()
          Snacks.picker.notifications()
        end,
        desc = "Notification History",
      },
      {
        "<leader>un",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
      {
        "<c-/>",
        function()
          Snacks.terminal()
        end,
        desc = "Toggle Terminal",
      },
      -- { "]]",         function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",            mode = { "n", "t" }, },
      -- { "[[",         function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",            mode = { "n", "t" }, },
      --[[ {
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
      }, ]]
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
          Snacks.toggle
            .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
            :map("<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.inlay_hints():map("<leader>uI")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.animate():map("<leader>ua")
        end,
      })
    end,
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
