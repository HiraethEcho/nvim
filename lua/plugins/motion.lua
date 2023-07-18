return{
  {
    "SmiteshP/nvim-navbuddy",
    keys={
      { "<leader>ln", "<cmd>Navbuddy<cr>", desc = "Jump by symbol" },
    },
    cmd = "Navbuddy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = { lsp = { auto_attach = true } }
  },
  {
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
  },
  {
    'echasnovski/mini.files', version = false ,
    keys = {
      {'<leader>E', ":lua MiniFiles.open()<cr>",desc="mini file " },
    },
    opts = {
      mappings = {
        close       = 'q',
        go_in       = 'l',
        go_in_plus  = '',
        go_out      = 'h',
        go_out_plus = '',
        reset       = '<BS>',
        show_help   = '?',
        synchronize = '=',
        trim_left   = '<',
        trim_right  = '>',
      },
      options = {
        use_as_default_explorer = true,
      },
      windows = {
        preview = true,
        width_focus = 50,
        -- Width of non-focused window
        width_nofocus = 25,
        -- Width of preview window
        width_preview = 45,
      },
    },
  },
}
