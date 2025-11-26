---
title: edit
---
```lua
return {
  { -- "echasnovski/mini.surround",
    "echasnovski/mini.surround",
    enabled = false,
    version = "*",
    event = "InsertEnter",
  },
  { -- "kylechui/nvim-surround",
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "BufRead",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  { -- "numToStr/Comment.nvim",
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
    opts = {},
  },
  { -- "tigion/swap.nvim",
    "tigion/swap.nvim",
    -- enabled = false,
    -- event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      {
        "<Leader>i",
        function()
          require("swap").switch()
        end,
        desc = "Swap word",
      },
      -- { '<Leader>I', function() require('swap').opposites.switch() end, desc = 'Swap to opposite word' },
      -- { '<Leader>I', function() require('swap').chains.switch() end, desc = 'Swap to next word' },
      -- { '<Leader>I', function() require('swap').cases.switch() end, desc = 'Swap naming convention' },
      -- { '<Leader>I', function() require('swap').todos.switch() end, desc = 'Swap todo state' },
    },
    opts = {
      cases = { types = { "snake", "kebab", "camel", "pascal" } },
      opposites = {
        words = {},
        words_by_ft = { -- File type specific opposite words.
          markdown = {
            ["and"] = nil, -- Removes a default.
            [">"] = nil,
          },
          ["lua"] = { -- since `lua` is an illegal name
            ["=="] = "~=", -- Replaces the default `['=='] = '!='` for lua files.
          },
        },
      },
      chains = {
        use_case_sensitive_mask = true,
        words_by_ft = {
          markdown = {
            { "[!note]", "[!tip]", "[!important]", "[!warning]", "[!caution]" }, -- markdown (github) alerts
          },
        },
      },
      all = {
        -- modules = { "opposites", "chains", "cases", "todos" },
        modules = { "opposites", "chains", "cases" },
      },
    },
  },
  { -- "Wansmer/treesj",
    "Wansmer/treesj",
    keys = {
      { "gK", "<cmd>TSJSplit<CR>", desc = "treesj split" },
      { "gJ", "<cmd>TSJJoin<CR>", desc = "treesj join" },
    },
    opts = { use_default_keymaps = false },
  },
  { -- "echasnovski/mini.align",
    "echasnovski/mini.align",
    enabled = false,
    event = "InsertEnter",
    version = false,
    -- lazy = false,
    opts = { mappings = { start = "", start_with_preview = "<leader>a" } },
  },
  { -- "smartding/fcitx.nvim",
    "smartding/fcitx.nvim",
    -- lazy = false,
    ft = "markdown,md",
    cmd = "Fcitx",
    config = function()
      vim.api.nvim_create_user_command("Fcitx", require("fcitx").setup, {})
      require("fcitx").setup()
    end,
  },
  { -- "windwp/nvim-autopairs",
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      map_bs = false,
    },
  },
  { -- "sontungexpt/bim.nvim",
    "sontungexpt/bim.nvim",
    enabled = false,
    event = "InsertEnter",
    config = true,
  },
  { -- "echasnovski/mini.splitjoin",
    "echasnovski/mini.splitjoin",
    enabled = false,
    event = "InsertEnter",
    version = false,
    opts = { mappings = { toggle = "", split = "gK", join = "gJ" } },
  },
  { -- "folke/todo-comments.nvim",
    "folke/todo-comments.nvim",
    enabled = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>st",
        function()
          Snacks.picker.todo_comments()
        end,
        desc = "Todo",
      },
      {
        "<leader>sT",
        function()
          Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
        end,
        desc = "Todo/Fix/Fixme",
      },
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comments",
        mode = { "n" },
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo comments",
        mode = { "n" },
      },
      {
        "]f",
        function()
          require("todo-comments").jump_next({ keywords = { "FIX", "WARN" } })
        end,
        desc = "Next error/warning comments",
        mode = { "n" },
      },
      {
        "[f",
        function()
          require("todo-comments").jump_prev({ keywords = { "FIX", "WARN" } })
        end,
        desc = "Previous error/warning comments",
        mode = { "n" },
      },
      {
        "]q",
        function()
          require("todo-comments").jump_next({ keywords = { "QUES" } })
        end,
        desc = "Next question",
        mode = { "n" },
      },
      {
        "[q",
        function()
          require("todo-comments").jump_prev({ keywords = { "QUES" } })
        end,
        desc = "Previous question",
        mode = { "n" },
      },
      {
        "]n",
        function()
          require("todo-comments").jump_next({ keywords = { "NOTE" } })
        end,
        desc = "Next note",
        mode = { "n" },
      },
      {
        "[n",
        function()
          require("todo-comments").jump_prev({ keywords = { "NOTE" } })
        end,
        desc = "Previous note",
        mode = { "n" },
      },
    },
    cmd = { "TodoLocList", "TodoTelescope", "TodoQuickFix" },
    opts = {
      sign_priority = 8, -- sign priority
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        QUES = { icon = " ", color = "default" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      },
      gui_style = {
        bg = "BOLD", -- The gui style to use for the bg highlight group.
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults
      -- list of named colors where we try to extract the guifg from the
      -- list of highlight groups or use the hex color if hl not found as a fallback
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" },
      },
    },
  },
  { -- "folke/zen-mode.nvim",
    "folke/zen-mode.nvim",
    enabled = false,
    dependencies = { "folke/twilight.nvim" },
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "toggle zen mode" },
    },
    opts = {
      window = {
        backdrop = 0.90, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        width = 100, -- width of the Zen window
        height = 1, -- height of the Zen window
      },
      plugins = {
        -- disable some global vim options (vim.o...)
        -- comment the lines to not apply the options
        twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
      },
    },
  },
  { -- "joshuadanpeterson/typewriter",
    "joshuadanpeterson/typewriter",
    enabled = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = { "TWToggle", "TWTop" },
    config = function()
      require("typewriter").setup()
    end,
    opts = {},
  },
  { -- "mbbill/undotree",
    "mbbill/undotree",
    enabled = false,
    keys = {
      { "U", "<cmd>UndotreeToggle<cr>", desc = "open undotree" },
    },
    config = function()
      vim.g.undotree_WindowLayout = 2
    end,
  },
  { -- "XXiaoA/atone.nvim",
    "XXiaoA/atone.nvim",
    keys = {
      { "<leader>uU", "<cmd>UndotreeToggle<cr>", desc = "open undotree" },
    },
    cmd = "Atone",
    opts = {}, -- your configuration here
  },
  { -- "y3owk1n/time-machine.nvim",
    "y3owk1n/time-machine.nvim",
    version = "*", -- remove this if you want to use the `main` branch
    cmd = {
      "TimeMachineToggle",
      "TimeMachinePurgeBuffer",
      "TimeMachinePurgeAll",
      "TimeMachineLogShow",
      "TimeMachineLogClear",
    },
    opts = {
      split_opts = {
        width = 50, -- columns number
      },
      float_opts = {
        width = 0.8, -- between 0 and 1
        height = 0.8, -- between 0 and 1
        winblend = 0,
      },
      diff_tool = "native", -- default diff engine
      native_diff_opts = { -- only used when diff_tool is "native"
        result_type = "unified",
        ctxlen = 3,
        algorithm = "histogram",
      },
      keymaps = {
        undo = "u",
        redo = "<C-r>",
        restore_undopoint = "<CR>",
        refresh_timeline = "r",
        preview_sequence_diff = "p",
        tag_sequence = "t",
        close = "q",
        help = "g?",
        toggle_current_timeline = "c",
      },
      ignore_filesize = nil, -- e.g. 10 * 1024 * 1024
    },
  },
  { -- "uga-rosa/translate.nvim",
    "uga-rosa/translate.nvim",
    enabled = false,
    cmd = "Translate",
    opts = {
      default = {
        command = "translate_shell",
        output = "floating",
      },
      preset = {
        output = {
          insert = {
            base = "top",
            off = -1,
          },
          split = {
            append = true,
          },
        },
      },
    },
  },
  { -- "voldikss/vim-translator",
    "voldikss/vim-translator",
    -- enabled = false,
    cmd = "TranslateW",
    keys = {
      { "<leader>W", "<cmd>TranslateW<cr>", mode = { "n", "v" }, desc = "translate" },
    },
    config = function()
      vim.g.translator_target_lang = "zh"
      vim.g.translator_history_enable = true
      vim.g.translator_default_engines = { "bing", "youdao" }
    end,
  },
  { -- "soemre/commentless.nvim",
    "soemre/commentless.nvim",
    enabled = false,
    cmd = "Commentless",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = true,
  },
}
```
