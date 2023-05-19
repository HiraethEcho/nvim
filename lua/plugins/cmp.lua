-- if true then return {} end
local cmp={
  enabled = false,
  "hrsh7th/nvim-cmp",
  dependencies = {
    -- "onsails/lspkind-nvim",
    "hrsh7th/cmp-nvim-lsp",
    "f3fora/cmp-spell",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    -- "SirVer/ultisnips",
    "rafamadriz/friendly-snippets",
  },
  event = "InsertEnter",

  config = function()
    local cmp = require("cmp")

    cmp.setup({
      snippet = {
        expand = function(args)
          vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      window = {
        documentation = cmp.config.window.bordered(),
        complete = cmp.config.window.bordered(),
        completion = {
          scrolloff = 5,
          -- border = 'rounded',
        },
      },

      experimental = {
        ghost_text = true, -- this feature conflict with copilot.vim's preview.
      },

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        -- { name = "luasnip" },
        -- { name = "orgmode" },
        { name = "buffer" },
        { name = "path" },
        { name = "spell" },
      }),

    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    -- [wsl neovim cmp-cmdline 不能 :! command](https://github.com/hrsh7th/cmp-cmdline/issues/24#issuecomment-1094896592)
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
    })
  end,
}
return cmp
