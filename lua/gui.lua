-- vim.cmd([[colorscheme deus]])
--
-- highlight NotifyERRORBorder guifg=#8A1F1F
-- highlight NotifyWARNBorder guifg=#79491D
-- highlight NotifyINFOBorder guifg=#4F6752
-- highlight NotifyDEBUGBorder guifg=#8B8B8B
-- highlight NotifyTRACEBorder guifg=#4F3552
-- highlight NotifyERRORIcon guifg=#F70067
-- highlight NotifyWARNIcon guifg=#F79000
-- highlight NotifyINFOIcon guifg=#A9FF68
-- highlight NotifyDEBUGIcon guifg=#8B8B8B
-- highlight NotifyTRACEIcon guifg=#D484FF
-- highlight NotifyERRORTitle  guifg=#F70067
-- highlight NotifyWARNTitle guifg=#F79000
-- highlight NotifyINFOTitle guifg=#A9FF68
-- highlight NotifyDEBUGTitle  guifg=#8B8B8B
-- highlight NotifyTRACETitle  guifg=#D484FF

if vim.g.neovide then
    -- Put anything you want to happen only in Neovide here
vim.o.guifont = "CodeNewRoman Nerd Font:h14" -- text below applies for VimScript
vim.opt.linespace = 0
vim.g.neovide_scale_factor = 1.0
vim.g.neovide_padding_top = 0
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_right = 0
vim.g.neovide_padding_left = 0
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
vim.g.neovide_transparency = 0.9
vim.g.neovide_scroll_animation_length = 0.2
vim.g.neovide_hide_mouse_when_typing = true
-- vim.g.neovide_refresh_rate = 60
vim.g.neovide_remember_window_size = true
vim.g.neovide_cursor_animation_length = 0.13 -- Setting g:neovide_cursor_animation_length determines the time it takes for the cursor to complete it's animation in seconds. Set to 0 to disable.
end
