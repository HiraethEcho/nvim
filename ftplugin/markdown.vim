" vnoremap <buffer> <c-i> <esc>`>a*<esc>`<i*<esc>lv`>l

function! WrapSelected(wrapper)
  let l:save_a = getregtype('a')
  let l:save_aold = getregtype('a')
  normal! gv"ay
  let l:selected = getreg('a')
  cal setreg('a',a:wrapper . l:selected . a:wrapper, getregtype('a'))
  normal! gv"ap
  cal setreg('a',l:save_a, l:save_aold)
  normal! gv
endfunction

" vnoremap <buffer> <c-i> :<C-u>call WrapSelected('*')<CR>
