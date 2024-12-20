local Util = require("config.util")

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  if opts.remap and not vim.g.vscode then
    opts.remap = nil
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- better commond
map({ "n", "v" }, ";", ":")
map({ "v", "n" }, "x", '"_x')
map("n", "<Space>", "<Nop>", { noremap = true, silent = true })
map("n", "<leader>H", ":cd %:h<cr>", { desc = "set cwd to parent of current file" })
-- move cursor in insert mode
map("i", "<C-h>", "<Left>")
map("i", "<C-l>", "<Right>")
map("i", "<C-k>", "<Up>")
map("i", "<C-j>", "<Down>")

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "v" }, "H", "^")
map({ "n", "v" }, "L", "g_")

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

map("n", "Q", "<c-w>q", { desc = "Close window" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
-- map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
-- map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
-- map("n", "<leader>d", ":bd<CR>", { desc = "buffer delete" })
-- map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
-- map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search with <esc>
map("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
-- map("i", "jk", "<ESC>")

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
-- map( "n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw / clear hlsearch / diff update" })

-- map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>wa<cr><esc>", { desc = "Save file" })
-- map("n", "S", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
-- map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
-- map("n", "<leader>uf", require("lazyvim.plugins.lsp.format").toggle, { desc = "Toggle format on Save" })
map("n", "<leader>uw", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
-- map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>us", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<leader>ud", Util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
map("n", "<leader>ul", function() Util.toggle("number") end, { desc = "Toggle Line Numbers" })
map("n", "<leader>ur", function() Util.toggle("relativenumber") end, { desc = "Toggle Line Relative Numbers" })
-- local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function() Util.toggle("conceallevel", false, { 0, conceallevel }) end, { desc = "Toggle Conceal" })

map("n", "<leader>uI", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = "Toggle Inlay Hints" })

-- lazygit
map("n", "<leader>gg", function() Util.float_term({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false }) end, { desc = "Lazygit " })
-- quit
map("n", "<leader>q", "<cmd>wqa<cr>", { desc = "Quit all" })

-- floating terminal
local lazyterm = function()
  Util.float_term("zsh", { esc_esc = true, ctrl_hjkl = false })
end
map("n", "<leader>t", lazyterm, { desc = "Float Terminal" })

-- Terminal Mappings
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
map("t", "<esc><esc>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- tabs
map("n", "<c-t>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "t", "<cmd>tabNext<cr>", { desc = "Next Tab" })
map("n", "T", "<cmd>tabprevious<cr>", { desc = "previous Tab" })
-- map("n", "<leader><tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
-- map("n", "<C-Tab>", "<cmd>tabNext<cr>", { desc = "Next Tab" })
-- map("n", "<C-S-Tab>", "<cmd>tabprevious<cr>", { desc = "previous Tab" })

-- vim.keymap.set('n', '<C-Tab>', ':tabNext<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', '<C-S-Tab>', ':tabprevious<CR>', { noremap = true, silent = true })

map("n", "<C-n>", "<C-W>T", { desc = "Window to new tab" })

map('', 's', '<NOP>', {desc = 'No operation'})
