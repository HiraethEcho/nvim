---
title: utils
---

# utils

some useful tools

```lua
return {
  { "folke/lazy.nvim", version = "*" },
  { -- "MagicDuck/grug-far.nvim",
    "MagicDuck/grug-far.nvim",
    keys = {
      {
        "<C-f>",
        function()
          require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
        end,
        desc = "search and replace",
      },
    },
    opts = {},
  },
  { "lambdalisue/suda.vim", cmd = { "SudaRead", "SudaWrite" } },
  { -- "folke/which-key.nvim",
    "folke/which-key.nvim",
    keys = {
      {
        "?",
        function()
          require("which-key").show()
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
      {
        "<c-w><space>",
        function()
          require("which-key").show({ keys = "<c-w>", loop = true })
        end,
        desc = "Window Hydra Mode (which-key)",
      },
    },
    event = "BufRead",
    opts = {
      preset = "helix", -- classic, helix, modern
      -- layout = { align = "center" },
      defaults = {},
    },
    config = function()
      local wk = require("which-key")
      wk.add({
        -- { "<leader>i", group = "list" },
        { "<leader>D", group = "Diff" },
        { "<leader>u", group = "toggle" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>l", group = "lsp" },
        { "<leader>m", group = "markdown" },
        { "<leader>h", group = "hunk" },
        { "<leader>c", group = "copilot" },
        { "<leader>s", group = "search" },
        { "<leader>S", group = "Session" },
        { "<localleader>a", group = "Avante" },
        { "<localleader>c", group = "CodeCompanion" },
        { "<localleader>C", group = "copilot Chat" },
        { "<localleader>o", group = "OpenCode" },
        -- { "<leader>x", group = "troube" },
        -- { "m", group = "bookmark", },
      })
    end,
  },
  { -- "markgandolfo/lightswitch.nvim",
    "markgandolfo/lightswitch.nvim",
    cmd = { "LightSwitchShow" },
    keys = { { "<leader>uu", ":LightSwitchShow<CR>" } },
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      toggles = {
        {
          name = "readonly",
          enable_cmd = "setl ma! ma?",
          disable_cmd = "setl ma! ma?",
        },
        {
          name = "color",
          enable_cmd = "ColorizerAttachToBuffer",
          disable_cmd = "ColorizerAttachToBuffer",
          state = false, -- Initially enabled
        },
        {
          name = "Copilot",
          enable_cmd = "Copilot enable",
          disable_cmd = "Copilot disable",
          state = true, -- Initially enabled
        },
        {
          name = "LSP",
          enable_cmd = ":Lspstart<CR>",
          disable_cmd = ":Lspstop<CR>",
          state = true, -- Initially disabled
        },
        {
          name = "Diagnostics",
          enable_cmd = "lua vim.diagnostic.enable()",
          disable_cmd = "lua vim.diagnostic.disable()",
          state = true,
        },
      },
    },
  },
}
```
