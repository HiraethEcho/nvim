return {
  {
    "stevearc/conform.nvim",
    -- enabled = false,
    event = { "BufWritePre" },
    -- lazy = false,
    keys = {
      { "<leader>F", function() require("conform").format({ async = true, lsp_format = "fallback" }) end, mode = "", desc = "Format buffer", },
    },
    opts = {},
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          markdown = { "prettier" },
          latex = { "latexindent" },
          -- Conform will run multiple formatters sequentially
        },
      })
    end,
  },
}
