"call plug{{{
call plug#begin('~/AppData/Local/nvim/plugged')
" themes
Plug 'lukas-reineke/indent-blankline.nvim'
" Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
" Plug 'kyazdani42/nvim-web-devicons'
" Plug 'luochen1990/rainbow'
" git
Plug 'tpope/vim-fugitive' "git
Plug 'airblade/vim-gitgutter' "git
" edit
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'honza/vim-snippets'
" Plug 'stpope/vim-surrounds'
Plug 'machakann/vim-sandwich'
Plug 'wellle/targets.vim'
" Plug 'gcmt/wildfire.vim'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-peekaboo'
Plug 'godlygeek/tabular' "必要插件，安装在vim-markdown前面
" Plug 'dhruvasagar/vim-table-mode'
" Plug 'mbbill/undotree'
" Plug 'easymotion/vim-easymotion'
Plug 'phaazon/hop.nvim'
" editor
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'}
Plug 'lervag/vimtex'
" Plug 'vimwiki/vimwiki'
" director
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
" Plug 'kshenoy/vim-signature'
" Plug 'MattesGroeger/vim-bookmarks'
" Plug 'crusj/bookmarks.nvim'
"miscellaneous
function! UpdateRemotePlugins(...)
" Needed to refresh runtime files
let &rtp=&rtp
UpdateRemotePlugins
endfunction
Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
" Plug 'voldikss/vim-floaterm'
" Plug 'kazhala/close-buffers.nvim'
call plug#end()
"}}}
"Plug settings{{{ 
"dress up{{{ 
" airline {{{ "
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#buffer_nr_show = 1        "显示buffer编号
let g:airline#extensions#tabline#buffer_nr_format = '%s:'
let g:airline#extensions#battery#enabled = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_theme='onedark' 
" }}} airline "
"startify {{{ "
" let g:startify_custom_header=startify#pad(split(system('figlet -w 100 Life is Wonderful'), '\n'))
 let g:startify_custom_header=startify#pad(split(system('figlet -w 50 NeoVim '), '\n'))
" let g:startify_custom_footer=startify#pad(split(system('figlet -w 100 And Sucks'), '\n'))
 let g:startify_custom_footer=startify#pad(split(system('figlet -w 100 Awesome'), '\n'))
let g:startify_session_autoload= 1
"nnoremap <C-S> :SSave<cr>
let g:startify_files_number= 3
let g:startify_commands=[
      \ { 'E': 'CocCommand explorer --position tab:0' },
      \ { 'D': 'CocCommand explorer D:/' },
      \ { 'H': 'CocCommand explorer D:/Hiraeth' },
      \ { 'P': 'CocCommand explorer D:/Documents/Projects' },
      \ { 'G': 'CocCommand explorer D:/GitHub' },
      \ ]
let g:startify_lists= [
      \ { 'type': 'sessions'  , 'header': ['   Sessions'  ] } ,
      \ { 'type': 'files'     , 'header': ['   Recent'    ] } ,
      \ { 'type': 'commands'  , 'header': ['   Commands'  ] } ,
      \ ]
"}}} startify "
" " rainbow {{{ "
" let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
" let g:rainbow_conf = {
" \'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
" \'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
" \'guis': [''],
" \'cterms': [''],
" \'operators': '_,_',
" \'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
" \'separately': {
" \  '*': {},
" \  'markdown': {
" \    'parentheses_options': 'containedin=markdownCode contained', },
" \  'vim': {
" \    'parentheses_options': 'containedin=vimFuncBody', 
" \  },
" \  'stylus': {
" \    'parentheses': ['start=/{/ end=/}/ fold contains=@colorableGroup'], 
" \  }
" \}
" \}
" " }}} rainbow "
"}}}
"coc settings {{{
" let g:coc_global_extensions=['coc-snippets','coc-json','coc-typos','coc-vimlsp','coc-marketplace','coc-lists','coc-pairs','coc-explorer','coc-yank','coc-word','coc-dictionary']
let g:coc_global_extensions=['coc-snippets','coc-json','coc-typos','coc-vimlsp','coc-marketplace','coc-lists','coc-pairs','coc-explorer','coc-yank','coc-word']
let g:coc_node_path = 'D:\Program\scoop\apps\nodejs\current\node.exe'
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]g <Plug>(coc-diagnostic-next)

inoremap <silent><expr> <tab>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <C-o> coc#refresh()
vnoremap <BS> <Plug>(coc-snippets-select)
" inoremap <Space> <Plug>(coc-snippets-next)
"  let g:coc_snippet_next = '<tab>'
vnoremap <leader>s <Plug>(coc-convert-snippet)

highlight Pmenu     guibg=#fdf6e3 guifg=LightBlue
highlight PmenuSel  guibg=lightyellow guifg=green
" coc typos {{{ 
" nnoremap ]s <Plug>(coc-typos-next)
" nnoremap [s <Plug>(coc-typos-prev)
" nnoremap S <Plug>(coc-typos-fix)
" }}} coc typos "
" CoCList {{{
" Show all diagnostics.
nnoremap <silent><nowait> <leader>la : <C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>le : <C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <leader>lc : <C-u>CocList --normal commands<cr>
" Find symbol of current document.
" nnoremap <silent><nowait> <leader>lo : <C-u>CocList outline<cr>
" Search workspace symbols.
"nnoremap <silent><nowait> <leader>ls : <C-u>CocList -I symbols<cr>
" Resume latest coc list.
"nnoremap <silent><nowait> <leader>ll : <C-u>CocListResume<CR>
" Show Typos
" nnoremap <silent><nowait> <leader>lt : <c-u>CocList typos<CR>
" Show registers
nnoremap <silent><nowait> <leader>lr :<c-u>CocList registers<CR>
" show yank list
nnoremap <silent><nowait> <leader>li :<C-u>CocList yank<cr>
" Show all lists
nnoremap <silent><nowait> <leader>ll :<c-u>CocList lists<CR>
"  }}}
" }}}
" Directors {{{
" Telescope {{{ "
"lua require('telescope.builtin').find_files({layout_strategy='vertical',layout_config={width=0.5}})

