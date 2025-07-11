-- from nvim 11.0 newsletter

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

---Utility for keymap creation.
---@param lhs string
---@param rhs string|function
---@param opts string|table
---@param mode? string|string[]
local function keymap(lhs, rhs, opts, mode)
  opts = type(opts) == "string" and { desc = opts } or vim.tbl_extend("error", opts --[[@as table]], { buffer = bufnr })
  mode = mode or "n"
  vim.keymap.set(mode, lhs, rhs, opts)
end

---For replacing certain <C-x>... keymaps.
---@param keys string
local function feedkeys(keys)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", true)
end

---Is the completion menu open?
local function pumvisible()
  return tonumber(vim.fn.pumvisible()) ~= 0
end

-- Enable completion and configure keybindings.
if client.supports_method(methods.textDocument_completion) then
  vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })

  -- Use enter to accept completions.

  -- Use <C-n> to navigate to the next completion or:
  -- - Trigger LSP completion.
  -- - If there's no one, fallback to vanilla omnifunc.

  -- Use <Tab> to accept a Copilot suggestion, navigate between snippet tabstops,
  -- or select the next completion.
  -- Do something similar with <S-Tab>.
  keymap("<Tab>", function()
    local copilot = require("copilot.suggestion")

    if copilot.is_visible() then
      copilot.accept()
    elseif pumvisible() then
      feedkeys("<C-n>")
    elseif vim.snippet.active({ direction = 1 }) then
      vim.snippet.jump(1)
    else
      feedkeys("<Tab>")
    end
  end, {}, { "i", "s" })
  keymap("<S-Tab>", function()
    if pumvisible() then
      feedkeys("<C-p>")
    elseif vim.snippet.active({ direction = -1 }) then
      vim.snippet.jump(-1)
    else
      feedkeys("<S-Tab>")
    end
  end, {}, { "i", "s" })

  -- Inside a snippet, use backspace to remove the placeholder.
  keymap("<BS>", "<C-o>s", {}, "s")
end

-- Autoselect the first item but don't insert it.
-- Allows quick use, just write something and enter to select the first one.

-- Make completion menu appear whenever you type something.
-- Example from: https://neovim.io/doc/user/lsp.html#lsp-attach
-- Optional: trigger autocompletion on EVERY keypress. May be slow!
local chars = {}
for i = 32, 126 do
  table.insert(chars, string.char(i))
end
client.server_capabilities.completionProvider.triggerCharacters = chars
vim.lsp.completion.enable(true, client.id, args.buf, {
  autotrigger = true,
})

vim.opt.completeopt = { "menu", "popup", "menuone", "noinsert", "noselect", "fuzzy", "preview" }

keymap("<Tab>", function()
  if pumvisible() then
    feedkeys("<C-n>")
  else
    feedkeys("<Tab>")
  end
end, {}, { "i", "s" })

keymap("<S-Tab>", function()
  if pumvisible() then
    feedkeys("<C-p>")
  else
    feedkeys("<S-Tab>")
  end
end, {}, { "i", "s" })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if vim.snippet.active({ direction = 1 }) then
    return "<Cmd>lua vim.snippet.jump(1)<CR>"
  else
    return "<C-j>"
  end
end, { descr = "next placeholder", expr = true, silent = true })

vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if vim.snippet.active({ direction = 1 }) then
    return "<Cmd>lua vim.snippet.jump(-1)<CR>"
  else
    return "<C-k>"
  end
end, { descr = "previous placeholder", expr = true, silent = true })

-- Inside a snippet, use backspace to remove the placeholder.
vim.keymap.set("<BS>", "<C-o>s", {}, "s")

keymap("<cr>", function()
  return pumvisible() and "<C-y>" or "<cr>"
end, { expr = true }, "i")

-- Use slash to dismiss the completion menu.
keymap("/", function()
  return pumvisible() and "<C-e>" or "/"
end, { expr = true }, "i")

-- Buffer completions.
keymap("<C-u>", "<C-x><C-n>", { desc = "Buffer completions" }, "i")

keymap("<C-n>", function()
  if pumvisible() then
    feedkeys("<C-n>")
  else
    if next(vim.lsp.get_clients({ bufnr = 0 })) then
      vim.lsp.completion.trigger()
    else
      if vim.bo.omnifunc == "" then
        feedkeys("<C-x><C-n>")
      else
        feedkeys("<C-x><C-o>")
      end
    end
  end
end, "Trigger/select next completion", "i")
