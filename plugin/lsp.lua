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
  complete = lsp_complete_configured_servers,
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
    clients = get_clients_from_cmd_args(args)
  end

  for _, client in ipairs(clients) do
    -- Can remove diagnostic disabling when changing to client:stop(force) in nvim 0.11+
    --- @diagnostic disable: param-type-mismatch
    client.stop(force)
  end
end, {
  desc = "Manually stops the given language client(s)",
  nargs = "?",
  complete = lsp_get_active_clients,
})

-- map("n", "ga", vim.lsp.buf.code_action, { silent = true, buffer = bufnr, desc = "LSP code action" }) -- using tiny-code-action
-- map("n", "gR", vim.lsp.buf.rename, { silent = true, buffer = bufnr, desc = "LSP renamecode_action" })

-- map("n", "K", vim.lsp.buf.hover, { silent = true, buffer = bufnr, desc = "LSP hover" })
-- map("n", "gD", vim.lsp.buf.implementation, { silent = true, buffer = bufnr, desc = "LSP implementation" })
-- map("n", "<c-k>", vim.lsp.buf.signature_help, { silent = true, buffer = bufnr, desc = "LSP signature help" })
-- Goto previous/next diagnostic warning/error
map("v", "<leader>F", vim.lsp.buf.format, { silent = true, buffer = bufnr, desc = "LSP format in range" })
