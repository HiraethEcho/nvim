return {
  {
    enabled = false,
    lazy = false,
    "stevearc/conform.nvim",
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>F",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {},
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          markdown = { "prettier" },
          latex = { "llf" },
          -- Conform will run multiple formatters sequentially
        },
      })
    end,
  },
  {
    "nvimdev/guard.nvim",
    enabled = false,
    -- Builtin configuration, optional
    dependencies = {
      "nvimdev/guard-collection",
    },
    keys = {
      { "<leader>F", "<cmd>GuardFmt<cr><cmd>retab<cr>", desc = "Format" },
    },
    config = function()
      local ft = require("guard.filetype")
      ft("lua"):fmt("lsp")
      -- ft('sh'):fmt('lsp')
      --     :lint('shellcheck')
      ft("markdown"):fmt("prettier")

      ft("tex"):fmt("latexindent")

      -- Call setup() LAST!
      require("guard").setup({
        -- the only options for the setup function
        fmt_on_save = false,
        -- Use lsp if no formatter was defined for this filetype
        lsp_as_default_formatter = true,
      })
    end,
  },
}
