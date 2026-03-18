vim.lsp.enable('tinymist')
vim.keymap.set("n", "<cr><cr>", "<cmd>TypstPreview<cr>",
  { noremap = true, silent = true, buffer = bufnr, desc = "Typst Preview" })
vim.keymap.set("n", "<cr>", "<cmd>TypstPreviewSyncCursor<cr>",
  { noremap = true, silent = true, buffer = bufnr, desc = "Typst Sync Cursor" })
