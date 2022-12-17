" general {{{ "
" nnoremap <C-.> :e $MYVIMRC<CR>
" nnoremap <leader>ss :Startify<CR>:BWipeout other<CR>
" nnoremap s <Nop>
nnoremap mn   : noh<CR>
nnoremap <F5> : w<CR> :source $MYVIMRC<CR>
nnoremap <F4> : PlugInstall<CR>
 nnoremap S    : w<CR>
nnoremap <C-s>    : w<CR>
nnoremap <C-a> mzggVG

nnoremap Q    : q<CR>
nnoremap U <C-r>
let mapleader=" "
vnoremap D "_d
nnoremap D "_d
nnoremap DD V"_d
nnoremap x "_x
inoremap <C-v> <Esc>"+pa
nnoremap <leader>lg :tabe<cr>:term lazygit<cr>i
nnoremap <leader>vs :!code .<cr>
" }}} general "
" Move {{{
nnoremap <silent> k gk
nnoremap <silent> j gj
nnoremap <silent> K 5k
nnoremap <silent> J 5j
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $
"move in insert mode
inoremap <M-h> <left>
inoremap <M-j> <down>
inoremap <M-k> <up>
inoremap <M-l> <right>
" inoremap <M-w> <Esc>wa
" inoremap <M-e> <Esc>ea
" inoremap <M-b> <Esc>ba
" inoremap <M-W> <Esc>Wa
" inoremap <M-E> <Esc>Ea
" inoremap <M-B> <Esc>Ba
" inoremap <M-H> <Esc>^i
" inoremap <M-L> <End>a
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
" nnoremap tmn :-tabmove<CR>
" nnoremap tmi :+tabmove<CR>
" tab
nnoremap <C-t> <Esc>:tabnew<CR>
nnoremap t <Esc>:tabnext<CR>
nnoremap T <Esc>:tabprevious <CR>
" }}}
" Modes {{{ "
inoremap jk <Esc>
nnoremap ; :
vnoremap ; :
cnoremap jk <Esc>
" }}} Modes "
