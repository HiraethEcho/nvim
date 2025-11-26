---
title: treesitter
---

# treesitter

better hightlight

```lua
return {
  { -- "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
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
}
```
