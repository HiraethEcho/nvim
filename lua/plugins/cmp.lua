-- if true then return {} end
local nvimcmp={
  -- enabled = false,
  event="InsertEnter",
  "hrsh7th/nvim-cmp",
  dependencies = {
    "onsails/lspkind-nvim",
    "hrsh7th/cmp-nvim-lsp",
    "f3fora/cmp-spell",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    -- "hrsh7th/cmp-cmdline",
    "nvim-treesitter/nvim-treesitter",
    {
      "quangnguyen30192/cmp-nvim-ultisnips",
    config = function()
      -- optional call to setup (see customization section)
      require("cmp_nvim_ultisnips").setup{}
    end,
    -- If you want to enable filetype detection based on treesitter:
    -- requires = { "nvim-treesitter/nvim-treesitter" },
    },
    {
      "SirVer/ultisnips",
      config=function()
        vim.g.UltiSnipsSnippetDirectories={"ultisnips"}
      end,
    },
    -- "rafamadriz/friendly-snippets",
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
        { name = 'nvim_lsp' },
        { name = 'spell' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'treesitter' },
      }),
    })

    local lspkind = require('lspkind')
    lspkind.init({
      symbol_map = {
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "",
      },
    })
    cmp.setup {
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol', -- show only symbol annotations
          maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

          -- before = function(entry, vim_item)
          --   vim_item.menu = ({
          --     nvim_lsp = "ﲳ",
          --     nvim_lua = "",
          --     treesitter = "",
          --     path = "ﱮ",
          --     buffer = "﬘",
          --     zsh = "",
          --     luasnip = "",
          --     spell = "",
          --   })[entry.source.name]
          --     return vim_item
          -- end,
        })
      }
    }

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    -- cmp.setup.cmdline({ "/", "?" }, {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = {
        --     { name = "buffer" },
        --   },
        -- })
        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        -- cmp.setup.cmdline(":", {
          --   mapping = cmp.mapping.preset.cmdline(),
          --   sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
          -- })
          --
          local capabilities = require('cmp_nvim_lsp').default_capabilities()
          -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
          -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
            -- capabilities = capabilities
          -- }
  end,
}

return nvimcmp
