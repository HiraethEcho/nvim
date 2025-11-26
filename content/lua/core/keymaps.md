---
title: keymaps
---

```lua
-- local Util = require("lua.util.init")

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- better commond
map({ "n", "v" }, ";", ":")
map({ "v", "n" }, "x", '"_x')
map("n", "<Space>", "<Nop>", { noremap = true, silent = true })
-- map("n", 's', '<NOP>', { noremap = true, silent = true })
map("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
map("v", "<", "<gv")
map("v", ">", ">gv")

-- tabs
-- map("n", "<c-t>", "<cmd>tabnew<cr>", { desc = "New Tab" })
-- map("n", "<C-n>", "<C-W>T", { desc = "Window to new tab" })
map("n", "t", "<cmd>tabNext<cr>", { desc = "Next Tab" })
map("n", "T", "<cmd>tabprevious<cr>", { desc = "previous Tab" })

-- window
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- edit
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "v" }, "H", "^")
map({ "n", "v" }, "L", "g_")
-- map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
-- map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")
-- move cursor in insert mode
-- map("i", "<C-h>", "<Left>")
-- map("i", "<C-l>", "<Right>")
-- map("i", "<C-k>", "<Up>")
-- map("i", "<C-j>", "<Down>")

-- file
-- map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>wa<cr><esc>", { desc = "Save file" })
map("n", "Q", "<c-w>q", { desc = "Close window" })
map("n", "<leader>H", ":cd %:h<cr>", { desc = "set cwd to parent of current file" })
map("n", "<leader>q", "<cmd>wqa<cr>", { desc = "Quit all" })


-- toggle set
-- map("n", "<leader>uw", function() Util.toggle_set("wrap") end, { desc = "Toggle Word Wrap" })
-- map("n", "<leader>us", function() Util.toggle_set("spell") end, { desc = "Toggle Spelling" })
-- map("n", "<leader>ul", function() Util.toggle_set("number") end, { desc = "Toggle Line Numbers" })
-- map("n", "<leader>ur", function() Util.toggle_set("relativenumber") end, { desc = "Toggle Line Relative Numbers" })
-- map("n", "<leader>uc", function() Util.toggle_set("conceallevel", false, { 0, conceallevel }) end, { desc = "Toggle Conceal" })
-- toggle function
-- map("n", "<leader>ud", function() Util.toggle_diagnostics() end, { desc = "Toggle Diagnostics" })
-- map("n", "<leader>uI", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = "Toggle Inlay Hints" })
-- map("n", "<leader>ub", "<cmd>BRToggle<cr>", { desc = "Toggle Bionic Read" })

-- terminals
-- local lazyterm = function()
--   Util.float_term("zsh", { esc_esc = true, ctrl_hjkl = false })
-- end
-- map("n", "<leader>t", lazyterm, { desc = "Float Terminal" })
-- map("n", "<leader>gg", function() Util.lazygit() end, { desc = "Lazygit " })
-- Terminal Mappings
-- map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
-- map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
-- map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
-- map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
-- map("t", "<esc><esc>", "<cmd>close<cr>", { desc = "Hide Terminal" })
```
