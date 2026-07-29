return {
  { -- "stevearc/conform.nvim",
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
        ["tex-fmt"] = {
          args = { "--nowrap" }, -- 例如，不自动换行
        },
      },
      formatters_by_ft = {
        toml = { "taplo" },
        kdl = { "kdlfmt" },
        tex = { "tex-fmt" },
        bib = { "tex-fmt" },
        typst = { "typstyle" },
        sh = { "shfmt" },
        lua = { "stylua" },
        markdown = { "prettier", "cbfmt" },
        python = { "ruff" },
        javascript = { "biome" },
        typescript = { "biome" },
        json = { "biome" },
        html = { "biome" },
        css = { "biome" },
        ["*"] = { "prettier" },
      },
    },
  },
  { -- "mfussenegger/nvim-lint",
    "mfussenegger/nvim-lint",
    enabled = false,
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
