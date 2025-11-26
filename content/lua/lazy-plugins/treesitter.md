---
title: treesitter
---
```lua
return {
  { -- "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter",
    -- version = false, -- last release is way too old and doesn't work on Windows
    -- lazy = false,
    -- cmd = "TSEnable",
    build = ":TSUpdate",
    -- event = "VeryLazy",
    -- event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      -- "kevinhwang91/nvim-ufo",
      -- "hiphish/rainbow-delimiters.nvim",
      -- 'anuvyklack/pretty-fold.nvim',
    },
    opts = {
      indent = { enable = true },
      ensure_installed = {
        "c",
        "html",
        "lua",
        "markdown",
        "markdown_inline",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "vv",
          node_incremental = "<cr>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      table.insert(opts.ensure_installed, "latex") -- extend but not merge
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  { -- "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-context",
    -- enabled = false,
    cmd = "TSContext enable",
    keys = {
      { "<leader>ut", "<cmd>TSContext toggle<cr>", desc = "toggle treesitter context" },
    },
    opts = {
      max_lines = 3,
    },
  },
  { -- "code-biscuits/nvim-biscuits",
    "code-biscuits/nvim-biscuits",
    keys = {
      {
        "<leader>ub",
        function()
          local nvim_biscuits = require("nvim-biscuits")
          nvim_biscuits.BufferAttach()
          nvim_biscuits.toggle_biscuits()
        end,
        mode = "n",
        desc = "Enable Biscuits",
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      cursor_line_only = true,
    },
  },
  { -- "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-textobjects",
    enabled = false,
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            -- Automatically jump forward to textobjects, similar to targets.vim
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              -- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            },
            -- You can choose the select mode (default is charwise 'v')
            selection_modes = {
              ["@parameter.outer"] = "v", -- charwise
              ["@function.outer"] = "V", -- linewise
              ["@class.outer"] = "<c-v>", -- blockwise
            },
          },
        },
      })
    end,
  },
}
```
