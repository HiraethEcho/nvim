-- Python indentation, pinned to PEP 8 (4 spaces).
--
-- This file lives in `after/ftplugin/` on purpose. The global defaults in
-- `lua/options.lua` are 2 spaces, and `ftplugin/python.lua` is loaded BEFORE
-- `$VIMRUNTIME/ftplugin/python.vim`, so anything set there is overwritten by
-- the runtime file. Only `after/` is sourced last, so only `after/` wins.
--
-- Neovim's runtime file already applies 4 spaces while
-- `g:python_recommended_style` is non-zero. Pin the values here instead of
-- relying on that condition.

vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
