---
title: tex
---
```lua
vim.lsp.enable("texlab")
vim.keymap.set("n", "<cr><cr>", "<cmd>TexlabBuild<cr>",
  { noremap = true, silent = true, buffer = bufnr, desc = "texlab build" })
vim.keymap.set("n", "<cr>", "<cmd>TexlabForward<cr>",
  { noremap = true, silent = true, buffer = bufnr, desc = "texlab forward" })

```
