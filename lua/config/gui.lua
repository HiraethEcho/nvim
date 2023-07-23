if vim.g.neovide then
	vim.o.guifont = "CodeNewRoman Nerd Font:h14"
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

if vim.g.nvy then
	vim.o.guifont = "CodeNewRoman Nerd Font:h14"
	-- Put anything you want to happen only in Neovide here
end

if vim.g.nvui then
	vim.o.guifont = "CodeNewRoman Nerd Font:h14"
	-- Put anything you want to happen only in Neovide here
end

-- FVimBackgroundImage 'C:/foobar.png'   " background image
if vim.g.fvim_load then
	vim.o.guifont = "CodeNewRoman Nerd Font:h20"
	FVimBackgroundComposition = "transparent"
	FVimCursorSmoothMove = true
	FVimCursorSmoothBlink = true

	FVimBackgroundAltOpacity = 0.85
	FVimBackgroundImageStretch = "fill"
	FVimBackgroundImageOpacity = 0.85
	FVimCustomTitleBar = true
end
