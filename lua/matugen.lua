 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#291d14',
    base01 = '#453121',
    base02 = '#3e2c1e',
    base03 = '#706861',
    base04 = '#b6b2af',
    base05 = '#f3f2f2',
    base06 = '#f3f2f2',
    base07 = '#f3f2f2',
    base08 = '#9e6940',
    base09 = '#a0cc66',
    base0A = '#d6ce5c',
    base0B = '#e49e67',
    base0C = '#c5e996',
    base0D = '#ecba93',
    base0E = '#e9e396',
    base0F = '#3c2310',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f3f2f2',          bg = '#291d14' })
  hi('TelescopeBorder',         { fg = '#706861',             bg = '#291d14' })
  hi('TelescopePromptNormal',   { fg = '#f3f2f2',          bg = '#291d14' })
  hi('TelescopePromptBorder',   { fg = '#706861',             bg = '#291d14' })
  hi('TelescopePromptPrefix',   { fg = '#e49e67',             bg = '#291d14' })
  hi('TelescopePromptCounter',  { fg = '#b6b2af',  bg = '#291d14' })
  hi('TelescopePromptTitle',    { fg = '#291d14',             bg = '#e49e67' })
  hi('TelescopePreviewTitle',   { fg = '#291d14',             bg = '#d6ce5c' })
  hi('TelescopeResultsTitle',   { fg = '#291d14',             bg = '#a0cc66' })
  hi('TelescopeSelection',      { fg = '#f3f2f2',          bg = '#3e2c1e' })
  hi('TelescopeSelectionCaret', { fg = '#e49e67',             bg = '#3e2c1e' })
  hi('TelescopeMatching',       { fg = '#e49e67',             bold = true })
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
