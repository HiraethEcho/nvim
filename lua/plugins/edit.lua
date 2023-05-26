local tools={
  {
   "tpope/vim-commentary",
    event = "BufReadPost",
  },
  {
    "echasnovski/mini.pairs",
    -- event = "VeryLazy",
    -- lazy=false,
    enabled=false,
    config = function()
      require("mini.pairs").setup()
    end,
  },
  {
    "wellle/targets.vim",
    event = "BufReadPost",
    enabled=false,
    -- lazy = false,
  },
  {
    "machakann/vim-sandwich",
    -- lazy=false,
    event = "BufReadPost",
  },
  {
    "godlygeek/tabular",
    keys={
      {"<leader>t",":Tabularize /",mode="v"},
    },
  },
  {
    "Neur1n/neuims",
    cmd="IMSToggle",
  },
}

local undo ={
  "jiaoshijie/undotree",
  event = "BufReadPost",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys={
    {'<leader>u', ":lua require('undotree').toggle()<cr>",  mode="n"},
  },
  config=function()
    local undotree = require('undotree')
    undotree.setup({
      float_diff = true,  -- using float window previews diff, set this `true` will disable layout option
      layout = "left_bottom", -- "left_bottom", "left_left_bottom"
      ignore_filetype = { 'Undotree', 'UndotreeDiff', 'qf', 'TelescopePrompt', 'spectre_panel', 'tsplayground' },
      window = {
        winblend = 30,
      },
      keymaps = {
        ['j'] = "move_next",
        ['k'] = "move_prev",
        ['J'] = "move_change_next",
        ['K'] = "move_change_prev",
        ['<cr>'] = "action_enter",
        ['p'] = "enter_diffbuf",
        ['q'] = "quit",
      },
    })
  end,
}

local hop ={
  "phaazon/hop.nvim",
  -- event = "BufRead",
  keys={
    -- {'<leader>j', "<cmd>lua require'hop'.hint_vertical()<cr>",  mode={"n","v"}},
    -- {'F', "<cmd>lua require'hop'.hint_char1()<cr>", mode={"n","v"}},
    -- {'f', ":HopChar1CurrentLine<cr>", {noremap= true,silent=true}},
    {'<leader><leader>', ":HopWord<cr>", {noremap= true,silent=true}},
  },
  config = function()
    require('hop').setup()
    keys = 'asdfghjkl'
  end,
}


local spec={tools, hop}

return spec
