---
title: format
---
# format

```lua
return {
  { -- "stevearc/conform.nvim",
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader>F",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "n",
        desc = "Format buffer",
      },
    },
    opts = {
      notify_on_error = true,
      formatters = {
        cbfmt = {
          command = "cbfmt",
          args = { "-w", "--config", vim.fn.expand("~") .. "/.config/cbfmt.toml", "$FILENAME" },
        },
      },
      formatters_by_ft = {
        toml = { "taplo" },
        kdl = { "kdlfmt" },
        tex = { "tex-fmt" },
        sh = { "shfmt" },
        lua = { "stylua" },
        -- markdown = { "prettier", "cbfmt" },
        ["*"] = { "prettier" },
      },
    },
  },
}
```
