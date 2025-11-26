-- https://github.com/Lite5h4dow/.dotfiles
local fn = vim.fn
local api = vim.api


local schema = require('color').schema
local table_length = require('utils').table_length

-- mode dictionary
local modes = setmetatable(
  {
    n    ={text=" NOR", color = schema.purple},
    i    ={text=" INS", color = schema.teal},
    c    ={text=" CMD", color = schema.orange},
    v    ={text=" VIS", color = schema.blue},
    V    ={text=" L·V", color = schema.blue},
    [''] ={text=" B·V", color = schema.blue},
    R    ={text=" REP", color = schema.red}
  },{
    __index = function()
      return "UNK"
    end
  }

)

--seperator
local sep = {
  open = "",
  close = "",
}

--vim mode
local function get_current_mode()
  local cur_mode = vim.api.nvim_get_mode().mode
  vim.cmd(string.format("hi StatusLineMode guibg=%s", modes[cur_mode].color))
  vim.cmd(string.format("hi StatisLineSepMode_0 guifg=%s", modes[cur_mode].color))
  return modes[cur_mode].text
end  

-- make sure buffer isnt empty
local buffer_empty= function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return false
  end
  return true 
end

local function string_split(str, sep)
  if sep == nil then sep = "%s" end
  local t = {}
  for sub in string.gmatch(str, "([^"..sep.."]+)") do
    table.insert(t, sub)
  end
  return t
end


local function yadm_extension_cleaner(ext)
  return string_split(ext, "##")[1]
end

local function get_file_icon(filename, extension)
  file_icon = ""
  ext = extension
    if string.find(ext, "##") then
      ext = yadm_extension_cleaner(extension)
    end
  file_icon = require'nvim-web-devicons'.get_icon(filename, ext)
  return file_icon
end

local function print_fix(thing)
  if type(thing) ~= "string" then return "" end
  if thing ~= "" then return thing .. " " else return "" end
end

-- file info
local function get_file_info()
  local file_path = vim.fn.expand('%:p:.')
  local file_name = vim.fn.expand('%:t')
  if buffer_empty then file_name = "[buffer]" end
  local file_extension = vim.fn.expand("%:e")
  if string.find(file_extension, "##") then file_extension = yadm_extension_cleaner(file_extension) end
  local read_only_icon = "" 
  if vim.bo.filetype == 'help' or vim.bo.readonly == true then read_only_icon = '' end
  local modified_icon = ''
  if vim.bo.modifiable then
    if vim.bo.modified then
      modified_icon = ''
      vim.cmd(string.format("hi StatusLineFileName guifg=%s", schema.red))
    else
      vim.cmd(string.format("hi StatusLineFileName guifg=%s", schema.gray10))
    end
  end

  file_icon = get_file_icon(file_name, file_extension)

  return string.format(" %s%s%s%s", print_fix(file_icon), print_fix(file_path), print_fix(read_only_icon), print_fix(modified_icon))
end

local function get_lsp_count()
  if vim.tbl_isempty(vim.lsp.buf_get_clients(0)) then
    return ''
  end
  local diag = ''
  local error_diagnostic = vim.diagnostic.get(0, {severity= vim.diagnostic.severity.ERROR} )
  local error_count = table_length(error_diagnostic)
  if error_count > 0 then
    diag = diag .. string.format("%%#StatusLineLspError# %s ", error_count)
  end

  local warning_diagnostic = vim.diagnostic.get(0, {severity= vim.diagnostic.severity.WARN})
  local warning_count = table_length(warning_diagnostic)
  if warning_count > 0 then
    diag = diag .. string.format("%%#StatusLineLspWarn# %s ", warning_count)
  end

  local info_diagnostic = vim.diagnostic.get(0, {severity= vim.diagnostic.severity.INFO})
  local info_count = table_length(info_diagnostic)
  if info_count > 0 then
    diag = diag .. string.format("%%#StatusLineLspInfo# %s ", info_count)
  end

  local hint_diagnostic = vim.diagnostic.get(0, {severity= vim.diagnostic.severity.HINT})
  local hint_count = table_length(hint_diagnostic)
  if hint_count > 0 then
    diag = diag .. string.format("%%#StatusLineLspInfo#💡%s", hint_count)
  end
  return diag
end

local function get_ln_col()
  local pos = vim.api.nvim_win_get_cursor(0)
  return string.format("%3d :%2d ", pos[1], pos[2])
end

local function get_ln_percent()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local total_line = vim.api.nvim_buf_line_count(0)
  if current_line == 1 then return 'Top' end
  if current_line == total_line then return 'Bot' end
  return string.format("%2d", math.floor(current_line/total_line*100))
end

_G.set_active = function()
  local statusline = ''
  -- double %% to get % in string
  -- pattern is %#HightlightGroup#sometext
  statusline = statusline .. string.format("%%#StatusLineSepMode_0#%s", sep.open)
  statusline = statusline .. string.format("%%#StatusLineMode#%s ", get_current_mode())
  if not buffer_empty() then
    statusline = statusline .. string.format("%%#StatusLineFileName#%s", get_file_info())
  end
  statusline = statusline .. string.format("%%#StatusLineSep1_Bg#%s", sep.close)
  statusline = statusline .. "%#StatusLineBg#"
  statusline = statusline .. string.format(" %s", get_lsp_count())

  -- Right section
  statusline = statusline .. "%="
  statusline = statusline .. string.format("%%#StatusLineMode# %s  %s ", get_ln_col(), get_ln_percent())
  statusline = statusline .. string.format("%%#StatusLineSepMode_0#%s", sep.close)
  return statusline
end

_G.set_inactive = function()
  local statusline = ''
  statusline = statusline .. string.format("%%#StatusLineSepInactive#%s", sep.open)
  if not buffer_empty() then
    statusline = statusline .. string.format("%%#StatusLineInactiveFileName#%s", get_file_info())
  end
  statusline = statusline .. "%#StatusLineBg#"

  -- Right section
  statusline = statusline .. "%="
  statusline = statusline .. string.format("%%#StatusLineSepInactive#%s", sep.close)
  vim.wo.statusline = statusline
end

vim.cmd [[
  augroup Statusline
	au!
	au WinEnter,BufEnter * setlocal statusline=%!v:lua.set_active()
	au WinLeave,BufLeave * lua set_inactive()
	au WinEnter,BufEnter,FileType NvimTree,startify lua set_inactive()
  augroup END
]]
