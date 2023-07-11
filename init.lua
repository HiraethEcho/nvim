vim.cmd([[
    if(has("win32") || has("win64") || has("win95") || has("win16"))
        let g:iswindows = 1
    else
         let g:islinux = 1
    endif
]])

-- if vim.g.iswindows then
-- print("windows")
-- end
-- if  vim.g.islinux then
--   print("linux")
-- end

require('opt')
require('keymap')
require('gui')
require('lazynvim')

