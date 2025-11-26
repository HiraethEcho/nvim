---
title: markdown
---
```lua
vim.lsp.enable('markdown')
vim.lsp.enable('harper')

--[[ function _G.wrap_selected(wrapper)
  local save_a = vim.fn.getreg('a')
  local cave_amode = vim.fn.getregtype('a')
  vim.cmd('normal! gv"ay')
  local selected = fim.fn.getreg('a')
  vim.fn.setreg('a', wrapper .. selected .. wrapper, vim.fn.getregtype('a'))
  vim.cmd('normal!  gv"ap')
  vim.fn.setreg('a',save_a,save_amode)
end

vim.api.nvim_set_keymap('v', '<C-i>', ':<C-u>lua wrap_selected("*")<CR>', { noremap = true, silent = true }) ]]
```
