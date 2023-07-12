-- Shorten function name
local keymap = vim.api.nvim_set_keymap
local opts ={noremap= true,silent=true}
local term_opts = { silent = true }

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- general {{{ --
--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


keymap("n", "S", ":wa<cr>", opts)
keymap("n", "Q", ":q<cr>", opts)
keymap("n", "U", "<C-r>", opts)
keymap("n", "<C-s>", ":w<cr>", opts)
keymap("n", "cd", ":cd %/..<cr>", opts)
keymap("n","<leader>qq",":wa<cr>:quitall<cr>", opts)
-- }}} general --
--
-- modes {{{ --
-- Normal --
keymap("n", ";", ":", opts)

-- keymap("n", "<C-a>", "mzggVG", opts)
keymap("n", "<leader>n", ":noh<cr>",opts)

keymap("n", "x", "\"_x", opts)

-- keymap("n","<leader>vs",":!code .<cr>", opts)
-- Insert --
keymap("i", "jk", "<ESC>", opts)
-- keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", ";", ":", opts)

keymap("v", "x", "\"_x", opts)

-- terminal --
-- }}} modes --

-- move {{{ --
keymap("n", "H", "^", opts)
keymap("n", "L", "g_", opts)
keymap("n", "J", "5j", opts)
-- keymap("n", "K", "5k", opts)
keymap("n", "k", "gk", opts)
keymap("n", "j", "gj", opts)
keymap("v", "H", "^", opts)
keymap("v", "L", "$", opts)
-- }}} move --
--
-- buffer window and tab {{{ --
-- buffers
keymap("n", "gb", ":bnext<CR>", opts)
keymap("n", "gB", ":bprevious<CR>", opts)
keymap("n", "<leader>d", ":bd<CR>", opts)

-- window
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
-- keymap("n", "<leader>v", ":vs<CR>", opts)
 -- Rotate screens
-- keymap("n", "rh", "<C-w>b<C-w>K", opts)
-- keymap("n", "rv", "<C-w>b<C-w>H", opts)

-- Resize with arrows
keymap("n", "<A-Up>", ":resize -2<CR>", opts)
keymap("n", "<A-Down>", ":resize +2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)

-- tabs
keymap("n", "<C-t>", ":tabnew<CR>", opts)
keymap("n", "<C-n>", "<C-W>T", opts)
-- }}} buffer window and tab --

-- text {{{ --
-- Move text up and down
keymap("v", "J", ":m .+1<CR>==gv", opts)
keymap("v", "K", ":m .-2<CR>==gv", opts)
-- keymap("v", "p", '"_dP', opts)

-- Move text up and down
-- keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
-- keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
-- Visual Block --
-- Move text up and down
-- keymap("n","<C-x>","<C-v>",opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
-- }}} text --

-- terminal {{{ --
-- function _G.set_terminal_keymaps()
--   vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], term_opts)
--   vim.keymap.set('t', 'jk', [[<C-\><C-n>]], term_opts)
-- end
-- vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
-- }}} terminal --

