version 6.0
let s:cpo_save=&cpo
set cpo&vim
inoremap <silent> <C-Tab> =UltiSnips#ListSnippets()
imap <silent> <Plug>(cmpu-jump-backwards) =UltiSnips#JumpBackwards()
imap <silent> <Plug>(cmpu-jump-forwards) =UltiSnips#JumpForwards()
imap <silent> <Plug>(cmpu-expand) =[UltiSnips#CursorMoved(), UltiSnips#ExpandSnippet()][1]
inoremap <C-G>S <Plug>(nvim-surround-insert-line)
inoremap <C-G>s <Plug>(nvim-surround-insert)
inoremap <C-W> u
inoremap <C-U> u
snoremap <silent>  "_c
nmap <silent>  h
xnoremap <silent> 	 <Cmd>lua require("luasnip.util.select").pre_yank("z")gv"zs<Cmd>lua require('luasnip.util.select').post_yank("z")
snoremap <silent> 	 :call UltiSnips#ExpandSnippet()
nmap <silent> <NL> j
nmap <silent>  k
nmap <silent>  l
snoremap  "_c
nnoremap <silent>  <Cmd>tabnew
nmap  d
nnoremap <silent>  <Cmd>noh
nnoremap  hA <Cmd>Gitsigns undo_stage_hunk
nnoremap  ha <Cmd>Gitsigns stage_hunk
nnoremap  hu <Cmd>Gitsigns reset_hunk
nnoremap  hd <Cmd>Gitsigns toggle_deleted
nnoremap  hD <Cmd>Gitsigns diffthis
nnoremap  hw <Cmd>Gitsigns toggle_word_diff
nnoremap  gb <Cmd>Gitsigns blame
nnoremap  hP <Cmd>Gitsigns preview_hunk
nnoremap  hl <Cmd>Gitsigns toggle_linehl
nnoremap  hh <Cmd>Gitsigns toggle_numhl<Cmd>Gitsigns toggle_signs
nnoremap  Sa <Cmd>SessionToggleAutoSave
nnoremap  Ss <Cmd>SessionSave
nnoremap  Sr <Cmd>SessionSearch
nnoremap <silent>  q <Cmd>wqa
nnoremap <silent>  H :cd %:h
nnoremap <silent>   <Nop>
nnoremap & :&&
vnoremap <silent> ; :
nnoremap <silent> ; :
vnoremap <silent> < <gv
vnoremap <silent> > >gv
xnoremap <silent> <expr> @ mode() ==# 'V' ? ':normal! @'.getcharstr().'' : '@'
vnoremap <silent> H ^
nnoremap <silent> H ^
vnoremap <silent> L g_
nnoremap <silent> L g_
nnoremap <silent> Q q
xnoremap <silent> <expr> Q mode() ==# 'V' ? ':normal! @=reg_recorded()' : 'Q'
xnoremap S <Plug>(nvim-surround-visual)
nnoremap <silent> T <Cmd>tabprevious
nnoremap Y y$
nnoremap [h <Cmd>Gitsigns prev_hunk
nnoremap ]h <Cmd>Gitsigns next_hunk
nnoremap cS <Plug>(nvim-surround-change-line)
nnoremap cs <Plug>(nvim-surround-change)
nnoremap ds <Plug>(nvim-surround-delete)
xnoremap gS <Plug>(nvim-surround-visual-line)
xnoremap <silent> <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <silent> <expr> j v:count == 0 ? 'gj' : 'j'
xnoremap <silent> <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <silent> <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <silent> t <Cmd>tabNext
nnoremap <silent> x "_x
vnoremap <silent> x "_x
nnoremap ySS <Plug>(nvim-surround-normal-cur-line)
nnoremap yS <Plug>(nvim-surround-normal-line)
nnoremap yss <Plug>(nvim-surround-normal-cur)
nnoremap ys <Plug>(nvim-surround-normal)
snoremap <C-R> "_c
snoremap <silent> <C-H> "_c
snoremap <silent> <Del> "_c
snoremap <silent> <BS> "_c
snoremap <silent> <C-Tab> :call UltiSnips#ListSnippets()
smap <silent> <Plug>(cmpu-jump-backwards) :call UltiSnips#JumpBackwards()
smap <silent> <Plug>(cmpu-jump-forwards) :call UltiSnips#JumpForwards()
smap <silent> <Plug>(cmpu-expand) :call UltiSnips#ExpandSnippetOrJump()
nnoremap <Plug>PlenaryTestFile :lua require('plenary.test_harness').test_file(vim.fn.expand("%:p"))
nnoremap <C-0> <Cmd>LualineBuffersJump 10
nnoremap <C-9> <Cmd>LualineBuffersJump 9
nnoremap <C-8> <Cmd>LualineBuffersJump 8
nnoremap <C-7> <Cmd>LualineBuffersJump 7
nnoremap <C-6> <Cmd>LualineBuffersJump 6
nnoremap <C-5> <Cmd>LualineBuffersJump 5
nnoremap <C-4> <Cmd>LualineBuffersJump 4
nnoremap <C-3> <Cmd>LualineBuffersJump 3
nnoremap <C-2> <Cmd>LualineBuffersJump 2
nnoremap <C-1> <Cmd>LualineBuffersJump 1
nnoremap <silent> <C-Right> <Cmd>vertical resize +2
nnoremap <silent> <C-Left> <Cmd>vertical resize -2
nnoremap <silent> <C-Down> <Cmd>resize -2
nnoremap <silent> <C-Up> <Cmd>resize +2
nmap <silent> <C-K> k
nmap <silent> <C-J> j
nmap <silent> <C-H> h
nnoremap <silent> <C-T> <Cmd>tabnew
nmap <C-W><C-D> d
nmap <silent> <C-L> l
inoremap S <Plug>(nvim-surround-insert-line)
inoremap s <Plug>(nvim-surround-insert)
inoremap <silent> 	 =UltiSnips#ExpandSnippet()
inoremap  u
inoremap  u
inoremap <silent> , ,u
inoremap <silent> . .u
inoremap <silent> ; ;u
let &cpo=s:cpo_save
unlet s:cpo_save
set autowrite
set clipboard=unnamedplus
set cmdheight=0
set completeopt=menu,popup,menuone,noinsert,noselect,fuzzy,preview
set confirm
set expandtab
set fillchars=eob:\ ,fold:\ ,foldopen:,foldsep:\ ,foldclose:
set foldlevelstart=99
set formatoptions=jcqlnt
set grepformat=%f:%l:%c:%m
set grepprg=rg\ --vimgrep
set guifont=Maple\ Mono\ NF:h8
set helplang=en
set ignorecase
set listchars=extends:»,precedes:«,space:⋅,tab:▏\ ,trail:·
set noloadplugins
set mouse=a
set packpath=/usr/share/nvim/runtime
set pumblend=10
set pumheight=10
set runtimepath=~/.config/nvim,~/.local/share/nvim/lazy/lazy.nvim,~/.local/share/nvim/lazy/LuaSnip,~/.local/share/nvim/lazy/ultisnips,~/.local/share/nvim/lazy/nvim-treesitter,~/.local/share/nvim/lazy/blink.compat,~/.local/share/nvim/lazy/cmp-nvim-ultisnips,~/.local/share/nvim/lazy/blink.cmp,~/.local/share/nvim/lazy/tiny-inline-diagnostic.nvim,~/.local/share/nvim/lazy/plenary.nvim,~/.local/share/nvim/lazy/tiny-code-action.nvim,~/.local/share/nvim/lazy/nui.nvim,~/.local/share/nvim/lazy/noice.nvim,~/.local/share/nvim/lazy/nvim-web-devicons,~/.local/share/nvim/lazy/lualine.nvim,~/.local/share/nvim/lazy/gitsigns.nvim,~/.local/share/nvim/lazy/which-key.nvim,~/.local/share/nvim/lazy/auto-session,~/.local/share/nvim/lazy/nvim-surround,~/.local/share/nvim/lazy/mini.sessions,~/.local/share/nvim/lazy/mini.starter,~/.local/share/nvim/lazy/vimtex,~/.local/share/nvim/lazy/snacks.nvim,/usr/share/nvim/runtime,/usr/lib64/nvim,~/.local/share/nvim/lazy/ultisnips/after,~/.local/share/nvim/lazy/cmp-nvim-ultisnips/after,~/.local/share/nvim/lazy/vimtex/after,~/.config/nvim/after,~/.local/state/nvim/lazy/readme
set scrolloff=4
set sessionoptions=buffers,curdir,help,tabpages,terminal,localoptions
set shiftround
set shiftwidth=2
set shortmess=olCFtTOIcW
set noshowmode
set showtabline=2
set sidescrolloff=4
set smartcase
set smartindent
set spelllang=en_US
set splitbelow
set splitright
set statusline=%#lualine_transparent#
set noswapfile
set tabline=%#lualine_a_tabs_active#%1@LualineSwitchTab@\ cmp.lua\ %T%#lualine_transitional_lualine_a_tabs_active_to_lualine_c_buffers_inactive#%<%#lualine_c_buffers_inactive#%3@LualineSwitchBuffer@\ 1\ \ utils\ %T%#lualine_c_buffers_inactive#%4@LualineSwitchBuffer@\ 2\ \ options\ %T%#lualine_c_buffers_active#%5@LualineSwitchBuffer@\ 3\ \ cmp\ %T%#lualine_c_buffers_inactive#%6@LualineSwitchBuffer@\ 4\ \ lsp\ %T%#lualine_c_buffers_inactive#%7@LualineSwitchBuffer@\ 5\ \ md\ %T%#lualine_c_buffers_inactive#%8@LualineSwitchBuffer@\ 6\ \ lines\ %T%#lualine_c_normal#%=%#lualine_transitional_lualine_b_normal_to_lualine_c_normal#%#lualine_b_normal#\ ~/.config/nvim\ %#lualine_transitional_lualine_a_normal_to_lualine_b_normal#%#lualine_a_normal#\ config\ 
set tabstop=2
set termguicolors
set timeoutlen=300
set undofile
set undolevels=100
set updatetime=200
set virtualedit=block
set window=53
set winminwidth=10
set nowritebackup
" vim: set ft=vim :
