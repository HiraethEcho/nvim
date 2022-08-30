" ui-special {{{ "

if exists("g:neovide")
" Put anything you want to happen only in Neovide here
  colorscheme solarized8_high
  set background=light
	let g:neovide_refresh_rate=30
	let g:neovide_refresh_rate_idle=5
	let g:neovide_transparency=1
	let g:neovide_scroll_animation_length = 0.9
	let g:neovide_remember_window_size = v:true
	let g:neovide_cursor_trail_length=0.8
	command -nargs=0 NeovideToggleFullscreen :let g:neovide_fullscreen = !g:neovide_fullscreen
  nnoremap <M-CR> :NeovideToggleFullscreen<CR>
  else
  if exists("g:nvui")
  nnoremap <M-CR> :NvuiToggleFullscreen<CR> 
  NvuiFrameless v:true
  NvuiOpacity 0.95
  NvuiCursorHideWhileTyping v:true
  "NvuiCmdline v:true
	NvuiCmdFontFamily CodeNewRoman_NF
  endif
" Terminal
  colorscheme solarized8_high
  set background=light
  let &t_ut=''
 " Set cursor shape and color
    " INSERT mode
  let &t_SI = "\<Esc>[6 q" . "\<Esc>]12;blue\x7"
    " REPLACE mode
  let &t_SR = "\<Esc>[3 q" . "\<Esc>]12;black\x7"
    " NORMAL mode
  let &t_EI = "\<Esc>[2 q" . "\<Esc>]12;green\x7"
" 1 -> blinking block  闪烁的方块
" 2 -> solid block  不闪烁的方块
" 3 -> blinking underscore  闪烁的下划线
" 4 -> solid underscore  不闪烁的下划线
" 5 -> blinking vertical bar  闪烁的竖线
" 6 -> solid vertical bar  不闪烁的竖线" 
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  set termguicolors
endif
" }}} ui-special "
"General{{{
set whichwrap+=<,>,h,l      " 允许backspace和光标键跨越行边界
set scrolloff=5 " 移动到顶部或底部的时候保持5行距离
set cursorline

set clipboard+=unnamedplus
set mouse=a


set nocompatible
set nobackup
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
set listchars=tab:>\ ,eol:¬,trail:·,extends:>,precedes:<
set autoindent " 自动缩进/下一行和上一行的格式相同
set cindent
"  fold
set foldmethod=marker
set foldlevel=100
highlight Folded guibg=lightgrey guifg=Purple
highlight FoldColumn guibg=darkgrey guifg=white

set autochdir         " auto chance director

set hlsearch           " 搜索高亮
set ignorecase         " 搜索忽略大小写
set smartcase          "只有一个大写字母的搜索词，将大小写敏感；其他情况都是写不敏感
set showmatch          " 高亮显示匹配的括号
set showmode           " 在底部显示，当前处于命令模式还是插入模式
set showcmd            " 命令模式下，在底部显示，当前键入的指令
set showtabline=1      "  only if there are at least two tab pages
set laststatus=3      " always and ONLY the last window

set statusline=
set statusline+=\ %t
set statusline+=%m\|
set statusline+=%=
set statusline+=\ %F\|
set statusline+=\ %l/%L\|%c
set statusline+=\ 

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

