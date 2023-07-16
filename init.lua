vim.cmd([[
    if(has("win32") || has("win64") || has("win95") || has("win16"))
        let g:iswindows = 1
    else
         let g:islinux = 1
    endif
]])

require('config.options')
require('config.lazy')
require('config.keymaps')
require('config.util')
require('config.gui')
