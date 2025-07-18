return {
  { -- avante
    "yetone/avante.nvim",
    enabled = false,
    build = "make",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      keys = function(_, keys)
        local opts =
          require("lazy.core.plugin").values(require("lazy.core.config").spec.plugins["avante.nvim"], "opts", false)
        local mappings = {
          {
            opts.mappings.ask,
            function()
              require("avante.api").ask()
            end,
            desc = "avante: ask",
            mode = { "n", "v" },
          },
          {
            opts.mappings.refresh,
            function()
              require("avante.api").refresh()
            end,
            desc = "avante: refresh",
            mode = "v",
          },
          {
            opts.mappings.edit,
            function()
              require("avante.api").edit()
            end,
            desc = "avante: edit",
            mode = { "n", "v" },
          },
        }
        mappings = vim.tbl_filter(function(m)
          return m[1] and #m[1] > 0
        end, mappings)
        return vim.list_extend(mappings, keys)
      end,
      -- provider = "copilot",
      provider = "ollama",
      providers = {
        ollama = {
          endpoint = "http://localhost:11434",
          model = "qwen2.5-coder:7b",
        },
        deepseek = {
          __inherited_from = "openai",
          api_key_name = "sk-e229a6f4cadf426ea7e3972b09d03f02",
          endpoint = "https://api.deepseek.com",
          model = "deepseek-coder",
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "folke/snacks.nvim", -- for input provider snacks
      "zbirenbaum/copilot.lua", -- for providers='copilot'
    },
  },
  { -- codecompanion
    "olimorris/codecompanion.nvim",
    -- enabled = false,
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    config = function()
      require("codecompanion").setup({
        adapters = {
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              env = {
                url = "http://localhost:11434",
              },
              parameters = {
                sync = true,
              },
              schema = { model = { default = "qwen2.5-coder:7b" } },
            })
          end,
          deepseek = function()
            return require("codecompanion.adapters").extend("deepseek", {
              env = {
                api_key = "sk-e229a6f4cadf426ea7e3972b09d03f02",
              },
            })
          end,
        },
        strategies = {
          chat = { adapter = "ollama" },
          inline = { adapter = "copilot" },
          agent = { adapter = "deepseek" },
          cmd = { adapter = "deepseek" },
        },
      })
      vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
      vim.keymap.set(
        { "n", "v" },
        "<LocalLeader>c",
        "<cmd>CodeCompanionChat Toggle<cr>",
        { noremap = true, silent = true }
      )
      vim.keymap.set("v", "gA", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd([[cabbrev cc CodeCompanion]])
    end,
  },
  { -- minuet-ai
    "milanglacier/minuet-ai.nvim",
    enabled = false,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      require("minuet").setup({
        provider = "openai_fim_compatible",
        -- provider = "openai_compatible",
        provider_options = {
          openai_fim_compatible = {
            api_key = "TERM",
            name = "Ollama",
            end_point = "http://localhost:11434/v1/completions",
            model = "qwen2.5-coder:7b",
            optional = {
              max_tokens = 56,
              top_p = 0.9,
            },
            --[[ end_point = "https://api.deepseek.com/beta/completions",
            api_key = function()
              return "sk-e229a6f4cadf426ea7e3972b09d03f02"
            end,
            name = "deepseek",
            optional = {
              max_tokens = 256,
              top_p = 0.9,
            }, ]]
          },
          openai_compatible = {
            end_point = "https://api.deepseek.com",
            api_key = function()
              return "sk-e229a6f4cadf426ea7e3972b09d03f02"
            end,
            name = "deepseek",
            optional = {
              max_tokens = 256,
              top_p = 0.9,
            },
          },
        },
      })
    end,
  },
  { -- mcphub
    "ravitemer/mcphub.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
    config = function()
      require("mcphub").setup({
        --- `mcp-hub` binary related options-------------------
        config = vim.fn.expand("~/.config/mcphub/servers.json"), -- Absolute path to MCP Servers config file (will create if not exists)
        port = 37373, -- The port `mcp-hub` server listens to
        shutdown_delay = 60 * 10 * 000, -- Delay in ms before shutting down the server when last instance closes (default: 10 minutes)
        use_bundled_binary = false, -- Use local `mcp-hub` binary (set this to true when using build = "bundled_build.lua")
        mcp_request_timeout = 60000, --Max time allowed for a MCP tool or resource to execute in milliseconds, set longer for long running tasks

        ---Chat-plugin related options-----------------
        auto_approve = false, -- Auto approve mcp tool calls
        auto_toggle_mcp_servers = true, -- Let LLMs start and stop MCP servers automatically
        extensions = {
          avante = {
            make_slash_commands = true, -- make /slash commands from MCP server prompts
          },
        },

        --- Plugin specific options-------------------
        native_servers = {}, -- add your custom lua native servers here
        ui = {
          window = {
            width = 0.8, -- 0-1 (ratio); "50%" (percentage); 50 (raw number)
            height = 0.8, -- 0-1 (ratio); "50%" (percentage); 50 (raw number)
            align = "center", -- "center", "top-left", "top-right", "bottom-left", "bottom-right", "top", "bottom", "left", "right"
            relative = "editor",
            zindex = 50,
            border = "rounded", -- "none", "single", "double", "rounded", "solid", "shadow"
          },
          wo = { -- window-scoped options (vim.wo)
            winhl = "Normal:MCPHubNormal,FloatBorder:MCPHubBorder",
          },
        },
        on_ready = function(hub)
          -- Called when hub is ready
        end,
        on_error = function(err)
          -- Called on errors
        end,
        log = {
          level = vim.log.levels.WARN,
          to_file = false,
          file_path = nil,
          prefix = "MCPHub",
        },
      })
    end,
  },
}
