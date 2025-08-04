-- search text

local ns = vim.api.nvim_create_namespace("search_count_virtualtext")

local function clear_virtual_text()
  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
end

local function update_virtual_text()
  clear_virtual_text()
  if vim.o.hlsearch == false then
    return
  end
  local search_pat = vim.fn.getreg("/")
  if search_pat == "" then
    return
  end

  local ok, searchcount = pcall(vim.fn.searchcount, { recompute = 1, maxcount = 9999 })
  if not ok or not searchcount.total or searchcount.total == 0 then
    return
  end

  local virt_text = string.format(" [%d/%d]", searchcount.current, searchcount.total)
  local line = vim.fn.line(".") - 1
  vim.api.nvim_buf_set_extmark(0, ns, line, -1, {
    virt_text = { { virt_text, "SearchCountVirtualText" } },
    virt_text_pos = "eol",
    hl_mode = "combine",
  })
end

vim.api.nvim_create_autocmd({ "CursorMoved", "CmdlineLeave" }, {
  pattern = { "*" },
  callback = function()
    if vim.v.hlsearch == 0 then
      clear_virtual_text()
    else
      vim.schedule(update_virtual_text)
    end
  end,
})

-- diagnostic
-- vim.diagnostic.config({ virtual_text = true })
-- vim.diagnostic.config({ virtual_lines = true })
vim.diagnostic.config({ virtual_text = true, virtual_lines = { current_line = true } })
