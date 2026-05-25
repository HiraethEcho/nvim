--[[ local capabilities = require("blink.cmp").get_lsp_capabilities()
      -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
      vim.lsp.config('*', {
        root_markers = { '.obsidian', '.git' },
        capabilities = capabilities,
        offset_encoding = "utf-8",
      }) ]]
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

vim.api.nvim_create_user_command("Lspstart", function(info)
  local server_name = string.len(info.args) > 0 and info.args or nil
  if server_name then
    vim.lsp.enable(server_name)
  end
end, {
  desc = "Manually launches a language server",
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
  ---@type string
  local args = info.args
  local force = false
  args = args:gsub("%+%+force", function()
    force = true
    return ""
  end)

  local clients = {}

  -- default to stopping all servers on current buffer
  if #args == 0 then
    clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
  else
    clients = {}
    for _, name in ipairs(vim.split(args, "%s+")) do
      vim.list_extend(clients, vim.lsp.get_clients({ name = name }))
    end
  end

  for _, client in ipairs(clients) do
    -- Can remove diagnostic disabling when changing to client:stop(force) in nvim 0.11+
    --- @diagnostic disable: param-type-mismatch
    client.stop(force)
  end
end, {
  desc = "Manually stops the given language client(s)",
  nargs = "?",
  complete = function(arg_lead)
    return vim.iter(vim.lsp.get_clients()):map(function(c)
      return c.name
    end):filter(function(name)
      return name:find(arg_lead) ~= nil
    end):totable()
  end,
})

-- map("n", "ga", vim.lsp.buf.code_action, { silent = true, buffer = bufnr, desc = "LSP code action" }) -- using tiny-code-action
-- map("n", "gR", vim.lsp.buf.rename, { silent = true, buffer = bufnr, desc = "LSP renamecode_action" })

-- map("n", "K", vim.lsp.buf.hover, { silent = true, buffer = bufnr, desc = "LSP hover" })
-- map("n", "gD", vim.lsp.buf.implementation, { silent = true, buffer = bufnr, desc = "LSP implementation" })
-- map("n", "<c-k>", vim.lsp.buf.signature_help, { silent = true, buffer = bufnr, desc = "LSP signature help" })
-- Goto previous/next diagnostic warning/error
map("v", "<leader>F", vim.lsp.buf.format, { silent = true, buffer = bufnr, desc = "LSP format in range" })
