vim.diagnostic.config({
  virtual_text = { spacing = 4, prefix = "●" },
  virtual_lines = false,
})

local function toggle_virtual_diagnostic_mode()
  if vim.diagnostic.config().virtual_lines then
    vim.diagnostic.config({ virtual_lines = false, virtual_text = { spacing = 4, prefix = "●" } })
  else
    vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
  end
end

vim.api.nvim_create_user_command("DiagToggleMode", toggle_virtual_diagnostic_mode,
  { desc = "Toggle diagnostic mode: lines ↔ text" })
vim.keymap.set("n", "<leader>uD", toggle_virtual_diagnostic_mode,
  { desc = "Toggle diag mode: lines ↔ text" })
