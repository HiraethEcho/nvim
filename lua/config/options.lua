vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

opt.autowrite = true          -- Enable auto write
opt.clipboard = "unnamedplus" -- Sync with system clipboard
-- opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 0          -- Hide * markup for bold and italic
opt.confirm = true            -- Confirm to save changes before exiting modified buffer
opt.cursorline = true         -- Enable highlighting of the current line
opt.cursorcolumn = false      -- Enable highlighting of the current line
opt.expandtab = true          -- Use spaces instead of tabs
opt.formatoptions = "jcqlnt"  -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true      -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 0
--[[
  'laststatus' = 0  never a status line
  'laststatus' = 1  status line if there is more than one window
  'laststatus' = 2  always a status line
  'laststatus' = 3  have a global statusline at the bottom instead of one for each window
]]
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
-- opt.number = true -- Print line number
-- opt.relativenumber = true -- Relative line numbers
opt.pumblend = 10      -- Popup blend
opt.pumheight = 10     -- Maximum number of entries in a popup
opt.scrolloff = 4      -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true  -- Round indent
opt.shiftwidth = 2     -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true })
opt.showmode = false   -- Dont show mode since we have a statusline
opt.sidescrolloff = 2  -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true   -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
-- opt.autoindent = true
opt.spell = false
opt.spelllang = { "en_US" }
opt.splitbelow = true    -- Put new windows below current
opt.splitright = true    -- Put new windows right of current
opt.tabstop = 2          -- Number of spaces tabs count for
opt.expandtab = true     -- convert tabs to spaces
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200               -- Save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5                -- Minimum window width
opt.wrap = false                   -- Disable line wrap
opt.linebreak = true               -- companion to wrap, don't split words
-- opt.whichwrap = "bs<>[]"     -- which "horizontal" keys are allowed to travel to prev/next line

opt.listchars:append("eol:↴")
opt.listchars:append "space:⋅"

opt.hidden = true -- 允许隐藏被修改过的buffer

--
-- vim.opt.cmdheight = 0              -- more space in the neovim command line for displaying messages

opt.autoread = true -- 当文件被外部程序修改时，自动加载
opt.backup = false
opt.writebackup = false
opt.swapfile = false

opt.foldmethod = "expr"
opt.foldlevel = 99
opt.foldexpr = "nvim_treesitter#foldexpr()"
