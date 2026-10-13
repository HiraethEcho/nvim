---@brief
---
--- https://github.com/microsoft/pyright
---
--- `pyright`, a static type checker and language server for python

local function set_python_path(path)
  local clients = vim.lsp.get_clients({
    bufnr = vim.api.nvim_get_current_buf(),
    name = "pyright",
  })
  for _, client in ipairs(clients) do
    if client.settings then
      client.settings.python = vim.tbl_deep_extend("force", client.settings.python, { pythonPath = path })
    else
      client.config.settings = vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
    end
    client.notify("workspace/didChangeConfiguration", { settings = nil })
  end
end

return {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    ".git",
  },
  settings = {
    pyright = {
      -- 关键：让 Ruff 负责导入排序
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
        -- 关键：关闭与 Ruff 重叠的 lint 规则，避免重复诊断
        diagnosticSeverityOverrides = {
          reportUnusedImport = "none",
          reportUnusedVariable = "none",
          reportUnusedExpression = "none",
          reportMissingImports = "warning", -- 保留，Ruff 不检查这个
          -- 如需更彻底，可再加：
          -- reportUnusedFunction = 'none',
          -- reportUnusedClass = 'none',
        },
      },
    },
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightOrganizeImports", function()
      client:exec_cmd({
        command = "pyright.organizeimports",
        arguments = { vim.uri_from_bufnr(bufnr) },
      })
    end, {
      desc = "Organize Imports",
    })
    vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightSetPythonPath", set_python_path, {
      desc = "Reconfigure pyright with the provided python path",
      nargs = 1,
      complete = "file",
    })
  end,
}