filetype on
filetype plugin indent on " 针对不同文件类型加载对应插件
syntax enable
syntax on
"}}}
"Keymappings{{{
nnoremap <Esc><Esc> :noh<CR>
nnoremap <F5>       :w<CR> :source $MYVIMRC<CR>
nnoremap <C-s>      :w<CR>
nnoremap Q          :q<CR>
nnoremap <C-Q>      :qa<CR>
let mapleader=" "
vnoremap D "_d
nnoremap D "_d
nnoremap DD V"_d
nnoremap x "_x
inoremap <C-v> <Esc>"+pa
" Move {{{
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> K 5k
noremap <silent> J 5j
noremap H ^
noremap L $
"move in insert mode
inoremap <M-h> <left>
inoremap <M-j> <down>
inoremap <M-k> <up>
inoremap <M-l> <right>
inoremap <M-w> <Esc>wa
inoremap <M-e> <Esc>ea
inoremap <M-b>  <Esc>ba
inoremap <M-W> <Esc>Wa
inoremap <M-E> <Esc>Ea
inoremap <M-B> <Esc>Ba
inoremap <M-H> <Esc>^i
inoremap <M-L> <End>
" }}}
" Windows and tabs{{{
"buffers
nnoremap <leader><tab> :bn<CR>
nnoremap <leader><S-tab> :bp<CR>
" 调整窗口大小
nnoremap <M-up> :res +5<CR>
nnoremap <M-down> :res -5<CR>
nnoremap <M-left> :vertical resize-5<CR>
nnoremap <M-right> :vertical resize+5<CR>
"移动到相应窗口
nnoremap <tab> <C-w>w
nnoremap <A-l> <C-w>l
nnoremap <A-k> <C-w>k
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
" 移动当前窗口
nnoremap <A-L> <C-w>L
nnoremap <A-K> <C-w>K
nnoremap <A-H> <C-w>H
nnoremap <A-J> <C-w>J
nnoremap <C-n> <C-W>T
" Rotate screens
nnoremap rh <C-w>b<C-w>K
nnoremap rv <C-w>b<C-w>H
" Move the tabs with tmn and tmi
nnoremap tmn :-tabmove<CR>
nnoremap tmi :+tabmove<CR>
" tab
nnoremap <C-t> <Esc>:tabnew<CR>
nnoremap <C-tab> <Esc>:tabnext<CR>
nnoremap <C-S-tab> <Esc>:tabprevious <CR>
" }}}
" Modes {{{ "
" === insert mode=====
inoremap jk <Esc>
inoremap jj <Esc>
inoremap <M-x> <BS>
inoremap <M-X> <DEL>
" === command mode=====
nnoremap ; :
vnoremap ; :
" === visual mode=====
"vnoremap jk <Esc>
" }}} Modes "
"}}}keymaping
"Plugs{{{
" list of backup plugs{{{
"Plug 'github/copilot.vim'
"Plug 'tomtom/tcomment_vim' " in <space>cn to comment a line
"Git{{{
"Plug 'theniceboy/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }
"Plug 'theniceboy/fzf-gitignore', { 'do': ':UpdateRemotePlugins' }
"Plug 'mhinz/vim-signify'
"Plug 'airblade/vim-gitgutter'
"Plug 'cohama/agit.vim'
"Plug 'kdheepak/lazygit.nvim'
"}}}
"miscellaneous{{{
"Plug 'voldikss/vim-translator', { 'on':'<Plug>Translate' }
" }}}
" }}}
"call plug{{{
call plug#begin('~/AppData/Local/nvim/plugged')
"Theme{{{
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'mhinz/vim-startify'
Plug 'feline-nvim/feline.nvim'
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
"}}}
"edit{{{
Plug 'lervag/vimtex'
Plug 'tpope/vim-surround' " type ysiw' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'tpope/vim-commentary'
Plug 'windwp/nvim-autopairs'
Plug 'godlygeek/tabular' "必要插件，安装在vim-markdown前面
" Markdown
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'}
"}}}
"completion{{{
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
"}}}
" fuzzy find {{{ "
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
"Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
" }}} fuzzy find "
"miscellaneous{{{
"Plug 'MattesGroeger/vim-bookmarks'
Plug 'crusj/bookmarks.nvim'
Plug 'easymotion/vim-easymotion'
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
function! UpdateRemotePlugins(...)
  " Needed to refresh runtime files
  let &rtp=&rtp
  UpdateRemotePlugins
endfunction
Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
" }}}
call plug#end()
"}}}
"Plug settings{{{
"themes{{{
let g:indentLine_fileTypeExclude = ['*.txt','startify']
"lua require('feline').setup()
"lua require('bufferline').setup()
" startify {{{ "
let g:startify_custom_header=startify#pad(split(system('figlet -w 100 Life is Wonderful'), '\n'))
let g:startify_custom_footer=startify#pad(split(system('figlet -w 100 And Sucks'), '\n'))
let g:startify_session_autoload= 1
"nnoremap <C-S> :SSave<cr>
let g:startify_files_number= 4
let g:startify_commands=[
      \ { 'E': 'CocCommand explorer --position tab:0' },
      \ { 'D': 'CocCommand explorer D:/' },
      \ { 'H': 'CocCommand explorer D:/Hiraeth' },
      \ { 'N': 'CocCommand explorer D:/Documents/MyNotes' },
      \ ]
