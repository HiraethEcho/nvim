vim.lsp.enable("texlab")
-- vim.lsp.enable("ltex")
vim.lsp.enable("ltex-plus")
-- vim.lsp.enable("grammar")
-- vim.lsp.enable("text")
-- vim.lsp.enable("harper")
vim.keymap.set("n", "<cr><cr>", "<cmd>TexlabBuild<cr>",
  { noremap = true, silent = true, buffer = bufnr, desc = "texlab build" })
vim.keymap.set("n", "<cr>", "<cmd>TexlabForward<cr>",
  { noremap = true, silent = true, buffer = bufnr, desc = "texlab forward" })

