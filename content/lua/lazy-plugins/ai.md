---
title: ai
---

# ai plugin

```lua
return {
  { -- codecompanion
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "franco-ruggeri/codecompanion-spinner.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<localleader>cc", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle codecompanion chat" },
      { "<localleader>ca", "<cmd>CodeCompanionActions<cr>", desc = "codecompanion action" },
    },
    opts = {
      strategies = { chat = { adapter = "copilot" }, inline = { adapter = "copilot" }, agent = { adapter = "copilot" }, cmd = { adapter = "copilot" }, },
      extensions = {
        spinner = {},
      },
    },
  },
  { -- copilot
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    keys = { -- Example mapping to toggle outline
      { "<leader>cc", "<cmd>Copilot<CR>", desc = "Copilot" },
      { "<leader>ct", "<cmd>Copilot toggle<CR>", desc = "Copilot toggle" },
      { "<leader>cd", "<cmd>Copilot detach<CR>", desc = "Copilot detach" },
      { "<leader>ca", "<cmd>Copilot attach<CR>", desc = "Copilot attach" },
      { "<leader>cp", "<cmd>Copilot panel<CR>", desc = "Copilot panel" },
    },
    dependencies = { { "zbirenbaum/copilot-cmp", config = true } },
    opts = {
      filetypes = { ["*"] = true },
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_prev = "K",
          jump_next = "J",
        },
        layout = {
          position = "bottom", -- | top | left | right
          ratio = 0.4,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = false,
        hide_during_completion = false,
        debounce = 75,
      },
    },
  },
  { -- avante
    "yetone/avante.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "folke/snacks.nvim", -- for input provider snacks
      "zbirenbaum/copilot.lua", -- for providers='copilot'
    },
    build = "make",
    version = false, -- Never set this value to "*"! Never!
    keys = {
      { "<localleader>aa", "<cmd>AvanteChat<cr>", desc = "Avante chat" },
      { "<localleader>at", "<cmd>AvanteToggle<cr>", desc = "Toggle Avante chat" },
      { "<localleader>ar", "<cmd>AvanteRefresh<cr>", desc = "AvanteRefresh" },
      { "<localleader>af", "<cmd>AvanteFocus<cr>", desc = "Change focus" },
      { "<localleader>a?", "<cmd>AvanteModels<cr>", desc = "select model" },
      { "<localleader>an", "<cmd>AvanteChatNew<cr>", desc = "New Ask" },
      { "<localleader>ae", "<cmd>AvanteEdit<cr>", desc = "Edit selected block" },
      { "<localleader>aS", "<cmd>AvanteStop<cr>", desc = "Stop current AI request" },
      { "<localleader>ah", "<cmd>AvanteHistory<cr>", desc = "select between chat histories" },
      { "<localleader>aC", "<cmd>AvanteClear<cr>", desc = "Clear Avante chat" },
    },
    opts = {
      provider = "copilot",
      providers = {
        ollama = {
          endpoint = "http://localhost:11434",
          model = "qwen3:8b",
        },
      },
      behaviour = {
        auto_set_keymaps = false,
        support_paste_from_clipboard = true,
        enable_token_counting = true,
      },
      mappings = {
        files = {
          add_current = "<localleader>ac", -- Add current buffer to selected files
          add_all_buffers = "<localleader>aB", -- Add all buffer files to selected files
        },
        select_model = "<localleader>a?", -- Select model command
        select_history = "<localleader>ah", -- Select history command
        confirm = {
          focus_window = "<C-w>f",
          code = "c",
          resp = "r",
          input = "i",
        },
        ask = "<localleader>aa",
        new_ask = "<localleader>an",
        edit = "<localleader>ae",
        refresh = "<localleader>ar",
        focus = "<localleader>af",
        stop = "<localleader>aS",
        toggle = {
          default = "<localleader>at",
          debug = "<localleader>ad",
          hint = "<localleader>ah",
          suggestion = "<localleader>as",
          repomap = "<localleader>aR",
        },
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {},
        jump = {
          next = "]]",
          prev = "[[",
        },
        cancel = {
          normal = { "<C-c>", "<Esc>", "q" },
          insert = { "<C-c>" },
        },
        sidebar = {
          apply_all = "A",
          apply_cursor = "a",
          retry_user_request = "r",
          edit_user_request = "e",
          switch_windows = "<Tab>",
          reverse_switch_windows = "<S-Tab>",
          remove_file = "d",
          add_file = "@",
          close = { "<Esc>", "q" },
          close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
        },
      },
      input = { provider = "snacks" },
      hints = { enabled = false },
    },
  },
}
```
