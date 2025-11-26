---
title: tex
---
```lua
return {
  { -- vimtex
    "lervag/vimtex",
    lazy = false,
    -- enabled = false,
    -- ft = { "bib", "tex" },
    init = function()
      vim.g.vimtex_view_method = "zathura"
      -- vim.g.vimtex_view_method = "sioyek"
      vim.g.vimtex_imaps_leader = ";"

      -- this works
      -- vim.g.vimtex_view_general_viewer = "okular"
      -- vim.g.vimtex_view_general_options = [[ --unique file:@pdf\#src:@line@tex]]
      -- in okular, set 'nvr --remote-silent +%l %f' in settings - configure - editor

      -- vim.g.vimtex_syntax_enabled = 1
      -- vim.g.vimtex_syntax_conceal_disable = 1
      vim.g.vimtex_fold_enabled = 1
      -- vim.g.vimtex_indent_enabled = 0           -- turn off vimtex indentation
      -- vim.g.vimtex_mappings_enabled = 0         -- disable default mappings
      -- vim.g.vimtex_imaps_enabled = 0            -- disable insert mode mappings (I use UltiSnips)
      -- vim.g.vimtex_complete_enabled = 0         -- turn off completion (not currently used so more efficient to turn off)
      -- vim.g.vimtex_fold_manual=0
      -- vim.g.vimtex_fold_levelmarker      =1
      -- vim.g.vimtex_fold_types            =1
      -- vim.g.vimtex_fold_types_defaults   =1
      -- vim.g.vimtex_fold_bib_enabled      =1
      -- vim.g.vimtex_fold_bib_max_key_width=1

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
