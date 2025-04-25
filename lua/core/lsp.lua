vim.api.nvim_create_user_command('Lspstart', function(info)
  local server_name = string.len(info.args) > 0 and info.args or nil
  if server_name then
    vim.lsp.enable(server_name)
  end
end, {
  desc = 'Manually launches a language server',
  nargs = '?',
  complete = lsp_complete_configured_servers,
})

vim.api.nvim_create_user_command('Lspstop', function(info)
  ---@type string
  local args = info.args
  local force = false
  args = args:gsub('%+%+force', function()
    force = true
    return ''
  end)

  local clients = {}

  -- default to stopping all servers on current buffer
  if #args == 0 then
    clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
  else
    clients = get_clients_from_cmd_args(args)
  end

  for _, client in ipairs(clients) do
    -- Can remove diagnostic disabling when changing to client:stop(force) in nvim 0.11+
    --- @diagnostic disable: param-type-mismatch
    client.stop(force)
  end
end, {
  desc = 'Manually stops the given language client(s)',
  nargs = '?',
  complete = lsp_get_active_clients,
})
