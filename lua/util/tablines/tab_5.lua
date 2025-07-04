-- https://github.com/v-l-a-d-i-m-i-r/.dotfiles
local nvim_dev_icons = require('nvim-web-devicons')

local hl_group_names = {
  fill = 'TLFill',
  tab_normal = 'TLTabNormal',
  tab_active = 'TLTabActive',
  tab_normal_modified = 'TLTabNormalModified',
  tab_active_modified = 'TLTabActiveModified',
  sep_normal = 'TLSepNormal',
  sep_active = 'TLSepActive',
}

local chars = {
  separator = '|',
}

local skipped_buf_names = {
  'NvimTree_1',
  'Trouble',
  'DiffviewFilePanel',
  'null',
  'api.txt',
  '0.fugitiveblame',
  'diffview://',
}

local function add_hl_group(hl_group_name, text)
  return '%#' .. hl_group_name .. '#' .. text
end

local function get_hl(name)
  local hl_group = vim.api.nvim_get_hl(0, { name = name })

  if hl_group.link ~= nil then
    return get_hl(hl_group.link)
  end

  return hl_group
end

local function setup()
  vim.o.showtabline = 2
  vim.o.tabline = '%!v:lua.nvim_tabline()'

  vim.api.nvim_set_hl(0, hl_group_names.fill, { link = 'TabLineFill' })
  vim.api.nvim_set_hl(0, hl_group_names.tab_normal, { link = 'TabLine' })
  vim.api.nvim_set_hl(0, hl_group_names.tab_active, { link = 'TabLineSel' })

  local hl_normal = get_hl(hl_group_names.tab_normal)
  local hl_active = get_hl(hl_group_names.tab_active)
  local hl_warn = get_hl('WarningMsg')

  vim.api.nvim_set_hl(0, hl_group_names.tab_normal_modified, { fg = hl_warn.fg, bg = hl_normal.bg })
  vim.api.nvim_set_hl(0, hl_group_names.tab_active_modified, { fg = hl_warn.fg, bg = hl_active.bg })
  vim.api.nvim_set_hl(0, hl_group_names.sep_normal, { fg = hl_active.bg, bg = hl_normal.bg })
  vim.api.nvim_set_hl(0, hl_group_names.sep_active, { fg = hl_normal.bg, bg = hl_active.bg })
end

local function Line()
  local line = {}

  return {
    add = function(value)
      table.insert(line, value)
    end,
    build = function()
      return table.concat(line)
    end,
  }
end

local function Tab(params)
  local isActive = params.isActive or false
  local isModified = params.isModified or false
  local nameWithExtention = params.nameWithExtention or ''
  local extention = params.extention or ''
  local width = params.width or 0

  local function drawTab(buf_name_with_ext, buf_width)
    local buf_name_with_ext_len = string.len(buf_name_with_ext)
    local icon_with_paddings_len = 5

    if buf_name_with_ext_len > (buf_width - icon_with_paddings_len) then
      return string.sub(buf_name_with_ext, 1, (buf_width - icon_with_paddings_len - 1)) .. '~'
    end

    if buf_name_with_ext_len < (buf_width - icon_with_paddings_len) then
      local buf_name_with_ext_normalized = buf_name_with_ext

      while string.len(buf_name_with_ext_normalized) < (buf_width - icon_with_paddings_len - 1) do
        buf_name_with_ext_normalized = buf_name_with_ext_normalized .. ' '
      end

      return buf_name_with_ext_normalized
    end

    return buf_name_with_ext
  end

  return {
    build = function()
      local buf_icon, iconHighlightGroup = nvim_dev_icons.get_icon(nameWithExtention, extention, { default = true })
      local iconHighlightGroupName = isActive and iconHighlightGroup or hl_group_names.tab_normal

      local tab_hl_group_name = hl_group_names.tab_normal
      if isActive and isModified then
        tab_hl_group_name = hl_group_names.tab_active_modified
      end
      if not isActive and isModified then
        tab_hl_group_name = hl_group_names.tab_normal_modified
      end
      if isActive and not isModified then
        tab_hl_group_name = hl_group_names.tab_active
      end

      local buf_name_with_ext_normalized = drawTab(nameWithExtention, width)

      return add_hl_group(tab_hl_group_name, ' ')
        .. add_hl_group(iconHighlightGroupName, buf_icon)
        .. add_hl_group(tab_hl_group_name, ' ')
        .. add_hl_group(tab_hl_group_name, buf_name_with_ext_normalized)
        .. add_hl_group(tab_hl_group_name, ' ')
    end,
  }
end

local function Separator(params)
  local isActive = params.isActive or false

  return {
    build = function()
      local separatorHighlightGroupName = isActive and hl_group_names.sep_active or hl_group_names.sep_normal

      return add_hl_group(separatorHighlightGroupName, chars.separator)
    end,
  }
end

local function Tabline()
  local function filterBufferNumbers(numbers, skippedBufferNames)
    local result = {}

    for _, number in ipairs(numbers) do
      if not vim.api.nvim_buf_is_loaded(number) then
        goto continue
      end

      local buf_path = vim.api.nvim_buf_get_name(number)

      if buf_path == '' then
        goto continue
      end

      for _, skippedBufferName in ipairs(skippedBufferNames) do
        if buf_path:find(skippedBufferName) ~= nil then
          goto continue
        end
      end

      table.insert(result, number)

      ::continue::
    end

    return result
  end

  local function checkBufferActive(bufferNumber)
    local activeBufferNumbers = vim.fn.tabpagebuflist()

    for _, activeBufferNumber in ipairs(activeBufferNumbers) do
      if bufferNumber == activeBufferNumber then
        return true
      end
    end

    return false
  end

  local function getStartSeparator(isActive, isPrevBufferActive)
    if isActive ~= isPrevBufferActive then
      return ' '
    end

    return Separator({ isActive = isActive }).build()
  end

  local function getBufferNameWithExtention(bufferNumber)
    return vim.fn.expand('#' .. bufferNumber .. ':t')
  end

  local function getBufferExtention(bufferNumber)
    return vim.fn.expand('#' .. bufferNumber .. ':e')
  end

  return {
    build = function()
      local nvim_width = vim.go.columns
      local line = Line()
      local buf_nrs = vim.api.nvim_list_bufs()
      local filterredBufferNumbers = filterBufferNumbers(buf_nrs, skipped_buf_names)

      local bufs_qty = #filterredBufferNumbers
      local buf_width = math.min(nvim_width / bufs_qty, 30)

      local isPrevBufferActive = false
      for i, bufferNumber in ipairs(filterredBufferNumbers) do
        local isFirst = i == 1
        local isLast = i == table.getn(filterredBufferNumbers)
        local isModified = vim.api.nvim_buf_get_option(bufferNumber, 'modified')
        local isActive = checkBufferActive(bufferNumber)

        if not isFirst then
          local startSeparator = getStartSeparator(isActive, isPrevBufferActive)

          line.add(startSeparator)
        end

        local tab = Tab({
          isActive = isActive,
          isModified = isModified,
          nameWithExtention = getBufferNameWithExtention(bufferNumber),
          extention = getBufferExtention(bufferNumber),
          width = buf_width,
        }).build()

        line.add(tab)

        if isLast and not isActive then
          local endSeparator = Separator({ isActive = false }).build()

          line.add(endSeparator)
        end

        isPrevBufferActive = isActive
      end

      line.add(add_hl_group(hl_group_names.fill, ''))

      return line.build()
    end,
  }
end

local tabline = Tabline()

function _G.nvim_tabline()
  return tabline.build()
end

return {
  setup = setup,
}
