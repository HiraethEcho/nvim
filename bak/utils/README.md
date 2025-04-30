# luasnip-latex-snippets

  https://github.com/iurimateus/luasnip-latex-snippets.nvim,

Depends on [vimtex](https://github.com/lervag/vimtex) to determine if the
cursor is within math mode. Alternatively, you can use
[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) (experimental) by passing `{ use_treesitter = true }` to the setup call.

It's necessary to enable `autosnippets` in luasnip: `require("luasnip").config.setup { enable_autosnippets = true }`.
