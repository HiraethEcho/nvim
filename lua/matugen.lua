 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#1b221c',
    base01 = '#2d392f',
    base02 = '#29332a',
    base03 = '#5e6e61',
    base04 = '#afb6b0',
    base05 = '#f2f3f2',
    base06 = '#f2f3f2',
    base07 = '#f2f3f2',
    base08 = '#fd4663',
    base09 = '#85a8ad',
    base0A = '#81b1a0',
    base0B = '#8bc193',
    base0C = '#afccd0',
    base0D = '#acd3b2',
    base0E = '#afd0c4',
    base0F = '#741d2b',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f2f3f2',          bg = '#1b221c' })
  hi('TelescopeBorder',         { fg = '#5e6e61',             bg = '#1b221c' })
  hi('TelescopePromptNormal',   { fg = '#f2f3f2',          bg = '#1b221c' })
  hi('TelescopePromptBorder',   { fg = '#5e6e61',             bg = '#1b221c' })
  hi('TelescopePromptPrefix',   { fg = '#8bc193',             bg = '#1b221c' })
  hi('TelescopePromptCounter',  { fg = '#afb6b0',  bg = '#1b221c' })
  hi('TelescopePromptTitle',    { fg = '#1b221c',             bg = '#8bc193' })
  hi('TelescopePreviewTitle',   { fg = '#1b221c',             bg = '#81b1a0' })
  hi('TelescopeResultsTitle',   { fg = '#1b221c',             bg = '#85a8ad' })
  hi('TelescopeSelection',      { fg = '#f2f3f2',          bg = '#29332a' })
  hi('TelescopeSelectionCaret', { fg = '#8bc193',             bg = '#29332a' })
  hi('TelescopeMatching',       { fg = '#8bc193',             bold = true })
end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M
