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

local todo={
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  -- event = "BufRead",
  keys={
    {']t', function() require("todo-comments").jump_next() end, desc="Next todo comments",   mode={"n"}},
    {'[t', function() require("todo-comments").jump_prev() end, desc="Previous todo comments",   mode={"n"}},
    {']f', function() require("todo-comments").jump_next({keywords={"FIX","WARNING"}}) end, desc="Next error/warning comments",   mode={"n"}},
    {'[f', function() require("todo-comments").jump_prev({keywords={"FIX","WARNING"}}) end, desc="Previous error/warning comments",   mode={"n"}},
  },
  cmd={"TodoLocList","TodoTelescope","TodoQuickFix"},
  config = function ()
    require("todo-comments").setup({
      signs = true, -- show icons in the signs column
      sign_priority = 8, -- sign priority
      -- keywords recognized as todo comments
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        -- HACK = { icon = " ", color = "warning" },
        QUES = { icon = " ", color = "warning", alt = { "WARNING", "XX" } },
        -- WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        -- PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        -- TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      gui_style = {
        fg = "NONE", -- The gui style to use for the fg highlight group.
        bg = "BOLD", -- The gui style to use for the bg highlight group.
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults
      -- highlighting of the line containing the todo comment
      -- * before: highlights before the keyword (typically comment characters)
      -- * keyword: highlights of the keyword
      -- * after: highlights after the keyword (todo text)
      highlight = {
        multiline = true, -- enable multine todo comments
        multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
        before = "", -- "fg" or "bg" or empty
        keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg", -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true, -- uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = {}, -- list of file types to exclude highlighting
      },
      -- list of named colors where we try to extract the guifg from the
      -- list of highlight groups or use the hex color if hl not found as a fallback
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" }
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
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
  end,
}


local spec={tools, hop,todo}

return spec
