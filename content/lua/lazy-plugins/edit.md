---
title: edit
---

# edit

enhance editing

```lua
return {
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
  { -- "voldikss/vim-translator",
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
}
```
