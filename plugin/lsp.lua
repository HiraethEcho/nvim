local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

vim.api.nvim_create_user_command("Lspstart", function(info)
  local server_name = #info.args > 0 and info.args or nil
  if server_name then
    vim.lsp.enable(server_name)
  end
end, {
  desc = "Start a language server",
  nargs = "?",
  complete = function(arg_lead)
    local configured = vim.tbl_keys(vim.lsp.get_config())
    local running = vim.tbl_map(function(c)
      return c.name
    end, vim.lsp.get_clients())
    return vim.iter(configured):filter(function(name)
      return not vim.tbl_contains(running, name)
        and name:find(arg_lead) ~= nil
    end):totable()
  end,
})

vim.api.nvim_create_user_command("Lspstop", function(info)
  local args = vim.trim(info.args)
  local clients = {}
  if #args == 0 then
    clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
  else
    for _, name in ipairs(vim.split(args, "%s+")) do
      vim.list_extend(clients, vim.lsp.get_clients({ name = name }))
    end
  end
  for _, client in ipairs(clients) do
    client:stop()
  end
end, {
  desc = "Stop language client(s)",
  nargs = "?",
  complete = function(arg_lead)
    return vim.iter(vim.lsp.get_clients()):map(function(c)
      return c.name
    end):filter(function(name)
      return name:find(arg_lead) ~= nil
    end):totable()
  end,
})

vim.api.nvim_create_user_command("Lsprestart", function(info)
  local buf_clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
  local names = {}
  if #info.args > 0 then
    names = vim.split(info.args, "%s+")
  else
    names = vim.tbl_map(function(c) return c.name end, buf_clients)
  end
  for _, name in ipairs(names) do
    for _, client in ipairs(vim.lsp.get_clients({ name = name })) do
      client:stop()
    end
    vim.lsp.enable(name)
  end
end, {
  desc = "Restart language client(s)",
  nargs = "?",
  complete = function(arg_lead)
    return vim.iter(vim.lsp.get_clients()):map(function(c)
      return c.name
    end):filter(function(name)
      return name:find(arg_lead) ~= nil
    end):totable()
  end,
})

map("n", "<leader>ll", "<cmd>Lspstart<cr>", { desc = "Start LSP" })
map("n", "<leader>ls", "<cmd>Lspstop<cr>", { desc = "Stop LSP" })
map("v", "<leader>F", vim.lsp.buf.format, { desc = "LSP format range" })

vim.lsp.enable("copilot") -- from nvim-lspconfig with LspCopilotSignIn. required by single fang2hou/blink-copilot
-- vim.lsp.enable("copilot_ls") -- by copilotlsp-nvim/copilot-lsp
