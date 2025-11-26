return {
  { -- "saghen/blink.cmp",
    "saghen/blink.cmp",
    -- enabled = false,
    event = { "InsertEnter", "CmdlineEnter" },
    version = "*",
    dependencies = {
      { "saghen/blink.compat", version = "*", opts = {} },
      "nvim-treesitter/nvim-treesitter",
      "zbirenbaum/copilot.lua",
      "fang2hou/blink-copilot",
      -- "olimorris/codecompanion.nvim",
      -- "milanglacier/minuet-ai.nvim",
      -- "Kaiser-Yang/blink-cmp-avante",
      -- { "quangnguyen30192/cmp-nvim-ultisnips", config = true },
      -- "SirVer/ultisnips",
      "L3MON4D3/LuaSnip",
    },
    opts = {
      snippets = { preset = "luasnip" },
      keymap = {
        preset = "none",
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-e>"] = { "cancel", "fallback" },
        --[[ ["<C-j>"] = { "snippet_forward", "fallback" },
        ["<C-k>"] = { "snippet_backward", "fallback" },
        ["<C-n>"] = { function() if require("luasnip").choice_active() then require("luasnip").change_choice(1) return true end end, "fallback", },
        ["<C-p>"] = { function() if require("luasnip").choice_active() then require("luasnip").change_choice(-1) return true end end, "fallback", }, 
        ["<C-f>"] = { function() if require("luasnip").choice_active() then require("luasnip").change_choice(1) return true end end, "fallback", },
        ["<C-b>"] = { function() if require("luasnip").choice_active() then require("luasnip").change_choice(-1) return true end end, "fallback", }, 
        ]]
      },
      signature = { enabled = true },
      completion = {
        trigger = { show_on_backspace = true, show_on_insert = false },
        keyword = { range = "full" },
        documentation = { auto_show = true, auto_show_delay_ms = 50 },
        menu = { draw = { treesitter = {}, columns = { { "label", gap = 1 }, { "kind_icon" }, { "source_name" } } } },
        list = { selection = { preselect = false, auto_insert = true } },
        ghost_text = { enabled = true },
      },
      sources = {
        -- default = { "ultisnips", "lsp", "path", "buffer", "copilot" },
        -- default = { "snippets", "lsp", "path", "buffer", "copilot", "lazydev" },
        -- default = { "ultisnips", "lsp", "path", "buffer" },
        -- default = { "ultisnips", "snippets", "lsp", "path", "buffer", "copilot" },
        default = { "snippets", "lsp", "path", "buffer", "copilot" },
        -- default = { "snippets", "lsp", "path", "buffer" },
        providers = {
          snippets = { score_offset = 200 },
          -- ultisnips = { score_offset = 200, name = "ultisnips", module = "blink.compat.source" },
          buffer = { score_offset = 150, opts = { get_bufnrs = vim.api.nvim_list_bufs } },
          copilot = { score_offset = 100, name = "copilot", module = "blink-copilot", async = true },
          -- minuet = { score_offset = 200, name = "minuet", module = "minuet.blink" },
          -- avante = { name = "avante", module = "blink-cmp-avante", opts = {} },
          -- lazydev = { score_offset = 100, name = "LazyDev", module = "lazydev.integrations.blink" },
        },
      },
      cmdline = {
        -- enabled = false,
        sources = function()
          local type = vim.fn.getcmdtype()
          if type == "/" or type == "?" then
            return { "buffer" }
          end
          if type == ":" or type == "@" then
            return { "cmdline" }
          end
          return {}
        end,
        keymap = {
          preset = "none",
          ["<Down>"] = { "select_next", "fallback" },
          ["<Up>"] = { "select_prev", "fallback" },
          ["<Tab>"] = { "select_next", "fallback" },
          ["<S-Tab>"] = { "select_prev", "fallback" },
          -- ["<CR>"] = { "accept" },
        },
        completion = {
          list = { selection = { preselect = false } },
          menu = { auto_show = true },
        },
      },
    },
    -- opts_extend = { "sources.default" },
  },
  { -- "hrsh7th/nvim-cmp",
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    enabled = false,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      {
        "SirVer/ultisnips",
      },
      { "quangnguyen30192/cmp-nvim-ultisnips", config = true },
      "hrsh7th/cmp-buffer",
      -- { "micangl/cmp-vimtex", },
      "zbirenbaum/copilot.lua",
      "hrsh7th/cmp-path",
      "onsails/lspkind-nvim",
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
      local lspkind = require("lspkind")
      local cmp = require("cmp")
      local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
      cmp.setup({
        completion = { completeopt = "menu,popup,menuone,noselect" }, -- see :help 'completeopt'
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          end,
        },
        mapping = {
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<c-j>"] = cmp.mapping(function(fallback)
            cmp_ultisnips_mappings.jump_forwards(fallback)
          end, { "i", "s" }),
          ["<c-k>"] = cmp.mapping(function(fallback)
            cmp_ultisnips_mappings.jump_backwards(fallback)
          end, { "i", "s" }),
          ["<Tab>"] = cmp.mapping.select_next_item(fallback),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(fallback),
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        },
        -- stylua: ignore
        sources = cmp.config.sources({
          { name = "ultisnips" },
          -- { name = "vimtex" },
          -- { name = "nvim_lua" },
          {
            name = "nvim_lsp",
            -- option = {
            --   markdown_oxide = {
            --     keyword_pattern = [[\(\k\| \|\/\|#\)\+]]
            --   }
            -- }
          },
          -- { name = 'nvim_lsp' },
          { name = "copilot", max_item_count = 3 },
          { name = "buffer", option = { get_bufnrs = function() return vim.api.nvim_list_bufs() end }, max_item_count = 3 },
          { name = "path" },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol", -- show only symbol annotations
            maxwidth = {
              -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
              -- can also be a function to dynamically calculate max width such as
              -- menu = function() return math.floor(0.45 * vim.o.columns) end,
              menu = 50, -- leading text (labelDetails)
              abbr = 50, -- actual suggestion item
            },
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default
            before = function(entry, vim_item)
              vim_item.menu = entry.source.name
              return vim_item
            end,
          }),
        },
      })
    end,
  },
  { -- "L3MON4D3/LuaSnip",
    "L3MON4D3/LuaSnip",
    -- enabled = false,
    version = "v2.*",
    cmd = { "LuaSnipEdit" },
    config = function()
      local ls = require("luasnip")
      local types = require("luasnip.util.types")
      vim.api.nvim_create_user_command("LuaSnipEdit", function()
        require("luasnip.loaders").edit_snippet_files()
      end, { desc = "Edit Snippets" })

      ls.setup({
        enable_autosnippets = true,
        store_selection_keys = "<TAB>",
        -- say tex code block in markdown, but not work
        -- ft_func = require("luasnip.extras.filetype_functions").from_cursor(),
        ext_opts = {
          [types.choiceNode] = {
            active = { virt_text = { { "", "RainbowBlue" } } },
          },
          [types.insertNode] = {
            active = { virt_text = { { "", "RainbowOrange" } } },
          },
        },
      })
      -- require("luasnip.loaders.from_lua").load()
      -- require("luasnip.loaders.from_snipmate").load()
      require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/LuaSnip/" })
      require("luasnip.loaders.from_snipmate").load({ paths = vim.fn.stdpath("config") .. "/snipmate/" })
      --[[ local auto_expand = require("luasnip").expand_auto
      require("luasnip").expand_auto = function(...)
        vim.o.undolevels = vim.o.undolevels
        auto_expand(...)
      end ]]
      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if ls.jumpable() then
          ls.jump(1)
        end
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if ls.jumpable() then
          ls.jump(-1)
        end
      end, { silent = true })
      vim.keymap.set("i", "<C-n>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end)
      vim.keymap.set("i", "<C-p>", function()
        if ls.choice_active() then
          ls.change_choice(-1)
        end
      end)
      --[[ vim.keymap.set({ "i", "s" }, "<C-e>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true }) ]]
      --[[ vim.keymap.set({ "i", "s" }, "<C-e>", function()
        require("luasnip.extras.select_choice")()
      end, { silent = true }) ]]
    end,
  },
  { -- "folke/lazydev.nvim",
    "folke/lazydev.nvim",
    enabled = false,
    ft = "lua", -- only load on lua files
    opts = {
      library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } },
      integrations = { lspconfig = true, cmp = true },
      enabled = true,
    },
  },
}
