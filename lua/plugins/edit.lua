local tools={
  {
   "tpope/vim-commentary",
    event = "BufReadPost",
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
