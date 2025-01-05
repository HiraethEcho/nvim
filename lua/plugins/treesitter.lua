return {
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = false,
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
      {
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
                  ["@function.outer"] = "V",  -- linewise
                  ["@class.outer"] = "<c-v>", -- blockwise
                },
              },
            },
          })
        end,
      },
    },
    opts = {
      highlight = {
        enable = true,
        -- disable = { "latex" },
        -- additional_vim_regex_highlighting = { "latex", "markdown" },
      },
      indent = { enable = true },
      ensure_installed = {
        "c",
        "html",
        "lua",
        -- "latex",  -- conflict with UltiSnips and math environment detected by vimtex
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
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = false,
    cmd = "TSContextEnable",
    keys = {
      { "<leader>ut", "<cmd>TSContextToggle<cr>", desc = "toggle treesitter context" },
    },
    opts = {
      max_lines = 3,
    },
  },
}
