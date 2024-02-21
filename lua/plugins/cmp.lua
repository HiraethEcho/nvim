local vim = vim
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    -- "nvim-treesitter/nvim-treesitter",
    {
      "SirVer/ultisnips",
      dependencies = {
        "quangnguyen30192/cmp-nvim-ultisnips",
        config = function()
          require("cmp_nvim_ultisnips").setup({})
        end,
      },
    },
    "onsails/lspkind-nvim",
  },
  config = function()
    local cmp = require("cmp")
    local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
    cmp.setup({
      completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      },
      snippet = {
        expand = function(args)
          vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end,
        ["<S-Tab>"] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),

      sources = cmp.config.sources({
        { name = "ultisnips" }, -- For ultisnips users.
        {
          name = "buffer",
          option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
          },
        },
        { name = "path" },
      }),
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },
      formatting = {
        format = require("lspkind").cmp_format({
          with_text = true, -- do not show text alongside icons
          maxwidth = 50,    -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          before = function(entry, vim_item)
            -- Source 显示提示来源
            vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
            return vim_item
          end,
        }),
      },
    })
  end,
}
