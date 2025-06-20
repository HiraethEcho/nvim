vim.g.mapleader = " "
vim.g.maplocalleader = ","

local opt = vim.opt
-- edit
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.timeoutlen = 300
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.expandtab = true -- Use spaces instead of tabs
opt.mouse = "a" -- Enable mouse mode
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.expandtab = true -- convert tabs to spaces
opt.tabstop = 2 -- Number of spaces tabs count for
opt.smartindent = true -- Insert indents automatically
opt.formatoptions = "jcqlnt" -- tcqj
opt.spell = false
opt.spelllang = { "en_US" }

-- vertical horizontal miscellaneou
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.cursorline = true -- Enable highlighting of the current line
opt.cursorcolumn = false -- Enable highlighting of the current line
opt.scrolloff = 4 -- Lines of context
opt.sidescrolloff = 4 -- Columns of context
opt.shortmess:append({ W = true, I = true, c = true })
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.list = true -- Show some invisible characters (tabs...
-- opt.listchars:append("eol:↴")
opt.listchars:append("space:⋅")
-- opt.whichwrap = "bs<>[]"     -- which "horizontal" keys are allowed to travel to prev/next line
opt.winminwidth = 10 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.linebreak = true -- companion to wrap, don't split words

-- bottom line: command search statusline
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.showmode = false -- Dont show mode since we have a statusline
opt.smartcase = true -- Don't ignore case with capitals
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 0
opt.showtabline = 2
--[[
  'laststatus' = 0  never a status line
  'laststatus' = 1  status line if there is more than one window
  'laststatus' = 2  always a status line
  'laststatus' = 3  have a global statusline at the bottom instead of one for each window
]]
-- opt.cmdheight = 0              -- more space in the neovim command line for displaying messages

-- file
opt.autoread = true -- 当文件被外部程序修改时，自动加载
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.undofile = true
opt.undolevels = 100
opt.hidden = true -- 允许隐藏被修改过的buffer
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.autowrite = true -- Enable auto write

-- fold
-- opt.foldmethod = "indent"
-- opt.foldenable = true
-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
-- opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- opt.foldlevelstart = 99
-- opt.fillchars = "fold: " -- Remove the trailing dots
-- opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- opt.foldminlines = 0 -- Allow folding/hiding single lines
-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

vim.g.loaded_matchparen = 1 -- "utilyre/sentiment.nvim",
