-- vim.g.mapleader = " "
-- vim.g.maplocalleader = ","

vim.g.mapleader = vim.keycode("<space>")
vim.g.maplocalleader = vim.keycode(",")

local opt = vim.opt
-- edit
opt.clipboard = "unnamedplus" -- Sync with system clipboard
-- vim.o.timeout = true --default on
-- opt.timeoutlen = 300 -- default 1000
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.expandtab = true -- Use spaces instead of tabs
opt.mouse = "a" -- Enable mouse mode
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.expandtab = true -- convert tabs to spaces
opt.tabstop = 2 -- Number of spaces tabs count for
opt.smartindent = true -- Insert indents automatically
opt.formatoptions = "jcqnt" -- tcqj
opt.spell = false
opt.spelllang = { "en_US" }
opt.completeopt = { "menu", "popup", "menuone", "noinsert", "noselect", "fuzzy", "preview" }

-- vertical horizontal miscellaneou
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.cursorline = false -- Enable highlighting of the current line
opt.cursorcolumn = false -- Enable highlighting of the current column
opt.colorcolumn = "120" -- Line length marker at 80 columns
opt.scrolloff = 4 -- Lines of context
opt.sidescrolloff = 4 -- Columns of context
opt.shortmess:append({ W = true, I = true, c = true })
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.list = true -- Show some invisible characters (tabs...
-- opt.listchars:append("eol:↴")
-- opt.listchars:append("space:⋅")
opt.listchars = { -- NOTE: using `vim.opt` instead of `vim.o` to pass rich object
  tab = "▏ ",
  trail = "·",
  -- extends = "»",
  -- precedes = "«",
  space = "⋅",
  eol = "↴",
}
-- opt.whichwrap = "bs<>[]"     -- which "horizontal" keys are allowed to travel to prev/next line
-- opt.winminwidth = 10 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.linebreak = true -- companion to wrap, don't split words

-- bottom line: command search statusline
-- opt.wildmode = "longest:full,full" -- Command-line completion mode
-- opt.pumblend = 10 -- Popup blend
-- opt.pumheight = 10 -- Maximum number of entries in a popup
-- opt.showmode = false -- Dont show mode since we have a statusline
opt.smartcase = true -- Don't ignore case with capitals
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 2
opt.showtabline = 2
--[[
  'laststatus' = 0  never a status line
  'laststatus' = 1  status line if there is more than one window
  'laststatus' = 2  always a status line
  'laststatus' = 3  have a global statusline at the bottom instead of one for each window
]]
-- opt.cmdheight = 1              -- more space in the neovim command line for displaying messages
-- vim.opt.showcmdloc="statusline" -- useful when 'cmdheight' is 0.

-- file
opt.autoread = true -- 当文件被外部程序修改时，自动加载
opt.backup = false
opt.writebackup = false
opt.swapfile = false
-- opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.undofile = true
-- opt.undolevels = 100
opt.hidden = true -- 允许隐藏被修改过的buffer
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.autowrite = true -- Enable auto write

