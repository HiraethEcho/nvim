local function show_message(msg, hl)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {msg})

  local width = math.max(20, #msg + 2)
  local opts = {
    relative = "buf",
    width = width,
    height = 1,
    row = vim.o.lines - 3,
    col = vim.o.columns - 1,
    style = "minimal",
    border = "rounded",
  }

  local win = vim.api.nvim_open_win(buf, false, opts)
  if hl then
    vim.api.nvim_win_set_option(win, "winhl", "Normal:" .. hl)
  end

  vim.defer_fn(function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, 2000)
end

--[[ vim.api.nvim_create_autocmd("MsgShow", {
  callback = function(args)
    local msg = args.data and args.data.msg or ""
    if msg ~= "" then
      show_message(msg, "Normal")
      vim.cmd("echo ''") -- Clear default message
    end
  end,
}) ]]

--[[ vim.notify = function(msg, level, opts)
  local hl = "Normal"
  if level == vim.log.levels.ERROR then
    hl = "ErrorMsg"
  elseif level == vim.log.levels.WARN then
    hl = "WarningMsg"
  elseif level == vim.log.levels.INFO then
    hl = "Normal"
  end
  show_message(msg, hl)
end ]]
