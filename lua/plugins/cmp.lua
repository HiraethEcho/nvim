local nvimcmp={
  -- enabled = false,
  event="InsertEnter",
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "f3fora/cmp-spell",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "nvim-treesitter/nvim-treesitter",
    {
      "quangnguyen30192/cmp-nvim-ultisnips",
      config = function()
      require("cmp_nvim_ultisnips").setup{}
      end,
    },
    {
      "SirVer/ultisnips",
      config=function()
        vim.g.UltiSnipsSnippetDirectories={"ultisnips"}
      end,
    },
  },
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      snippet = {
        expand = function(args)
          vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<Tab>'] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end,
        ['<S-Tab>'] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
        -- ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly seected items.
      }),
      window = {
        documentation = cmp.config.window.bordered(),
        compete = cmp.config.window.bordered(),
        completion = {
          scrolloff = 5,
          -- border = 'rounded',
        },
      },
      experimental = {ghost_text = true,}, -- this feature conflict with copilot.vim's preview.
      sources = cmp.config.sources({
        { name = 'ultisnips' }, -- For ultisnips users.
        {
            name = 'spell',
            option = {
                keep_all_entries = false,
                enable_in_context = function()
                    return true
                end,
            },
        },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'treesitter' },
      }),
    })
    -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
    -- require('lspconfig')['clangd'].setup {
        -- capabilities = capabilities,
    -- }
  end,
}

return nvimcmp
