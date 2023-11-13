return {
  {
    "nvimdev/guard.nvim",
    -- Builtin configuration, optional
    dependencies = {
      "nvimdev/guard-collection",
    },
    keys = {
      { "<leader>F", "<cmd>GuardFmt<cr><cmd>retab<cr>", desc = "Format" },
    },
    config = function()
      local ft = require('guard.filetype')
      ft('lua'):fmt('lsp')
      -- ft('sh'):fmt('lsp')
      --     :lint('shellcheck')
      ft('markdown'):fmt('prettier')

      ft('tex'):fmt('latexindent')

      -- Call setup() LAST!
      require('guard').setup({
        -- the only options for the setup function
        fmt_on_save = true,
        -- Use lsp if no formatter was defined for this filetype
        lsp_as_default_formatter = true,
      })
    end
  }
}
