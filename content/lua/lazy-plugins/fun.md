---
title: fun
---
```lua
return {
  { -- "saxon1964/neovim-tips",
    enabled = false,
    "saxon1964/neovim-tips",
    cmd = {
      "NeovimTips",
      "NeovimTipsEdit",
      "NeovimTipsAdd",
      "NeovimTipsRandom",
    },
    version = "*", -- Only update on tagged releases
    dependencies = {
      "MunifTanjim/nui.nvim",
      "MeanderingProgrammer/render-markdown.nvim",
    },
    opts = {
      user_file = vim.fn.stdpath("config") .. "/user_tips.md",
      -- 0 = off, 1 = once per day, 2 = every startup (default: 1)
      daily_tip = 2,
    },
    init = function()
      -- The plugin does not provide default key mappings, only commands
      local map = vim.keymap.set
      map("n", "<leader>nto", ":NeovimTips<CR>", { desc = "Neovim tips", noremap = true, silent = true })
      map("n", "<leader>nte", ":NeovimTipsEdit<CR>", { desc = "Edit your Neovim tips", noremap = true, silent = true })
      map("n", "<leader>nta", ":NeovimTipsAdd<CR>", { desc = "Add your Neovim tip", noremap = true, silent = true })
      map("n", "<leader>ntr", ":NeovimTipsRandom<CR>", { desc = "Show random tip", noremap = true, silent = true })
    end,
  },
  { -- "m4xshen/hardtime.nvim",
    "m4xshen/hardtime.nvim",
    keys = {
      { "<leader>uH", "<cmd>HardTime toggle<cr>", mode = "n", desc = "Toggle hardtime" },
    },
    config = function()
      require("hardtime").setup({
        -- Set time in milliseconds for timeout
        timeout = 500,
        -- Set time in milliseconds to delay before hardtime starts
        ttc = 1000,
        -- Set time in milliseconds to delay before hardtime ends
        delay = 500,
        -- Set time in milliseconds for which key is to be blocked
        block = 10,
      })
    end,
  },
  { -- "tris203/precognition.nvim",
    "tris203/precognition.nvim",
    keys = {
      { "<leader>uP", "<cmd>Precognition Toggle<cr>", mode = "n", desc = "Toggle precognition" },
    },
    opts = {},
  },
  { -- "FluxxField/bionic-reading.nvim",
    enabled = false,
    "FluxxField/bionic-reading.nvim",
    keys = {
      { "<leader>ub", "<cmd>BRToggle<cr>", mode = { "n", "v" }, desc = "Toggle Bionic Read" },
    },
    opts = {
      -- determines if the file types below will be
      -- automatically highlighted on buffer open
      auto_highlight = true,
      -- the file types you want to highlight with
      -- the node types you would like to target
      -- using treesitter
      file_types = {
        ["text"] = "any", -- highlight any node
        ["help"] = "any", -- highlight any node
        ["markdown"] = "any",
        -- EX: only highlights comments in lua files
        ["lua"] = {
          "comment",
        },
      },
      -- Flag used to control if the user is prompted
      -- if BRToggle is called on a file type that is not
      -- explicitly defined above
      prompt_user = true,
      -- Enable or disable the use of treesitter
      treesitter = true,
    },
  },
  { -- "seandewar/actually-doom.nvim", -- what the fuck? why would I play DOOM in nvim?
    "seandewar/actually-doom.nvim", -- what the fuck? why would I play DOOM in nvim?
    enabled = false,
    cmd = "Doom",
    config = true,
  },
  { -- "eandrju/cellular-automaton.nvim",
    "eandrju/cellular-automaton.nvim",
    keys = {
      { "<leader>uR", "<cmd>CellularAutomaton make_it_rain<cr>", desc = "Rain" },
      { "<leader>uG", "<cmd>CellularAutomaton game_of_life<cr>", desc = "Rain" },
    },
    config = function()
      -- vim.api.nvim_create_user_command("Rain", require("cellular-automaton").start_animation("make_it_rain"), {})
    end,
  },
}
```
