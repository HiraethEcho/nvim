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
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        markdown = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        tex = { "tex-fmt" },
        sh = { "shfmt" },
      },
    },
    --[[ config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          markdown = { "prettier" },
          json = { "prettier" },
          html = { "prettier" },
          tex = { "tex-fmt" },
          sh = { "shfmt" },
        },
      })
    end, ]]
  },
  {
    "mfussenegger/nvim-lint",
    -- event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "<leader>L",
        function()
          require("lint").try_lint()
        end,
        mode = "n",
        desc = "Trigger linting for current file",
      },
    },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        -- bash = { "bash" },
        bash = { "bash" },
        sh = { "bash", "shellcheck" },
        --[[ javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        svelte = { "eslint_d" },
        kotlin = { "ktlint" },
        terraform = { "tflint" },
        ruby = { "standardrb" }, ]]
      }

      --[[ local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      }) ]]

      --[[ vim.keymap.set("n", "<leader>L", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" }) ]]
    end,
  },
}
