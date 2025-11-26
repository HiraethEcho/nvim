-- https://github.com/makmonty/dotfiles
vim.api.nvim_exec([[
  function MyTabLine()
    let s = ''
    for index in range(tabpagenr('$'))
      let i = index + 1
      let winnr = tabpagewinnr(i)

      " Get buf infos
      let buflist = tabpagebuflist(i)
      let bufspnr = buflist[winnr - 1]
      let bufmodif = getbufvar(bufspnr, '&mod')
      let label = bufname(bufspnr)

      " select the highlighting
      if i == tabpagenr()
        let s ..= '%#TabLineSel#'
      else
        let s ..= '%#TabLine#'
      endif

      " set the tab page number (for mouse clicks)
      let s ..= '%' .. i .. 'T'

      " modified flag
      if bufmodif != 0
        " Set modified flag
        let s ..= ' *'
      else
        let s ..= ''
      endif

      " the label
      let s ..= ' ' .. label .. ' '

      " close button
      let s ..= '%' .. i ..'X× '
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s ..= '%#TabLineFill#%T'

    " right-align the label to close the current tab page
    "if tabpagenr('$') > 1
    "  let s ..= '%=%#TabLine#%999Xclose'
    "endif

    return s
  endfunction

  function MyTabLabel(i)
    let buflist = tabpagebuflist(a:i)
    let winnr = tabpagewinnr(a:i)
    return bufname(buflist[winnr - 1])
  endfunction

  :set tabline=%!MyTabLine()
]], true)
