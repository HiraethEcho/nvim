set whichwrap+=<,>,h,l      " 允许backspace和光标键跨越行边界
set scrolloff=5 " 移动到顶部或底部的时候保持5行距离
set cursorline

set clipboard+=unnamedplus
set mouse=a

set nocompatible
set nobackup
set hidden
set noswapfile
set noerrorbells
set novisualbell

set wrap          " 设置字不超过窗口
set linebreak     "不会在单词内部折行
set tabstop=2
set shiftwidth=2  " 设置tab键和自动缩进
set softtabstop=2 " 设置显示行尾的空格和制表符/空格和tab的样式
set expandtab     " expand tab to space
set list
set listchars=eol:¬,trail:·,extends:>,precedes:<
set autoindent " 自动缩进/下一行和上一行的格式相同
set cindent
"fold
" set foldmethod=marker
set foldlevel=100
highlight Folded guibg=lightgrey guifg=Purple
highlight FoldColumn guibg=darkgrey guifg=white

set autochdir         " auto chance director

set hlsearch           " 搜索高亮
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=1000}
exec "nohlsearch"
set ignorecase         " 搜索忽略大小写
set smartcase          "只有一个大写字母的搜索词，将大小写敏感；其他情况都是写不敏感
set showmatch          " 高亮显示匹配的括号
set showmode           " 在底部显示，当前处于命令模式还是插入模式
set showcmd            " 命令模式下，在底部显示，当前键入的指令
set showtabline=1      "  only if there are at least two tab pages

set laststatus=3      " always and ONLY the last window
set number
set relativenumber

set splitbelow
set splitright "在被分割的窗口间显示空白，便于阅读
set fillchars=stl:-
set fillchars=stlnc:~
set fillchars=horiz:─
set fillchars=horizup:┴
set fillchars=horizdown:┬
set fillchars=vert:\|
set fillchars=vertleft:┤
set fillchars=vertright:├
set fillchars=verthoriz:┼
set fillchars=eob:`  " empty lines at the end of a buffer
set autoread  "开文件监视，如果编辑中文件发生外部改变就进行提示
set encoding=utf-8          " 使用 utf-8 编码
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" 命令模式下显示自动补全候选
set wildmenu
set wildmode=longest,full
set completeopt=menu,menuone    " 自动补全显示菜单
set wildignorecase
set wildignore+=.git,.hg,.svn,.stversions,*.pyc,*.spl,*.o,*.out,*~,%*
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store

syntax on
filetype on
filetype plugin indent on " 针对不同文件类型加载对应插件
syntax enable
