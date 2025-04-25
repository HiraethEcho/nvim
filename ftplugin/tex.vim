nmap <localleader>e <Plug>(vimtex-env-toggle-math)
nmap <localleader>b <plug>(vimtex-delim-add-modifier)

setlocal foldmethod=expr
setlocal foldexpr=vimtex#fold#level(v:lnum)
setlocal foldtext=vimtex#fold#text()
