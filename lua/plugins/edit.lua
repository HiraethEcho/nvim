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
  {
    "windwp/nvim-autopairs",
    event="InsertEnter",
    config = function() require("nvim-autopairs").setup {} end
  },
}

local todo={
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys={
    {']t', function() require("todo-comments").jump_next() end, desc="Next todo comments",   mode={"n"}},
    {'[t', function() require("todo-comments").jump_prev() end, desc="Previous todo comments",   mode={"n"}},
    {']f', function() require("todo-comments").jump_next({keywords={"FIX","WARN"}}) end, desc="Next error/warning comments",   mode={"n"}},
    {'[f', function() require("todo-comments").jump_prev({keywords={"FIX","WARN"}}) end, desc="Previous error/warning comments",   mode={"n"}},
    {']q', function() require("todo-comments").jump_next({keywords={"QUES"}}) end, desc="Next question",   mode={"n"}},
    {'[q', function() require("todo-comments").jump_prev({keywords={"QUES"}}) end, desc="Previous question",   mode={"n"}},
    {']n', function() require("todo-comments").jump_next({keywords={"NOTE"}}) end, desc="Next question",   mode={"n"}},
    {'[n', function() require("todo-comments").jump_prev({keywords={"NOTE"}}) end, desc="Previous question",   mode={"n"}},
  },
  cmd={"TodoLocList","TodoTelescope","TodoQuickFix"},
  config = function ()
    require("todo-comments").setup({
      signs = true, -- show icons in the signs column
      sign_priority = 8, -- sign priority
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "todo" },
        QUES = { icon = " ", color = "ques" },
        WARN = { icon = " ", color = "warning", alt = {"XXX" } },
        NOTE = { icon = " ", color = "note"},
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
    {'<leader><leader>', ":HopWord<cr>",desc="Hop Word", {noremap= true,silent=true}},
  },
  config = function()
    require('hop').setup()
  end,
}

local spec={
  tools,
  hop,
  todo,
}

return spec
