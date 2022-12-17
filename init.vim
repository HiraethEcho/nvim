" ui-special {{{ "
if exists("g:neovide")
colorscheme solarized8_high
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 1
let g:indent_guides_indent_levels = 30
set background=dark
let g:neovide_refresh_rate=30
let g:neovide_refresh_rate_idle=5
let g:neovide_transparency=0.9
let g:neovide_scroll_animation_length = 0.9
let g:neovide_remember_window_size = v:true
let g:neovide_cursor_trail_length=0.8
command -nargs=0 NeovideToggleFullscreen :let g:neovide_fullscreen = !g:neovide_fullscreen
nnoremap <M-CR> :NeovideToggleFullscreen<CR>
let s:fontsize = 16
set guifont=CodeNewRoman_NF:h16
function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
  :execute "set guifont=CodeNewRoman_NF:h" . s:fontsize 
endfunction
nnoremap <C-up> :call AdjustFontSize(1)<CR> 
nnoremap <C-down> :call AdjustFontSize(-1)<CR>
else
    if exists("g:nvui")
    colorscheme solarized8_high
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_auto_colors = 1
    let g:indent_guides_indent_levels = 30
    set background=light
    let s:fontsize = 16
    function! AdjustFontSize(amount)
      let s:fontsize = s:fontsize+a:amount
      :execute "set guifont=FiraCode_NF:h" . s:fontsize 
    endfunction
    nnoremap <C-up> :call AdjustFontSize(1)<CR> 
    nnoremap <C-down> :call AdjustFontSize(-1)<CR>
    nnoremap <M-CR> :NvuiToggleFullscreen<CR> 
    NvuiFrameless v:true
    NvuiOpacity 0.95
    NvuiCursorHideWhileTyping v:true
    " NvuiCmdFontFamily CodeNewRoman_NF
    else
" Terminal and nvim-qt
colorscheme solarized8_high
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 1
let g:neovide_refresh_rate=30
set background=light
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
  " INSERT mode
    let &t_SI = "\<Esc>[6 q"
  " REPLACE mode
    let &t_SR = "\<Esc>[3 q"
  " NORMAL mode
    let &t_EI = "\<Esc>[1 q"
" " 1 -> blinking block  闪烁的方块 "
" " 2 -> solid block  不闪烁的方块 "
" " 3 -> blinking underscore  闪烁的下划线 "
" " 4 -> solid underscore  不闪烁的下划线 "
" " 5 -> blinking vertical bar  闪烁的竖线 "
" " 6 -> solid vertical bar  不闪烁的竖线 "
endif
endif
" }}} ui-special "
source config\general.vim
source config\keymap.vim
source config\plugin.vim
" miscellaneous {{{ "
" nnoremap <C-a> :r !figlet 
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
      \ 'Separator'   : ' · ',
      \ 'left'        : [' ', wilder#wildmenu_spinner(), ' '],
      \ 'right'       : [' ', wilder#wildmenu_index()],
      \ })
      \ }))
"}}}
"}}} miscellaneous "
