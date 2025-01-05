return {
  {
    'saghen/blink.cmp',
    enabled = false,
    event = "InsertEnter",
    version = "*",
    dependencies = {
      -- 'rafamadriz/friendly-snippets'
      "SirVer/ultisnips",
    },
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = {
        preset = 'none',
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-j>'] = { 'snippet_forward', 'fallback' },
        ['<C-k>'] = { 'snippet_backward', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
        ['<C-e>'] = { 'hide', 'fallback' },
        -- show with a list of providers
        -- ['<C-space>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },

        -- control whether the next command will be run when using a function
        -- optionally, separate cmdline keymaps
        -- cmdline = {}
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        cmdline = {},
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
    opts_extend = { "sources.default" }
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    -- enabled = false,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      {
        "SirVer/ultisnips",
      },
      { "quangnguyen30192/cmp-nvim-ultisnips", config = true, },
      "hrsh7th/cmp-buffer",
      -- { "micangl/cmp-vimtex", },
      -- "zbirenbaum/copilot.lua",
      "hrsh7th/cmp-path",
      -- "onsails/lspkind-nvim",
      -- "neovim/nvim-lspconfig",
      -- "hrsh7th/cmp-nvim-lua",
      -- "nvim-treesitter/nvim-treesitter",
      -- "yehuohan/cmp-im",
      -- "yehuohan/cmp-im-zh",
      -- "liubianshi/cmp-lsp-rimels",
      {
        "folke/lazydev.nvim",
        enabled = false,
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local lspkind = require('lspkind')
      local cmp = require("cmp")
      local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
      cmp.setup({
        completion = { completeopt = "menu,popup,menuone,noselect", }, -- see :help 'completeopt'
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          end,
        },
        mapping = {
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<c-j>"] = cmp.mapping(
            function(fallback)
              cmp_ultisnips_mappings.jump_forwards(fallback)
            end,
            { "i", "s", }
          ),
          ["<c-k>"] = cmp.mapping(
            function(fallback)
              cmp_ultisnips_mappings.jump_backwards(fallback)
            end,
            { "i", "s", }
          ),
          ["<Tab>"] = cmp.mapping.select_next_item(fallback),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(fallback),
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        },
        sources = cmp.config.sources({
          { name = "ultisnips" }, -- For ultisnips users.
          -- { name = "vimtex" },
          -- { name = "nvim_lua" },
          {
            name = 'nvim_lsp',
            option = {
              markdown_oxide = {
                keyword_pattern = [[\(\k\| \|\/\|#\)\+]]
              }
            }
          },
          -- { name = 'nvim_lsp' },
          { name = "copilot",  max_item_count = 3, },
          { name = "buffer",   option = { get_bufnrs = function() return vim.api.nvim_list_bufs() end, }, max_item_count = 3, },
          { name = "path" },
          -- { name = "lazydev",  group_index = 0, },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = {
              -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
              -- can also be a function to dynamically calculate max width such as
              -- menu = function() return math.floor(0.45 * vim.o.columns) end,
              menu = 50,              -- leading text (labelDetails)
              abbr = 50,              -- actual suggestion item
            },
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default
            before = function(entry, vim_item)
              vim_item.menu = entry.source.name
              return vim_item
            end
          })
        },
      })
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    cmd = "Copilot",
    keys = { -- Example mapping to toggle outline
      { "<leader>cc", "<cmd>Copilot<CR>",        desc = "Copilot" },
      { "<leader>ct", "<cmd>Copilot toggle<CR>", desc = "Copilot toggle" },
      { "<leader>cd", "<cmd>Copilot detach<CR>", desc = "Copilot detach" },
      { "<leader>ca", "<cmd>Copilot attach<CR>", desc = "Copilot attach" },
      { "<leader>cp", "<cmd>Copilot panel<CR>",  desc = "Copilot panel" },
    },
    dependencies = {
      "zbirenbaum/copilot-cmp",
      config = function()
        require("copilot_cmp").setup()
      end
    },
    config = function()
      require('copilot').setup({
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            jump_prev = "K",
            jump_next = "J",
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = false,
          hide_during_completion = true,
          debounce = 75,
        },
        filetypes = {
          lua = true,
          markdown = true,
          latex = true,
          -- ["."] = false,
        },
      })
    end,
  },
}
