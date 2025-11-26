-- https://github.com/tsioryhaja/configs
local fn = vim.fn

local M = {}
M.MyTabline = function()
  local s = ''
  -- local bufnames = {}
  -- for index = 1, fn.tabpagenr('$') do
  --   local winnr = fn.tabpagewinnr(index)
  --   local buflist = fn.tabpagebuflist(index)
  --   local bufnr = buflist[winnr]
  --   local bufname = fn.bufname(bufnr)
  --
  -- end
  for index = 1, fn.tabpagenr('$') do
    local winnr = fn.tabpagewinnr(index)
    local buflist = fn.tabpagebuflist(index)
    local bufnr = buflist[winnr]
    local bufname = fn.bufname(bufnr)
    local bufmodified = fn.getbufvar(bufnr, '&mod')

    s = s .. '%' .. index .. 'T'
    if index == fn.tabpagenr() then
      s = s .. '%#TabLineSel#'
    else
      s = s .. '%#TabLine#'
    end
    s = s .. ' '
    if bufname ~= '' then
      s = s .. fn.fnamemodify(bufname, ':p:.') .. fn.fnamemodify(bufname, ':h:h')
    else
      s = s .. '[No name]'
    end
    if bufmodified == 1 then
      s = s .. '[+]'
    end
    s = s .. ' '
  end
  s = s .. '%#TabLineFill#'
  return s
end

-- local bufs = vim.iter(vim.api.nvim_list_bufs()):filter(vim.api.nvim_buf_is_loaded)local bufs = vim.iter(vim.api.nvim_list_bufs()):filter(vim.api.nvim_buf_is_loaded)
  -- if opts.sort_mru then
  --   table.sort(bufnrs, function(a, b)
  --     return vim.fn.getbufinfo(a)[1].lastused > vim.fn.getbufinfo(b)[1].lastused
  --   end)
  -- end
return M
