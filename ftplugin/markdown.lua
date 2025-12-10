vim.lsp.enable("markdown")
vim.lsp.enable("harper")

--[[ function _G.wrap_selected(wrapper)
  vim.cmd('normal! gv"ay')
  local selected = fim.fn.getreg("a")
  vim.fn.setreg("a", wrapper .. selected .. wrapper, vim.fn.getregtype("a"))
  vim.cmd('normal!  gv"ap')
end ]]

-- vim.api.nvim_set_keymap("v", "<C-i>", ':<C-u>lua wrap_selected("*")<CR>', { noremap = true, silent = true })
