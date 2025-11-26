---
title: tex
---

# tex

help to write latex.

- using plugin vimtex. To enable inverse search, need `lazy=false`
- and texlab, see [/lsp/texlab](/lsp/texlab)

```lua
return {
  { -- vimtex
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_imaps_leader = ";"
      vim.g.vimtex_fold_enabled = 1
      vim.g.vimtex_toc_config = {
        name = "TOC",
        layers = { "label", "todo", "include", "content" },
        split_width = 30,
        todo_sorted = 1,
        show_help = 1,
        show_numbers = 2,
      }

      vim.g.vimtex_quickfix_enabled = 0
      vim.g.vimtex_quickfix_ignore_filters = {
        "Underfull \\\\hbox",
        "Overfull \\\\hbox",
        "LaTeX Warning:  float specifier changed to",
        "LaTeX Warning: The counter will not be printed",
        "LaTeX Warning: Marginpair on page ",
        "LaTeX Font Warning: Font shape ",
        "LaTeX hooks Warning",
        'Package siunitx Warning: Detected the "physics" package:',
        "Package hyperref Warning: Token not allowed in a PDF string",
      }
    end,
  },
}
```
