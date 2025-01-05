local vim = vim
return {
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n",          desc = "Comment toggle current line" },
      { "gc",  mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc",  mode = "x",          desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n",          desc = "Comment toggle current block" },
      { "gb",  mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb",  mode = "x",          desc = "Comment toggle blockwise (visual)" },
    },
    config = function()
      require("Comment").setup()
    end,
  },
  {
    'tzachar/highlight-undo.nvim',
    event = "InsertEnter",
    enabled = false,
    opts = {},
  },
  {
    'Wansmer/treesj',
    enabled = false,
    event = "InsertEnter",
    keys = {
      { "gJ", "<cmd>TSJJoin<cr>",  desc = "Join" },
      { "gK", "<cmd>TSJSplit<cr>", desc = "Split" },
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
    config = function()
      require('treesj').setup({})
    end,
  },
  {
    "echasnovski/mini.splitjoin",
    -- enabled = false,
    event = "InsertEnter",
    version = false,
    opts = { mappings = { toggle = '', split = 'gK', join = 'gJ' } }
  },
  { "echasnovski/mini.cursorword", enabled = false, version = false, event = "InsertEnter", config = true },
  {
    "echasnovski/mini.surround",
    version = false,
    event = "BufReadPost",
    config = true,
  },
  {
    'echasnovski/mini.align',
    event = "InsertEnter",
    version = false,
    -- lazy = false,
    opts = { mappings = { start = '', start_with_preview = '<leader>a' } },
  },
  {
    'Vonr/align.nvim',
    branch = "v2",
    lazy = true,
    enabled = false,
    init = function()
      -- Create your mappings here
      local NS = { noremap = true, silent = true }

      -- Aligns to 1 character
      vim.keymap.set(
        'x',
        'aa',
        function()
          require 'align'.align_to_char({
            length = 1,
          })
        end,
        NS
      )
      vim.keymap.set(
        'x',
        'ad',
        function()
          require 'align'.align_to_char({
            preview = true,
            length = 2,
          })
        end,
        NS
      )

      -- Aligns to a string with previews
      vim.keymap.set(
        'x',
        'aw',
        function()
          require 'align'.align_to_string({
            preview = true,
            regex = false,
          })
        end,
        NS
      )

      -- Aligns to a Vim regex with previews
      vim.keymap.set(
        'x',
        'ar',
        function()
          require 'align'.align_to_string({
            preview = true,
            regex = true,
          })
        end,
        NS
      )

      -- Example gawip to align a paragraph to a string with previews
      vim.keymap.set(
        'n',
        'gaw',
        function()
          local a = require 'align'
          a.operator(
            a.align_to_string,
            {
              regex = false,
              preview = true,
            }
          )
        end,
        NS
      )

      -- Example gaaip to align a paragraph to 1 character
      vim.keymap.set(
        'n',
        'gaa',
        function()
          local a = require 'align'
          a.operator(a.align_to_char)
        end,
        NS
      )
    end
  },
  {
    "godlygeek/tabular",
    enabled = false,
    keys = {
      { "<leader>t", ":Tabularize /", mode = "v", desc = "tabularize" },
    },
  },
  {
    "smartding/fcitx.nvim",
    -- lazy = false,
    ft = "markdown,md",
    cmd = "Fcitx",
    config = function()
      vim.api.nvim_create_user_command("Fcitx", require("fcitx").setup, {})
      require("fcitx").setup()
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
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
        bg = "BOLD",         -- The gui style to use for the bg highlight group.
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
  {
    "RRethy/vim-illuminate",
    enabled = false,
    keys = {
      { "<leader>ui", "<cmd>IlluminateToggle<cr>", desc = "toggle illuminate" },
    },
    opts = {
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },
  {
    "folke/zen-mode.nvim",
    dependencies = { "folke/twilight.nvim" },
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "toggle zen mode" },
    },
    opts = {
      window = {
        backdrop = 0.90, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        width = 100,     -- width of the Zen window
        height = 1,      -- height of the Zen window
      },
      plugins = {
        -- disable some global vim options (vim.o...)
        -- comment the lines to not apply the options
        twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
      },
    },
  },
  {
    'mbbill/undotree',
    keys = {
      { "U", "<cmd>UndotreeToggle<cr>", desc = "open undotree" }
    },
    config = function()
      vim.g.undotree_WindowLayout = 2
    end
  },
  {
    "voldikss/vim-translator",
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
  {
    'FluxxField/bionic-reading.nvim',
    ft = { 'help', 'lua', 'markdown', 'text' },
    opts = {
      -- determines if the file types below will be
      -- automatically highlighted on buffer open
      auto_highlight = true,
      -- the file types you want to highlight with
      -- the node types you would like to target
      -- using treesitter
      file_types = {
        ["text"] = "any", -- highlight any node
        ["help"] = "any", -- highlight any node
        ["markdown"] = "any",
        -- EX: only highlights comments in lua files
        ["lua"] = {
          "comment",
        },
      },
      -- the highlighting styles applied as val to nvim_set_hl()
      -- Please see :help nvim_set_hl() to see vals that can be passed
      hl_group_value = {
        bold = true
      },
      -- Flag used to control if the user is prompted
      -- if BRToggle is called on a file type that is not
      -- explicitly defined above
      prompt_user = true,
      -- Enable or disable the use of treesitter
      treesitter = true,
      -- Flag used to control if highlighting is applied as
      -- you type
      update_in_insert_mode = true,
    },
  },
}
