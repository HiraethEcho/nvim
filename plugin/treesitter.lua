-- Auto-enable built-in treesitter highlighting when a parser is available
local ts_group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true })

-- Toggle treesitter highlighting manually for the current buffer
vim.api.nvim_create_user_command("TSToggle", function()
  if vim.b.ts_highlight then
    vim.treesitter.stop()
    vim.notify("Treesitter highlight: off", vim.log.levels.INFO)
  else
    vim.treesitter.start()
    vim.notify("Treesitter highlight: on", vim.log.levels.INFO)
  end
end, { desc = "Toggle treesitter highlighting" })

-- Show treesitter captures and highlights under cursor
vim.api.nvim_create_user_command("TSInspect", function()
  vim.show_pos()
end, { desc = "Inspect treesitter captures under cursor" })
