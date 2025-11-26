---
title: nav
---

# nav

nav and jump in neovim

```lua
return {
  { -- "phaazon/hop.nvim",
    "phaazon/hop.nvim",
    keys = {
      { "W", ":HopWord<cr>", desc = "Hop Word", { noremap = true, silent = true } },
      { "<leader><space>", ":HopAnywhere<cr>", desc = "HopAnywhere", { noremap = true, silent = true } },
    },
    config = function()
      require("hop").setup()
    end,
  },
  { -- "folke/flash.nvim",
    "folke/flash.nvim",
    -- event = "VeryLazy",
    opts = {
      -- labels = "abcdefghijklmnopqrstuvwxyz",
      -- labels = "asdfghjklqwertyuiopzxcvbnm",
      labels = "asdfjklzxcvuioewr",
      search = {
        -- Each mode will take ignorecase and smartcase into account.
        -- * exact: exact match
        -- * search: regular search
        -- * fuzzy: fuzzy search
        -- * fun(str): custom function that returns a pattern
        --   For example, to only match at the beginning of a word:
        --   mode = function(str)
        --     return "\\<" .. str
        --   end,
        mode = "search", -- default exact
      },
      label = {
        -- Enable this to use rainbow colors to highlight labels
        -- Can be useful for visualizing Treesitter ranges.
        rainbow = {
          enabled = true, --default false
        },
      },
      -- You can override the default options for a specific mode.
      -- Use it with `require("flash").jump({mode = "forward"})`
      modes = {
        -- options used when flash is activated through
        -- `f`, `F`, `t`, `T`, `;` and `,` motions
        char = {
          enabled = true, -- default true
          -- by default all keymaps are enabled, but you can disable some of them,
          -- by removing them from the list.
          -- If you rather use another key, you can map them
          -- to something else, e.g., { [";"] = "L", [","] = H }
          keys = { "f", "F", ";", "," },
          -- keys = { "f", "F", "t", "T", ";", "," }, -- default
        },
        treesitter = {
          labels = "asdfjklzxcviouqwernm", -- default asdfghjklzxcvbnmqwertyuiop
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      -- { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      -- { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  { -- "SmiteshP/nvim-navbuddy",
    "SmiteshP/nvim-navbuddy",
    keys = {
      { "<leader>O", "<cmd>Navbuddy<cr>", desc = "Jump by symbol" },
    },
    cmd = "Navbuddy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      -- "neovim/nvim-lspconfig",
    },
    -- opts = { lsp = { auto_attach = true } },
    config = function()
      local navbuddy = require("nvim-navbuddy")
      local actions = require("nvim-navbuddy.actions")
      navbuddy.setup({
        window = {
          size = "80%", -- Or table format example: { height = "40%", width = "100%"}
          position = "50%", -- Or table format example: { row = "100%", col = "0%"}
          scrolloff = nil, -- scrolloff value within navbuddy window
          sections = {
            left = {
              size = "20%",
              border = nil, -- You can set border style for each section individually as well.
            },
            mid = {
              size = "40%",
              border = nil,
            },
            right = {
              -- No size option for right most section. It fills to
              -- remaining area.
              border = nil,
              preview = "leaf", -- Right section can show previews too.
              -- Options: "leaf", "always" or "never"
            },
          },
        },
        use_default_mappings = false, -- If set to false, only mappings set by user are set. Else default mappings are used for keys that are not set by user
        mappings = {
          ["<esc>"] = actions.close(), -- Close and cursor to original location
          ["q"] = actions.close(),

          ["j"] = actions.next_sibling(), -- down
          ["k"] = actions.previous_sibling(), -- up

          ["h"] = actions.parent(), -- Move to left panel
          ["l"] = actions.children(), -- Move to right panel
          -- ["0"] = actions.root(),           -- Move to first panel

          ["v"] = actions.visual_name(), -- Visual selection of name
          ["V"] = actions.visual_scope(), -- Visual selection of scope

          ["y"] = actions.yank_name(), -- Yank the name to system clipboard "+
          ["Y"] = actions.yank_scope(), -- Yank the scope to system clipboard "+

          ["i"] = actions.insert_name(), -- Insert at start of name
          ["I"] = actions.insert_scope(), -- Insert at start of scope

          ["a"] = actions.append_name(), -- Insert at end of name
          ["A"] = actions.append_scope(), -- Insert at end of scope

          ["r"] = actions.rename(), -- Rename currently focused symbol

          ["x"] = actions.delete(), -- Delete scope

          ["f"] = actions.fold_create(), -- Create fold of current scope
          ["F"] = actions.fold_delete(), -- Delete fold of current scope

          ["c"] = actions.comment(), -- Comment out current scope

          ["<enter>"] = actions.select(), -- Goto selected symbol
          ["o"] = actions.select(),

          ["J"] = actions.move_down(), -- Move focused node down
          ["K"] = actions.move_up(), -- Move focused node up

          ["p"] = actions.toggle_preview(), -- Show preview of current node

          ["<C-v>"] = actions.vsplit(), -- Open selected node in a vertical split
          ["<C-s>"] = actions.hsplit(), -- Open selected node in a horizontal split

          ["t"] = actions.telescope({ -- Fuzzy finder at current level.
            layout_config = { -- All options that can be
              height = 0.60, -- passed to telescope.nvim's
              width = 0.60, -- default can be passed here.
              prompt_position = "top",
              preview_width = 0.50,
            },
            layout_strategy = "horizontal",
          }),
          ["g?"] = actions.help(), -- Open mappings help window
        },
        lsp = { auto_attach = true }, -- If set to true, you don't need to manually use attach function },
      })
    end,
  },
  { -- "hedyhli/outline.nvim",
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    keys = { -- Example mapping to toggle outline
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
      -- Your setup opts here
      outline_window = {
        position = "right",
        width = 20,
      },
      preview_window = {
        open_hover_on_preview = true,
        live = true,
      },
      keymaps = {
        goto_location = "<space>",
        peek_location = "o",
        goto_and_close = "<Cr>",
        restore_location = "<C-g>",
        hover_symbol = "K",
        toggle_preview = "p",
        fold_all = "zM",
        unfold_all = "zR",
      },
    },
  },
}
```
