---
title: keymaps
---

# kemaps

local function

```lua

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

```

better commond

```lua
map({ "n", "v" }, ";", ":")
map({ "v", "n" }, "x", '"_x')
map("n", "<Space>", "<Nop>", { noremap = true, silent = true })
map("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
map("v", "<", "<gv")
map("v", ">", ">gv")

```

tabs, and windows

```lua
map("n", "t", "<cmd>tabNext<cr>", { desc = "Next Tab" })
map("n", "T", "<cmd>tabprevious<cr>", { desc = "previous Tab" })

map("n", "Q", "<c-w>q", { desc = "Close window" })
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

```

change root, and quit

```lua
map("n", "<leader>H", ":cd %:h<cr>", { desc = "set cwd to parent of current file" })
map("n", "<leader>q", "<cmd>wqa<cr>", { desc = "Quit all" })
```

some opinionated config

```lua
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "v" }, "H", "^")
map({ "n", "v" }, "L", "g_")
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")
```
