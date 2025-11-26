---
title: nav
---
```lua
return {
  { -- "phaazon/hop.nvim",
    "phaazon/hop.nvim",
    -- event = "BufRead",
    -- enabled = false,
    keys = {
      -- {'<leader>j', "<cmd>lua require'hop'.hint_vertical()<cr>",  mode={"n","v"}},
      -- {'F', "<cmd>lua require'hop'.hint_char1()<cr>", mode={"n","v"}},
      -- { "f",               ":HopChar1<cr>",    desc = "Hop Char",    { noremap = true, silent = true } },
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
    -- enabled = false,
    -- event = "LspAttach",
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

  { -- "dnlhc/glance.nvim",
    "dnlhc/glance.nvim",
    -- lazy = false,
    enabled = false,
    event = "LspAttach",
    keys = {
      { "gd", "<cmd>Glance definitions<cr>", desc = "Glance definitions" },
      { "gr", "<cmd>Glance references<cr>", desc = "Glance references" },
      { "gy", "<cmd>Glance type_definitions<cr>", desc = "Glance type_definitions" },
      { "gm", "<cmd>Glance implementations<cr>", desc = "Glance implementations" },
    },
    config = function()
      local actions = require("glance").actions
      require("glance").setup({

        -- By default glance will open preview "embedded" within your active window
        -- when `detached` is enabled, glance will render above all existing windows
        -- and won't be restiricted by the width of your active window
        detached = true,

        -- Or use a function to enable `detached` only when the active window is too small
        -- (default behavior)
        -- detached = function(winid)
        --   return vim.api.nvim_win_get_width(winid) < 100
        -- end,

        list = {
          position = "left", -- Position of the list window 'left'|'right'
          width = 0.2, -- 33% width relative to the active window, min 0.1, max 0.5
        },
        mappings = {
          list = {
            ["j"] = actions.next, -- Bring the cursor to the next item in the list
            ["k"] = actions.previous, -- Bring the cursor to the previous item in the list
            ["<Down>"] = actions.next,
            ["<Up>"] = actions.previous,
            ["<Tab>"] = actions.next_location, -- Bring the cursor to the next location skipping groups in the list
            ["<S-Tab>"] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
            ["<C-u>"] = actions.preview_scroll_win(5),
            ["<C-d>"] = actions.preview_scroll_win(-5),
            ["v"] = actions.jump_vsplit,
            ["s"] = actions.jump_split,
            ["t"] = actions.jump_tab,
            ["<CR>"] = actions.jump,
            ["l"] = actions.open_fold,
            ["h"] = actions.close_fold,
            ["<space>"] = actions.enter_win("preview"), -- Focus preview window
            ["q"] = actions.close,
            ["Q"] = false,
            ["<Esc>"] = actions.close,
            ["<C-q>"] = actions.quickfix,
          },
          preview = {
            ["<Tab>"] = actions.next_location,
            ["<S-Tab>"] = actions.previous_location,
            ["q"] = actions.enter_win("list"), -- Focus list window
          },
        },
      })
    end,
  },
  { -- "bassamsdata/namu.nvim",
    "bassamsdata/namu.nvim",
    keys = {
      { "<leader>O", "<cmd>Namu symbols<cr>", desc = "Jump by symbol" },
    },
    enabled = false,
    config = function()
      require("namu").setup({
        -- Enable the modules you want
        namu_symbols = {
          enable = true,
          options = {}, -- here you can configure namu
        },
        -- Optional: Enable other modules if needed
        ui_select = { enable = true }, -- vim.ui.select() wrapper
        colorscheme = { enable = false },
      })
    end,
  },
  { -- "rainzm/flash-zh.nvim",
    "rainzm/flash-zh.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = "folke/flash.nvim",
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash-zh").jump({
            chinese_only = false,
          })
        end,
        desc = "Flash between Chinese",
      },
    },
  },
}
```
