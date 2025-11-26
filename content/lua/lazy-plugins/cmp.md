---
title: cmp
---

# auto complete

using blink.cmp for complete frame, and luasnip for snippets.

```lua
return {
  { -- "saghen/blink.cmp",
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    version = "*",
    dependencies = {
      { "saghen/blink.compat", version = "*", opts = {} },
      "nvim-treesitter/nvim-treesitter",
      "zbirenbaum/copilot.lua",
      "fang2hou/blink-copilot",
      "L3MON4D3/LuaSnip",
    },
    opts = {
      snippets = { preset = "luasnip" },
      keymap = {
        preset = "none",
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-e>"] = { "cancel", "fallback" },
        ["<C-k>"] = { "snippet_backward", "fallback" },
        ["<C-n>"] = { function() if require("luasnip").choice_active() then require("luasnip").change_choice(1) return true end end, "fallback", },
        ["<C-p>"] = { function() if require("luasnip").choice_active() then require("luasnip").change_choice(-1) return true end end, "fallback", },
        ["<C-f>"] = { function() if require("luasnip").choice_active() then require("luasnip").change_choice(1) return true end end, "fallback", },
        ["<C-b>"] = { function() if require("luasnip").choice_active() then require("luasnip").change_choice(-1) return true end end, "fallback", },
        ]]
      },
      signature = { enabled = true },
      completion = {
        trigger = { show_on_backspace = true, show_on_insert = false },
        keyword = { range = "full" },
        documentation = { auto_show = true, auto_show_delay_ms = 50 },
        menu = { draw = { treesitter = {}, columns = { { "label", gap = 1 }, { "kind_icon" }, { "source_name" } } } },
        list = { selection = { preselect = false, auto_insert = true } },
        ghost_text = { enabled = true },
      },
      sources = {
        default = { "snippets", "lsp", "path", "buffer", "copilot" },
        providers = {
          snippets = { score_offset = 200 },
          buffer = { score_offset = 150, opts = { get_bufnrs = vim.api.nvim_list_bufs } },
          copilot = { score_offset = 100, name = "copilot", module = "blink-copilot", async = true },
        },
      },
      cmdline = {
        sources = function()
          local type = vim.fn.getcmdtype()
          if type == "/" or type == "?" then
            return { "buffer" }
          end
          if type == ":" or type == "@" then
            return { "cmdline" }
          end
          return {}
        end,
        keymap = {
          preset = "none",
          ["<Down>"] = { "select_next", "fallback" },
          ["<Up>"] = { "select_prev", "fallback" },
          ["<Tab>"] = { "select_next", "fallback" },
          ["<S-Tab>"] = { "select_prev", "fallback" },
          -- ["<CR>"] = { "accept" },
        },
        completion = {
          list = { selection = { preselect = false } },
          menu = { auto_show = true },
        },
      },
    },
  },
  { -- "L3MON4D3/LuaSnip",
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    cmd = { "LuaSnipEdit" },
    config = function()
      local ls = require("luasnip")
      local types = require("luasnip.util.types")
      vim.api.nvim_create_user_command("LuaSnipEdit", function()
        require("luasnip.loaders").edit_snippet_files()
      end, { desc = "Edit Snippets" })

      ls.setup({
        enable_autosnippets = true,
        store_selection_keys = "<TAB>",
        ext_opts = {
          [types.choiceNode] = {
            active = { virt_text = { { "", "RainbowBlue" } } },
          },
          [types.insertNode] = {
            active = { virt_text = { { "", "RainbowOrange" } } },
          },
        },
      })
      require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/LuaSnip/" })
      require("luasnip.loaders.from_snipmate").load({ paths = vim.fn.stdpath("config") .. "/snipmate/" })
      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if ls.jumpable() then
          ls.jump(1)
        end
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if ls.jumpable() then
          ls.jump(-1)
        end
      end, { silent = true })
      vim.keymap.set("i", "<C-n>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end)
      vim.keymap.set("i", "<C-p>", function()
        if ls.choice_active() then
          ls.change_choice(-1)
        end
      end)
    end,
  },
}
```

luasnip load [/LuaSnip/](/LuaSnip) and [/snipmate/](snipmate) for snippets.

- [/LuaSnip/all.lua](/LuaSnip/all) applies for all type of files.
- [/luaSnip/lua.lua](/LuaSnip/lua) applies for `.lua` files. Or,
- Files in [/luaSnip/tex/](/LuaSnip/tex) folder apply for `tex` files.

Similar for `.snippets` files in [/snipmate/](snipmate).