let g:startify_lists= [
      \ { 'type': 'files'     , 'header': ['   Recent'    ] } ,
      \ { 'type': 'sessions'  , 'header': ['   Sessions'  ] } ,
      \ { 'type': 'commands'  , 'header': ['   Commands'  ] } ,
      \ ]
"}}} startify "
"}}}
"coc-settings {{{
let g:coc_global_extensions=['coc-snippets','coc-json','coc-typos','coc-vimlsp','coc-marketplace','coc-lists','coc-lists','coc-pairs','coc-explorer',]
let g:coc_node_path = 'D:\Program\scoop\apps\nodejs\current\node.exe'
inoremap <silent><expr> <tab>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
"inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab"
"inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
"inoremap <silent><expr> <C-p> coc#refresh()
" completion colors {{{ "
highlight Pmenu     guibg=#fdf6e3 guifg=LightBlue
highlight PmenuSel  guibg=#f4f7dc guifg=LightRed
" }}} completion colors "
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
"nnoremap <leader>md :CocCommand markdown-preview-enhanced.openPreview<CR>
nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]g <Plug>(coc-diagnostic-next)

" Use U to show documentation in preview window.
nnoremap <silent> U :call ShowDocumentation()<CR>


" 	if CocAction('hasProvider', 'hover')
" 		call CocActionAsync('doHover')
" 	else
" 		call feedkeys('U', 'in')
" 	endif
" endfunction

