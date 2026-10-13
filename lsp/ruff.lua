---@brief
---
--- https://github.com/astral-sh/ruff
---
--- A Language Server Protocol implementation for Ruff, an extremely fast Python linter and code formatter, written in Rust. It can be installed via `pip`.
---
--- ```sh
--- pip install ruff
--- ```
---
--- **Available in Ruff `v0.4.5` in beta and stabilized in Ruff `v0.5.3`.**
---
--- This is the new built-in language server written in Rust. It supports the same feature set as `ruff-lsp`, but with superior performance and no installation required. Note that the `ruff-lsp` server will continue to be maintained until further notice.
---
--- Server settings can be provided via:
---
--- ```lua
--- vim.lsp.config('ruff', {
---   init_options = {
---     settings = {
---       -- Server settings should go here
---     }
---   }
--- })
--- ```
---
--- Refer to the [documentation](https://docs.astral.sh/ruff/editors/) for more details.

---@type vim.lsp.Config
return {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
  settings = {},
  offset_encoding = 'utf-16',
  init_options = {
    settings = {
      -- 服务器设置放这里，例如：
      -- configurationPreference = 'filesystemFirst',
      -- fixAll = true,
      -- organizeImports = true,
    },
  },
  on_attach = function(client, bufnr)
    -- 关键：关闭 hover，让 Pyright 负责悬浮文档
    client.server_capabilities.hoverProvider = false
    -- 可选：如果不想让 Ruff 提供补全，也可以关闭
    -- client.server_capabilities.completionProvider = nil
  end,
}
