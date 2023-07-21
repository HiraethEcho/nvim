vim.api.nvim_create_autocmd("TextYankPost", {
  -- group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  -- group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown", "latex" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function()
    vim.lsp.buf.format()
  end,

})
