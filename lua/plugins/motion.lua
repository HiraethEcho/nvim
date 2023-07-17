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
  }
}
