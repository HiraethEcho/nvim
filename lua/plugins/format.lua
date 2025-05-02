return {
  {
    "stevearc/conform.nvim",
    -- enabled = false,
    -- event = { "BufWritePre" },
    -- lazy = false,
    keys = {
      {
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
          markdown = { "prettierd" },
          tex = { "tex-fmt" },
          sh = { "shfmt" },
        },
      })
    end,
  },
}
