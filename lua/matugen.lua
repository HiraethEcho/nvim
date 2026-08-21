 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#291b14',
    base01 = '#452d21',
    base02 = '#3e281e',
    base03 = '#716761',
    base04 = '#b6b1af',
    base05 = '#f3f2f2',
    base06 = '#f3f2f2',
    base07 = '#f3f2f2',
    base08 = '#fd4663',
    base09 = '#abcc66',
    base0A = '#d6c25c',
    base0B = '#e49067',
    base0C = '#cee996',
    base0D = '#ecb093',
    base0E = '#e9db96',
    base0F = '#910017',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f3f2f2',          bg = '#291b14' })
  hi('TelescopeBorder',         { fg = '#716761',             bg = '#291b14' })
  hi('TelescopePromptNormal',   { fg = '#f3f2f2',          bg = '#291b14' })
  hi('TelescopePromptBorder',   { fg = '#716761',             bg = '#291b14' })
  hi('TelescopePromptPrefix',   { fg = '#e49067',             bg = '#291b14' })
  hi('TelescopePromptCounter',  { fg = '#b6b1af',  bg = '#291b14' })
  hi('TelescopePromptTitle',    { fg = '#291b14',             bg = '#e49067' })
  hi('TelescopePreviewTitle',   { fg = '#291b14',             bg = '#d6c25c' })
  hi('TelescopeResultsTitle',   { fg = '#291b14',             bg = '#abcc66' })
  hi('TelescopeSelection',      { fg = '#f3f2f2',          bg = '#3e281e' })
  hi('TelescopeSelectionCaret', { fg = '#e49067',             bg = '#3e281e' })
  hi('TelescopeMatching',       { fg = '#e49067',             bold = true })
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
