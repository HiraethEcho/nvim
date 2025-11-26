-- https://github.com/ytrakita/dotfiles/
local api = vim.api

local M = {}

function M.highlight()
  api.nvim_set_hl(0, 'TabLineSeparator', { fg = '#2c3643', bg = '#3b444f' })
  api.nvim_set_hl(0, 'TabLineSel', {
    fg = '#8abee5', bg = '#2c3643', bold = true,
  })
end

local function filename(bnum)
  local bufname = api.nvim_buf_get_name(bnum)
  local basename = vim.fs.basename(bufname)
  local is_modified = api.nvim_get_option_value('modified', { buf = bnum })
  local is_readonly = api.nvim_get_option_value('readonly', { buf = bnum })
  return table.concat {
    basename == '' and '[No Name]' or basename,
    is_modified and ' +' or '',
    is_readonly and ' -' or '',
  }
end

function M.tabline()
  local tab_list = api.nvim_list_tabpages()
  local tab_cur = api.nvim_get_current_tabpage()
  local line = {}

  for i, tab in ipairs(tab_list) do
    local bnum = api.nvim_win_get_buf(api.nvim_tabpage_get_win(tab))

    if not (i == 1 or tab_list[i - 1] == tab_cur or tab == tab_cur) then
      table.insert(line, '%#TabLineSeparator#|%#TabLine#')
    end

    table.insert(line, '%' .. i .. 'T')

    if tab == tab_cur then
      table.insert(line, '%#TabLineSel# ')
    else
      table.insert(line, '%#TabLine# ')
    end

    table.insert(line, filename(bnum))
    table.insert(line, ' %T')
  end

  table.insert(line, '%#TabLineFill#')

  if #tab_list > 1 then
    table.insert(line, '%=%#TabLine#%999X✗ ')
  end

  return table.concat(line, '')
end

return M
