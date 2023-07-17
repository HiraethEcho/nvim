local vim = vim
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    -- lazy=false,
    cmd="LspStart",
    keys={
      { "<leader>ll", "<cmd>LspStart<cr>", desc = "Start lsp" },
    },
    dependencies = {
      -- "folke/neodev.nvim",
     { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      -- "glepnir/lspsaga.nvim",
      -- 'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      -- local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- local lsp_defaults = require('lspconfig').util.default_config
      -- require'lspconfig'.texlab.setup{
      --   settings = {
      --     texlab = {
      --       forwardSearch = {
      --         executable = 'Sioyek',
      --         args = {
      --           '--reuse-window',
      --           '--execute-command', 'toggle_synctex', -- Open Sioyek in synctex mode.
      --           -- '--inverse-search',
      --           -- [[nvim-texlabconfig -file %%%1 -line %%%2 -server ]] .. vim.v.servername,
      --           '--forward-search-file', '%f',
      --           '--forward-search-line', '%l', '%p'
      --         },
      --       },
      --       chktex = {
      --         onOpenAndSave = false,
      --         onEdit = false,
      --       },
      --       bibtexFormatter = 'texlab',
      --       latexFormatter = 'texlab',
      --       formatterLineLength = 80,
      --     },
      --   },
      -- }
      -- require'lspconfig'.grammarly.setup{}
      require'lspconfig'.lua_ls.setup{
        settings={
          checkThirdParty = false,
        },
      }
      -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lsp_defaults = require('lspconfig').util.default_config
      local servers = {
        "html",
        "yamlls",
        -- "typst_lsp",
        "marksman",
        "clangd",
      }
      -- for _, lsp in pairs(servers) do
      --   require'lspconfig'[lsp].setup({
      --     on_attach = on_attach,
      --   })
      -- end
    end,
  },
  {
    "williamboman/mason.nvim",
    -- lazy=false,
    cmd = "Mason",
    build = ":MasonUpdate" ,-- :MasonUpdate updates registry contents
    config = function()
      require("mason").setup({
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    -- lazy=false,
    config=function()
      require("mason-lspconfig").setup()
    end,
  },
}

