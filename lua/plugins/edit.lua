local vim = vim
return {
  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "lambdalisue/suda.vim",
    cmd = { "SudaRead", "SudaWrite" },
    enabled = function()
      if vim.g.is_linux then
        return true
      else
        return false
      end
    end,
  },
  {
    "machakann/vim-sandwich",
    event = "BufReadPost",
  },
  {
    "godlygeek/tabular",
    keys = {
      { "<leader>t", ":Tabularize /", mode = "v", desc = "tabularize" },
    },
  },
  {
    "Neur1n/neuims",
    cmd = "IMSToggle",
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
          icon = " ",                              -- icon used for the sign, and in search results
          color = "error",                            -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
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
        test = { "Identifier", "#FF00FF" }
      },
    },
  },
  {
    "ellisonleao/glow.nvim",
    config = true,
    cmd = "Glow",
    keys = {
      { "<leader>mp", "<cmd>Glow<cr>", desc = "markdown Glow Preview" },
    },
  },
  {
    "antonk52/markdowny.nvim",
    ft = { "md", "markdown" },
    config = function()
      require("markdowny").setup()
      vim.keymap.set("v", "<C-b>", ":lua require('markdowny').bold()<cr>", { buffer = 0 })
      vim.keymap.set("v", "<C-i>", ":lua require('markdowny').italic()<cr>", { buffer = 0 })
      vim.keymap.set("v", "<C-k>", ":lua require('markdowny').link()<cr>", { buffer = 0 })
      vim.keymap.set("v", "<C-e>", ":lua require('markdowny').code()<cr>", { buffer = 0 })
    end,
  },
  {
    "RRethy/vim-illuminate",
    keys = {
      { "<leader>ui", "<cmd>IlluminateToggle<cr>", desc = "toggle illuminate" },
    },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
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
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "toggle illuminate" },
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
        twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
      },
    },
  },
}