" autocmd CursorHold * silent call CocActionAsync('highlight')
"}}}
" Mappings for CoCList {{{
" Show all diagnostics.
nnoremap <silent><nowait> <leader>la : <C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>le : <C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <leader>lc : <C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>lo : <C-u>CocList outline<cr>
" Search workspace symbols.
"nnoremap <silent><nowait> <leader>ls : <C-u>CocList -I symbols<cr>
" Resume latest coc list.
"nnoremap <silent><nowait> <leader>ll : <C-u>CocListResume<CR>
" Show Typos
nnoremap <silent><nowait> <leader>lt : <c-u>CocList typos<CR>
" Show registers
nnoremap <silent><nowait> <leader>lr :<c-u>CocList registers<CR>
" Show all lists
nnoremap <silent><nowait> <leader>ll :<c-u>CocList lists<CR>
"	}}}
" coc typos {{{ 
" Move to next misspelled word after the cursor, 'wrapscan' applies.
nnoremap ]s <Plug>(coc-typos-next)
" Move to previous misspelled word after the cursor, 'wrapscan' applies.
nnoremap [s <Plug>(coc-typos-prev)
" Fix typo at cursor position
nnoremap S <Plug>(coc-typos-fix)
" }}} coc typos "
"pairs{{{
"let g:coc_pairs = [["$", "$"]]
"let g:coc_pairs_enableCharacters=[[ "(", "[", "{", "<", "'", "\\" , "`","\$"]]
lua << EOF
require("nvim-autopairs").setup {}
    local Rule = require('nvim-autopairs.rule')
    local npairs = require('nvim-autopairs')
    npairs.add_rule(Rule("$","$","vim"))
EOF
"}}}
" Directors {{{
" Telescope {{{ "
"lua require('telescope.builtin').find_files({layout_strategy='vertical',layout_config={width=0.5}})

nnoremap <leader>ff <cmd>Telescope find_files<CR>lsp
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fc <cmd>Telescope commands<cr>
"nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" }}} Telescope "
" bookmarks {{{ "
lua <<EOF
require("bookmarks").setup({
	keymap = {
		toggle = "<leader>mm", -- toggle bookmarks
		add = "<leader>ma", -- add bookmarks
		jump = "<CR>", -- jump from bookmarks
		delete = "dd", -- delete bookmarks
		order = "<leader>ml", -- order bookmarks by frequency or updated_time
	},
    width = 0.8, -- bookmarks window width:  (0, 1]
    height = 0.6, -- bookmarks window height: (0, 1]
    preview_ratio = 0.4, -- bookmarks preview window ratio (0, 1]
    preview_ext_enable = false, 
    hl_cursorline = "guibg=Gray guifg=White" -- hl bookmarsk window cursorline
    
})
EOF
  " let g:bookmark_no_default_key_mappings = 1
  " nmap <Leader>mm <Plug>BookmarkToggle
  " nmap <Leader>mi <Plug>BookmarkAnnotate
  " nmap <Leader>ma <Plug>BookmarkShowAll
  " nmap <Leader>mj <Plug>BookmarkNext
  " nmap <Leader>mk <Plug>BookmarkPrev
  " nmap <Leader>mc <Plug>BookmarkClear
  " nmap <Leader>mx <Plug>BookmarkClearAll
  " nmap <Leader>mK <Plug>BookmarkMoveUp
  " nmap <Leader>mJ <Plug>BookmarkMoveDown
" }}} bookmarks "
" coc-explorer {{{ "
highlight CocExplorerNormalFloatBorder guifg=#f4f7dc guibg=#ddd6c1
highlight CocExplorerNormalFloat guibg=#fdf6e3
nnoremap <silent><nowait> <leader>ee :CocCommand explorer<CR>
nnoremap <silent><nowait> <leader>et :CocCommand explorer --position tab:0<CR>
nnoremap <silent><nowait> <Leader>ef :CocCommand explorer --preset floating<CR>
nnoremap <silent><nowait> <Leader>ed :CocCommand explorer --preset Documents<CR>
nnoremap <silent><nowait> <Leader>eb :CocCommand explorer --preset buffer<CR>
nnoremap <silent><nowait> <Leader>en :CocCommand explorer --preset nvim<CR>
nnoremap <silent><nowait> <leader>,  :CocCommand explorer --preset nvim<CR>
" }}} coc-explorer "
" }}}
" }}}
" edit {{{
" markdown {{{
let g:vim_markdown_math = 1
let g:vmt_auto_update_on_save = 0
nnoremap <leader>md <Plug>MarkdownPreviewToggle
" }}} "
"vimtex{{{
let g:tex_flavor = 'latex'      " 设置 Tex 文档是 LaTeX 语法风格的文档：
let g:vimtex_quickfix_mode = 0 " 设置不自动弹出报错窗口，可以通过 :copen 来手动打开
" 设置预览 PDF 的工具是 sumatra 阅读器
let g:vimtex_view_general_viewer = 'SumatraPDF'
let g:vimtex_view_general_options='-reuse-instance -forward-search @tex @line @pdf'
" 设置 LaTeX 编译器
let g:vimtex_compiler_latexmk = {
			\ 'executable' : 'latexmk',
			\ 'options' : [
			\   '-xelatex',
			\   '-file-line-error',
			\   '-synctex=1',
			\   '-interaction=nonstopmode',
			\ ]
			\}
"     \ 'build_dir' : {-> 'out'},     
" 设置目录显示内容和显示宽度，并设置目录的自动刷新，设置后使用快捷键 \ +l+t (即敲入\lt)就可以打开目录。
let g:vimtex_toc_config = {
			\ 'name'         : 'TOC',
			\ 'layers'       : ['content', 'todo', 'include'],
			\ 'split_width'  : 40,
			\ 'todo_sorted'  : 0,
			\ 'show_help'    : 1,
			\ 'show_numbers' : 1,
			\}
"======}}}= vimtex setting ends====
"}}} edit
" miscellaneous {{{ "
" wilder{{{
call wilder#setup({'modes': [':', '/','?']})
call wilder#set_option('renderer', wilder#renderer_mux({
      \ ':'           : wilder#popupmenu_renderer({
      \ 'highlighter' : wilder#basic_highlighter(),
      \ 'pumblend'    : 5,
      \ 'left'        : [' ', wilder#popupmenu_devicons(),],
      \ 'right'       : [' ', wilder#popupmenu_scrollbar(),]
      \ }),
      \ '/': wilder#wildmenu_renderer({
      \ 'highlighter' : wilder#basic_highlighter(),
      \ 'separator'   : ' · ',
      \ 'left'        : [' ', wilder#wildmenu_spinner(), ' '],
      \ 'right'       : [' ', wilder#wildmenu_index()],
      \ })
      \ }))
call wilder#set_option('renderer', wilder#renderer_mux({
      \ ':'          : wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
      \ 'highlights' : {'border' : 'rounder', },
      \ 'border'     : 'double',
      \ })),
      \ '/'           : wilder#wildmenu_renderer({
      \ 'highlighter' : wilder#basic_highlighter(),
      \ 'separator'   : ' · ',
      \ 'left'        : [' ', wilder#wildmenu_spinner(), ' '],
      \ 'right'       : [' ', wilder#wildmenu_index()],
      \ })
			\ }))
"}}}
"}}} miscellaneous "
"}}}
