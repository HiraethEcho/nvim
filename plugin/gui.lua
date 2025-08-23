vim.o.guifont = "CodeNewRoman Nerd Font Mono:h12"
vim.opt.termguicolors = true -- True color support
if vim.g.neovide then
  vim.opt.linespace = -1
  -- Helper function for transparency formatting
  -- local alpha = function()
  --   return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
  -- end
  -- vim.g.neovide_background_color = "#ff1117" .. alpha()
  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  -- vim.g.transparency = 0.3
  vim.g.neovide_opacity = 1
  -- vim.g.neovide_window_blurred = true
  vim.keymap.set({ "n", "v" }, "<C-=>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
  vim.keymap.set({ "n", "v" }, "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
  -- map.set({ "n" , "v" }, "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>")
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0

  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5

  vim.g.neovide_show_border = true
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_scroll_animation_far_lines = 1
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_underline_stroke_scale = 1.0
  vim.g.neovide_confirm_quit = true
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.3
end
