function! WrapSelected(wrapper)
  normal! gv"zy
  let l:selected = getreg('z')
  cal setreg('z',a:wrapper . l:selected . a:wrapper)
  normal! gv"zp
  normal! gv
endfunction

vnoremap <buffer> <c-i> :<C-u>call WrapSelected('*')<CR>
" vnoremap <buffer> <c-b> :<C-u>call WrapSelected('**')<CR> " conflict with kitty

function! CreateMarkdownLink()
  normal! gv"ay
  let l:selected = getreg('a')
  let l:link = '[' . l:selected . ']()'
  cal setreg('a', l:link, getregtype('a'))
  normal! gv"ap
  startinsert
endfunction

vnoremap <buffer> <c-l> :<C-u>call CreateMarkdownLink()<CR>

