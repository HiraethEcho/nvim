return{
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "f3fora/cmp-spell",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "nvim-treesitter/nvim-treesitter",
    {
      "SirVer/ultisnips",
      dependencies = {
        "quangnguyen30192/cmp-nvim-ultisnips",
        config = function()
        require("cmp_nvim_ultisnips").setup{}
        end,
      }
    },
  },
  config = function ()
    local cmp = require("cmp")
    cmp.setup{
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
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
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      sources = cmp.config.sources({
        { name = 'ultisnips' }, -- For ultisnips users.
        { name = "nvim_lsp" },
        { name = "buffer" },
        {
            name = 'spell',
            option = {
                keep_all_entries = false,
                enable_in_context = function()
                    return true
                end,
            },
        },
        { name = "path" },
        { name = "nvim_lua" },
      }),
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      }
    }
  end
}
