require("texpresso").attach()

local autocmd = vim.api.nvim_create_autocmd
autocmd({ "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("texpressoGroup", {}),
  callback = function()
    vim.cmd("TeXpressoSync")
  end,
})

vim.api.nvim_create_user_command("TeXpressoSync", function()
  local buf = 0
  local path = vim.api.nvim_buf_get_name(buf)
  M.send("open", path, buffer_get_lines(buf, 0, -1))
end, {})