" nnoremap <leader>ff <cmd>Telescope find_files<CR>lsp
" nnoremap <leader>fg <cmd>Telescope live_grep<cr>
" nnoremap <leader>fb <cmd>Telescope buffers<cr>
" nnoremap <leader>fc <cmd>Telescope commands<cr>
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" }}} Telescope "
" bookmarks {{{ "
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

  "signature {{{ "
  " let g:SignatureMap = {
  "   \ 'Leader'             :  "m",
  "   \ 'PlaceNextMark'      :  "m,",
  "   \ 'ToggleMarkAtLine'   :  "m.",
  "   \ 'PurgeMarksAtLine'   :  "m-",
  "   \ 'DeleteMark'         :  "dm",
  "   \ 'PurgeMarks'         :  "m<Space>",
  "   \ 'PurgeMarkers'       :  "m<BS>",
  "   \ 'GotoNextLineAlpha'  :  "']",
  "   \ 'GotoPrevLineAlpha'  :  "'[",
  "   \ 'GotoNextSpotAlpha'  :  "`]",
  "   \ 'GotoPrevSpotAlpha'  :  "`[",
  "   \ 'GotoNextLineByPos'  :  "]'",
  "   \ 'GotoPrevLineByPos'  :  "['",
  "   \ 'GotoNextSpotByPos'  :  "]`",
  "   \ 'GotoPrevSpotByPos'  :  "[`",
  "   \ 'GotoNextMarker'     :  "]-",
  "   \ 'GotoPrevMarker'     :  "[-",
  "   \ 'GotoNextMarkerAny'  :  "]=",
  "   \ 'GotoPrevMarkerAny'  :  "[=",
  "   \ 'ListBufferMarks'    :  "m/",
  "   \ 'ListBufferMarkers'  :  "m?"
  "   \ }
  " }}} signature "
" }}} bookmarks "
" coc-explorer {{{ "
highlight CocExplorerNormalFloatBorder guifg=#f4f7dc guibg=#ddd6c1
highlight CocExplorerNormalFloat guibg=#fdf6e3
nnoremap <silent><nowait> <leader>ee :CocCommand explorer<CR>
nnoremap <silent><nowait> <leader>et :CocCommand explorer --position tab:0<CR>
nnoremap <silent><nowait> <Leader>ef :CocCommand explorer --preset floating<CR>
nnoremap <silent><nowait> <Leader>ed :CocCommand explorer --preset Documents<CR>
nnoremap <silent><nowait> <Leader>eg :CocCommand explorer --preset github<CR>
nnoremap <silent><nowait> <Leader>ep :CocCommand explorer --preset Projects<CR>
nnoremap <silent><nowait> <Leader>eb :CocCommand explorer --preset buffer<CR>
nnoremap <silent><nowait> <Leader>eh :CocCommand explorer --preset hiraeth<CR>
nnoremap <silent><nowait> <leader>en :CocCommand explorer --preset nvim<CR>
" }}} coc-explorer "
" }}}
" editor {{{ "
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
      \ 'show_numbers' : 2,
      \}
" set foldmethod=expr
" set foldexpr=vimtex#fold#level(v:lnum)
" set foldtext=vimtex#fold#text()
" let g:vimtex_fold_enabled= 1
" let g:vimtex_fold_manual=0
" let g:vimtex_fold_levelmarker      =1
" let g:vimtex_fold_types            =1
" let g:vimtex_fold_types_defaults   =1
" let g:vimtex_fold_bib_enabled      =1
" let g:vimtex_fold_bib_max_key_width=1
"}}}vimtex
" vimwiki {{{ "
" let wiki_1 = {}
" let wiki_1.path = 'D:/my_docs/'
" let wiki_1.html_template = '~/public_html/template.tpl'
" let wiki_1.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}

" let wiki_2 = {}
" let wiki_2.path = 'D:/project_docs/'
" let wiki_2.index = 'main'

" let g:vimwiki_list = [wiki_1, wiki_2]

" }}} vimwiki "
" }}} editor "
" edit {{{
" " wildfire {{{ "
"     let g:wildfire_objects = {
"         \ "*" : ["i'", 'i"', "i)", "i]", "i}","i$"],
"         \ "html,xml" : ["at"], 
"         \}
" " }}} wildfire "
" hop {{{ 
lua << EOF
require'hop'.setup()
keys = 'qweruioasdfjkl'
vim.api.nvim_set_keymap('', '<leader>j', "<cmd>lua require'hop'.hint_vertical()<cr>", {})
vim.api.nvim_set_keymap('', 'F', "<cmd>lua require'hop'.hint_char1()<cr>", {})
EOF
nnoremap f :HopChar1CurrentLine<cr>
" vim.api.nvim_set_keymap('', 'f', "<cmd>lua require'hop'.hint_char1()<cr>", {})
" jump_on_sole_occurrence = true,
" multi_windows = true,
" case_insensitive = false,
" vim.api.nvim_set_keymap('', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})

" }}} hop "
" undotree {{{ "
" let g:undotree_WindowLayout=2
" nnoremap <C-u> :UndotreeToggle<cr>
" }}} undotree 
"}}} edit
"}}} plug setting
