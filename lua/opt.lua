vim.opt.clipboard = "unnamedplus"  -- allows neovim to access the system clipboard
vim.opt.conceallevel = 0           -- so that `` is visible in markdown files

vim.opt.fileencoding = "utf-8"     -- the encoding written to a file
vim.g.encoding = "UTF-8"

vim.opt.hlsearch = true            -- highlight all matches on previous search pattern
-- vim.cmd([[
-- 'autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=1000}')
-- exec "nohlsearch"
-- ]])

vim.opt.mouse = "a"                -- allow the mouse to be used in neovim

vim.opt.splitbelow = true          -- force all horizontal splits to go below current window
vim.opt.splitright = true          -- force all vertical splits to go to the right of current window


vim.opt.timeoutlen = 400           -- time to wait for a mapped sequence to complete (in milliseconds)
-- vim.opt.undofile = true            -- enable persistent undo
vim.opt.updatetime = 50           -- faster completion (4000ms default)

vim.opt.expandtab = true           -- convert tabs to spaces
vim.opt.shiftwidth = 2             -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2                -- insert 2 spaces for a tab
vim.opt.softtabstop=2 -- 设置显示行尾的空格和制表符/空格和tab的样式
vim.o.shiftround = true -- 缩进2个空格等于一个Tab
vim.opt.smartindent = true         -- make indenting smarter again
vim.opt.autoindent = true
vim.opt.cindent = true

vim.opt.cursorline = true          -- highlight the current line
vim.opt.number = true              -- set numbered lines
vim.opt.relativenumber = false      -- set relative numbered lines
vim.opt.numberwidth = 2            -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes"         -- always show the sign column, otherwise it would shift the text each time

vim.opt.wrap = false                -- display lines as one long line
vim.opt.linebreak = true           -- companion to wrap, don't split words
vim.opt.whichwrap = "bs<>[]"     -- which "horizontal" keys are allowed to travel to prev/next line
-- vim.opt.whichwrap = "bs<>[]hl"     -- which "horizontal" keys are allowed to travel to prev/next line

vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5 
vim.opt.list = true
-- vim.opt.listchars:append "eol:↴"

vim.wo.colorcolumn = "80"-- 右侧参考线，超过表示代码太长了，考虑换行
vim.o.hidden = true -- 允许隐藏被修改过的buffer

vim.opt.termguicolors = true

-- 补全增强
-- vim.o.wildmenu = true
-- vim.cmd('set wildmode=longest,full')
-- vim.cmd('set wildignore+=.git,.hg,.svn,.stversions,*.pyc,*.spl,*.o,*.out,*~,%*')
-- vim.cmd('set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store')
vim.g.completeopt = "menu,menuone,noselect,noinsert"
vim.opt.ignorecase = true          -- ignore case in search patterns
vim.o.shortmess = vim.o.shortmess .. "c" -- Dont' pass messages to |ins-completin menu|
vim.opt.showmatch = true
vim.opt.smartcase = true           -- smart case
vim.opt.pumheight = 6             -- pop up menu height
--
vim.o.showcmd = true
vim.opt.cmdheight = 1              -- more space in the neovim command line for displaying messages
vim.o.showmode = false
-- vim.o.laststatus = 3   --always and ONLY the last window
-- vim.o.showtabline = 1--only if there are at least two tab pages

vim.opt.autoread = true-- 当文件被外部程序修改时，自动加载
-- 禁止创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- vim.opt.shortmess = "ilmnrx"                        -- flags to shorten vim messages, see :help 'shortmess'
-- vim.opt.iskeyword:append "-"      -- hyphenated words recognized by searches
-- vim.opt.formatoptions:remove({ "c", "r", "o" })        -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
--
--
-- vim.o.shell = 'powershell'
-- vimscript {{{ --
vim.cmd([[
set viminfo='10,\"100,:20,%,n~/AppData/Local/nvim/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
]])
-- filetype on
-- filetype plugin indent on " 针对不同文件类型加载对应插件
-- syntax on
-- syntax enable
-- }}} vimscript --
