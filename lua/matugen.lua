 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#0e1f2f',
    base01 = '#17344f',
    base02 = '#152f47',
    base03 = '#616971',
    base04 = '#afb3b6',
    base05 = '#f2f2f3',
    base06 = '#f2f2f3',
    base07 = '#f2f2f3',
    base08 = '#fd4663',
    base09 = '#9762d0',
    base0A = '#5c5ed6',
    base0B = '#67a8e4',
    base0C = '#be96e9',
    base0D = '#93c1ec',
    base0E = '#9697e9',
    base0F = '#910017',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f2f2f3',          bg = '#0e1f2f' })
  hi('TelescopeBorder',         { fg = '#616971',             bg = '#0e1f2f' })
  hi('TelescopePromptNormal',   { fg = '#f2f2f3',          bg = '#0e1f2f' })
  hi('TelescopePromptBorder',   { fg = '#616971',             bg = '#0e1f2f' })
  hi('TelescopePromptPrefix',   { fg = '#67a8e4',             bg = '#0e1f2f' })
  hi('TelescopePromptCounter',  { fg = '#afb3b6',  bg = '#0e1f2f' })
  hi('TelescopePromptTitle',    { fg = '#0e1f2f',             bg = '#67a8e4' })
  hi('TelescopePreviewTitle',   { fg = '#0e1f2f',             bg = '#5c5ed6' })
  hi('TelescopeResultsTitle',   { fg = '#0e1f2f',             bg = '#9762d0' })
  hi('TelescopeSelection',      { fg = '#f2f2f3',          bg = '#152f47' })
  hi('TelescopeSelectionCaret', { fg = '#67a8e4',             bg = '#152f47' })
  hi('TelescopeMatching',       { fg = '#67a8e4',             bold = true })
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
