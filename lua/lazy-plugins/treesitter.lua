return {
  { -- "so1ve/tiny-treesitter.nvim",
    "so1ve/tiny-treesitter.nvim",
    -- lazy = false,
    -- enabled = false,
    event = "InsertEnter",
    build = function()
      require("tiny-treesitter").install(
        { "lua", "markdown", "latex", "bash", "json", "toml", "yaml" },
        { wait = true }
      )
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
      -- "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      cursor_line_only = true,
    },
  },

  { -- "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter",
    enabled = false,
    lazy = false,
    cmd = "TSEnable",
    branch = "main",
    build = ":TSUpdate",
    init = function()
      require("nvim-treesitter").install({
        "python",
        "javascript",
        "typescript",
        "html",
        "css",
        "lua",
        "vim",
        "markdown",
        "latex",
      })
    end,
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
