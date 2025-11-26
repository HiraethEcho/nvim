nmap <localleader>m <Plug>(vimtex-env-toggle-math)
" nmap <localleader>b <plug>(vimtex-delim-add-modifier)
nmap <localleader>e <plug>(vimtex-toc-toggle)
nmap <localleader>v <plug>(vimtex-view)
nmap <localleader>i <plug>(vimtex-imaps-list)
nmap <localleader>a <plug>(vimtex-context-menu)
nmap <localleader>s <plug>(vimtex-env-toggle-star)
   " tss              |<plug>(vimtex-env-toggle-star)|                `n`
   " tsd              |<plug>(vimtex-delim-toggle-modifier)|          `nx`

" setlocal foldmethod=expr
" setlocal foldexpr=vimtex#fold#level(v:lnum)
" setlocal foldtext=vimtex#fold#text()
" vim.o.foldlevel = 2

   " <localleader>li  |<plug>(vimtex-info)|                           `n`
   " <localleader>lI  |<plug>(vimtex-info-full)|                      `n`
   " <localleader>lt  |<plug>(vimtex-toc-open)|                       `n`
   " <localleader>lT  |<plug>(vimtex-toc-toggle)|                     `n`
   " <localleader>lq  |<plug>(vimtex-log)|                            `n`
   " <localleader>lv  |<plug>(vimtex-view)|                           `n`
   " <localleader>lr  |<plug>(vimtex-reverse-search)|                 `n`
   " <localleader>ll  |<plug>(vimtex-compile)|                        `n`
   " <localleader>lL  |<plug>(vimtex-compile-selected)|               `nx`
   " <localleader>lk  |<plug>(vimtex-stop)|                           `n`
   " <localleader>lK  |<plug>(vimtex-stop-all)|                       `n`
   " <localleader>le  |<plug>(vimtex-errors)|                         `n`
   " <localleader>lo  |<plug>(vimtex-compile-output)|                 `n`
   " <localleader>lg  |<plug>(vimtex-status)|                         `n`
   " <localleader>lG  |<plug>(vimtex-status-all)|                     `n`
   " <localleader>lc  |<plug>(vimtex-clean)|                          `n`
   " <localleader>lC  |<plug>(vimtex-clean-full)|                     `n`
   " <localleader>lm  |<plug>(vimtex-imaps-list)|                     `n`
   " <localleader>lx  |<plug>(vimtex-reload)|                         `n`
   " <localleader>lX  |<plug>(vimtex-reload-state)|                   `n`
   " <localleader>ls  |<plug>(vimtex-toggle-main)|                    `n`
   " <localleader>la  |<plug>(vimtex-context-menu)|                   `n`
   " dse              |<plug>(vimtex-env-delete)|                     `n`
   " dsc              |<plug>(vimtex-cmd-delete)|                     `n`
   " ds$              |<plug>(vimtex-env-delete-math)|                `n`
   " dsd              |<plug>(vimtex-delim-delete)|                   `n`
   " cse              |<plug>(vimtex-env-change)|                     `n`
   " csc              |<plug>(vimtex-cmd-change)|                     `n`
   " cs$              |<plug>(vimtex-env-change-math)|                `n`
   " csd              |<plug>(vimtex-delim-change-math)|              `n`
   " tsf              |<plug>(vimtex-cmd-toggle-frac)|                `nx`
   "                  |<plug>(vimtex-cmd-toggle-star-agn)|            `n`
   " tsc              |<plug>(vimtex-cmd-toggle-star)|                `n`
   " tss              |<plug>(vimtex-env-toggle-star)|                `n`
   " tse              |<plug>(vimtex-env-toggle)|                     `n`
   " ts$              |<plug>(vimtex-env-toggle-math)|                `n`
   " tsb              |<plug>(vimtex-env-toggle-break)|               `n`
   " <F6>             |<plug>(vimtex-env-surround-line)|              `n`
   "                  |<plug>(vimtex-env-surround-operator)|          `n`
   " <F6>             |<plug>(vimtex-env-surround-visual)|            `x`
   " tsd              |<plug>(vimtex-delim-toggle-modifier)|          `nx`
   " tsD              |<plug>(vimtex-delim-toggle-modifier-reverse)|  `nx`
   " <F7>             |<plug>(vimtex-cmd-create)|                     `nxi`
   " ]]               |<plug>(vimtex-delim-close)|                    `i`
   " <F8>             |<plug>(vimtex-delim-add-modifiers)|            `n`
   " ac               |<plug>(vimtex-ac)|                             `xo`
   " ic               |<plug>(vimtex-ic)|                             `xo`
   " ad               |<plug>(vimtex-ad)|                             `xo`
   " id               |<plug>(vimtex-id)|                             `xo`
   " ae               |<plug>(vimtex-ae)|                             `xo`
   " ie               |<plug>(vimtex-ie)|                             `xo`
   " a$               |<plug>(vimtex-a$)|                             `xo`
   " i$               |<plug>(vimtex-i$)|                             `xo`
   " aP               |<plug>(vimtex-aP)|                             `xo`
   " iP               |<plug>(vimtex-iP)|                             `xo`
   " am               |<plug>(vimtex-am)|                             `xo`
   " im               |<plug>(vimtex-im)|                             `xo`
   " %                |<plug>(vimtex-%)|                              `nxo`
   " ]]               |<plug>(vimtex-]])|                             `nxo`
   " ][               |<plug>(vimtex-][)|                             `nxo`
   " []               |<plug>(vimtex-[])|                             `nxo`
   " [[               |<plug>(vimtex-[[)|                             `nxo`
   " ]m               |<plug>(vimtex-]m)|                             `nxo`
   " ]M               |<plug>(vimtex-]M)|                             `nxo`
   " [m               |<plug>(vimtex-[m)|                             `nxo`
   " [M               |<plug>(vimtex-[M)|                             `nxo`
   " ]n               |<plug>(vimtex-]n)|                             `nxo`
   " ]N               |<plug>(vimtex-]N)|                             `nxo`
   " [n               |<plug>(vimtex-[n)|                             `nxo`
   " [N               |<plug>(vimtex-[N)|                             `nxo`
   " ]r               |<plug>(vimtex-]r)|                             `nxo`
   " ]R               |<plug>(vimtex-]R)|                             `nxo`
   " [r               |<plug>(vimtex-[r)|                             `nxo`
   " [R               |<plug>(vimtex-[R)|                             `nxo`
   " ]/               |<plug>(vimtex-]/)|                             `nxo`
   " ]*               |<plug>(vimtex-]star)|                          `nxo`
   " [/               |<plug>(vimtex-[/)|                             `nxo`
   " [*               |<plug>(vimtex-[star)|                          `nxo`
   " K                |<plug>(vimtex-doc-package)|                    `n`
